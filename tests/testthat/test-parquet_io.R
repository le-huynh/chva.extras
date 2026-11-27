# Tests for get_parquet_arrow(), get_parquet_by_chunk(), get_dataset(),
# check_overview() and delete_csv(). All files live in a temporary directory.

test_that("get_parquet_arrow() converts CSV folders matching the pattern", {
  root <- withr::local_tempdir()
  dir.create(file.path(root, "city_A_1"))
  dir.create(file.path(root, "city_B_1"))
  utils::write.csv(mtcars, file.path(root, "city_A_1", "data.csv"), row.names = FALSE)
  utils::write.csv(mtcars, file.path(root, "city_B_1", "data.csv"), row.names = FALSE)

  get_parquet_arrow(folder_path = root, pattern = "city_A")

  pq_a <- list.files(file.path(root, "city_A_1"), pattern = "\\.parquet$", full.names = TRUE)
  pq_b <- list.files(file.path(root, "city_B_1"), pattern = "\\.parquet$")
  expect_length(pq_a, 1)
  expect_length(pq_b, 0)

  res <- as.data.frame(arrow::read_parquet(pq_a))
  expect_equal(nrow(res), nrow(mtcars))
  expect_equal(res$mpg, mtcars$mpg)
})

test_that("get_parquet_arrow() splits output by max_rows_per_file", {
  root <- withr::local_tempdir()
  dir.create(file.path(root, "city_A_1"))
  utils::write.csv(mtcars, file.path(root, "city_A_1", "data.csv"), row.names = FALSE)

  get_parquet_arrow(folder_path = root, pattern = "city_A", max_rows_per_file = 10)

  pq <- list.files(file.path(root, "city_A_1"), pattern = "\\.parquet$", full.names = TRUE)
  expect_length(pq, 4) # 32 rows / 10
  expect_equal(sum(purrr::map_int(pq, ~ nrow(arrow::read_parquet(.x)))), nrow(mtcars))
})

test_that("get_parquet_by_chunk() writes one set of files per chunk", {
  root <- withr::local_tempdir()
  input <- file.path(root, "input.csv")
  out <- file.path(root, "out")
  df <- data.frame(id = 1:10, value = letters[1:10])
  utils::write.csv(df, input, row.names = FALSE)

  get_parquet_by_chunk(input_path = input,
                       output_folder = out,
                       chunk_no = 0:2,
                       nrows_to_read = 4,
                       column_names = c("id", "value"))

  expect_setequal(list.files(out),
                  c("part0-0.parquet", "part1-0.parquet", "part2-0.parquet"))

  res <- as.data.frame(arrow::open_dataset(out)) %>% dplyr::arrange(id)
  expect_named(res, c("id", "value"))
  expect_equal(res$id, 1:10)
  expect_equal(res$value, letters[1:10])
})

make_parquet_folder <- function(root) {
  arrow::write_parquet(mtcars, file.path(root, "Facility_A.parquet"))
  arrow::write_parquet(mtcars[1:5, ], file.path(root, "Facility_B.parquet"))
  arrow::write_parquet(iris, file.path(root, "Facility_C.parquet"))
  arrow::write_parquet(mtcars, file.path(root, "Other.parquet"))
  root
}

test_that("get_dataset() returns a named list of Arrow Datasets", {
  root <- make_parquet_folder(withr::local_tempdir())

  res <- get_dataset(folder_path = root, pattern = "Facility")

  expect_type(res, "list")
  expect_named(res, c("Facility_A.parquet", "Facility_B.parquet", "Facility_C.parquet"))
  expect_true(all(purrr::map_lgl(res, ~ inherits(.x, "Dataset"))))
  expect_equal(nrow(res[["Facility_B.parquet"]]), 5)
})

test_that("check_overview() summarises rows, columns and column-name match", {
  root <- make_parquet_folder(withr::local_tempdir())

  res <- check_overview(folder_path = root, pattern = "Facility")

  expect_named(res, c("name", "nrow", "ncol", "matched_column_names"))
  expect_equal(unname(res$nrow), c(32, 5, 150))
  expect_equal(unname(res$ncol), c(11, 11, 5))
  expect_equal(unname(res$matched_column_names), c(TRUE, TRUE, FALSE))
})

test_that("delete_csv() removes only CSV files in matching folders", {
  root <- withr::local_tempdir()
  dir.create(file.path(root, "Facility_1"))
  dir.create(file.path(root, "Other_1"))
  utils::write.csv(mtcars, file.path(root, "Facility_1", "a.csv"))
  utils::write.csv(mtcars, file.path(root, "Facility_1", "b.csv"))
  arrow::write_parquet(mtcars, file.path(root, "Facility_1", "part-0.parquet"))
  utils::write.csv(mtcars, file.path(root, "Other_1", "c.csv"))

  delete_csv(folder_path = root, pattern = "Facility")

  expect_equal(list.files(file.path(root, "Facility_1")), "part-0.parquet")
  expect_equal(list.files(file.path(root, "Other_1")), "c.csv")
})
