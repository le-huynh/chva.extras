test_that("check_unique_value() counts unique values in a column", {
  res <- check_unique_value(mtcars, column_to_check = cyl)

  expect_s3_class(res, "data.frame")
  expect_named(res, c("cyl", "n"))
  expect_equal(res$cyl, c(4, 6, 8))
  expect_equal(res$n, c(11L, 7L, 14L))
})

test_that("check_unique_value() works on an Arrow Table", {
  res <- check_unique_value(arrow::arrow_table(mtcars), column_to_check = cyl)

  expect_equal(res$cyl, c(4, 6, 8))
  expect_equal(res$n, c(11L, 7L, 14L))
})

test_that("check_unique_value_overview() flags consistent values", {
  res_list <- list(data1 = mtcars, data2 = mtcars) %>%
    purrr::map(check_unique_value, column_to_check = cyl)

  res <- check_unique_value_overview(res_list, column_to_check = cyl)

  expect_named(res, c("name", "unique_val_number", "matched_unique_val"))
  expect_equal(res$name, c("data1", "data2"))
  expect_equal(unname(res$unique_val_number), c(3, 3))
  expect_true(all(res$matched_unique_val))
})

test_that("check_unique_value_overview() flags inconsistent values", {
  res_list <- list(data1 = mtcars, data2 = mtcars[mtcars$cyl != 8, ]) %>%
    purrr::map(check_unique_value, column_to_check = cyl)

  res <- check_unique_value_overview(res_list, column_to_check = cyl)

  expect_equal(unname(res$unique_val_number), c(3, 2))
  expect_equal(unname(res$matched_unique_val), c(TRUE, FALSE))
})
