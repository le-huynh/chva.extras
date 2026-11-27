make_temp_df <- function() {
  data.frame(
    date = c("2022-03-01", "2022-08-13", "2023-02-09", "2024-09-22"),
    temp_1am = c(NA, 20, 5, 24),
    temp_6am = c(6, NA, 6, NA),
    temp_11am = c(13, 25, 8, NA),
    temp_4pm = c(18, 30, NA, 30)
  )
}
temp_cols <- c("temp_1am", "temp_6am", "temp_11am", "temp_4pm")

test_that("interpolate_na() fills interior gaps row-wise", {
  res <- interpolate_na(make_temp_df(), var1 = "date", vars2 = c("temp_1am", "temp_6am", "temp_11am", "temp_4pm"))

  expect_named(res, c("date", temp_cols))
  expect_equal(nrow(res), 4)
  # row 2: 20, NA, 25 -> 22.5
  expect_equal(res$temp_6am[res$date == "2022-08-13"], 22.5)
})

test_that("interpolate_na() does not extrapolate with rule = 1", {
  res <- interpolate_na(make_temp_df(), var1 = "date", vars2 = c("temp_1am", "temp_6am", "temp_11am", "temp_4pm"))

  expect_true(is.na(res$temp_1am[res$date == "2022-03-01"]))
  expect_true(is.na(res$temp_4pm[res$date == "2023-02-09"]))
})

test_that("interpolate_na() uses nearest value with rule = 2", {
  res <- interpolate_na(make_temp_df(), var1 = "date", vars2 = c("temp_1am", "temp_6am", "temp_11am", "temp_4pm"), rule = 2)

  expect_equal(res$temp_1am[res$date == "2022-03-01"], 6)
  expect_equal(res$temp_4pm[res$date == "2023-02-09"], 8)
})

test_that("interpolate_na() respects maxgap", {
  df <- make_temp_df()
  row4 <- df$date == "2024-09-22"

  res1 <- interpolate_na(df, var1 = "date", vars2 = c("temp_1am", "temp_6am", "temp_11am", "temp_4pm"), maxgap = 1)
  expect_true(is.na(res1$temp_6am[row4]))
  expect_true(is.na(res1$temp_11am[row4]))

  res2 <- interpolate_na(df, var1 = "date", vars2 = c("temp_1am", "temp_6am", "temp_11am", "temp_4pm"), maxgap = 2)
  expect_equal(res2$temp_6am[row4], 26)
  expect_equal(res2$temp_11am[row4], 28)
})

test_that("interpolate_na() errors on duplicate identifiers", {
  df <- make_temp_df()
  df$date[2] <- df$date[1]

  expect_error(interpolate_na(df, var1 = "date", vars2 = c("temp_1am", "temp_6am", "temp_11am", "temp_4pm")),
               "Duplicate values detected")
})
