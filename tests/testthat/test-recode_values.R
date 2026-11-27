test_that("recode_values() follows the documented grouping logic", {
  df <- data.frame(ID = c(1, 1, 2, 2, 3, 3, 3),
                   Gender = c("Male", "Unknown", "Female", "Female",
                              "Male", "Female", "Unknown"))

  res <- suppressMessages(
    recode_values(df, var1 = "ID", var2 = "Gender", unknown_category = "Unknown")
  ) %>%
    dplyr::arrange(ID)

  expect_named(res, c("ID", "Gender"))
  expect_equal(res$ID, c(1, 2, 3))
  # 1: one known + unknown -> known value; 2: single value kept; 3: >2 values -> unknown
  expect_equal(res$Gender, c("Male", "Female", "Unknown"))
})

test_that("recode_values() assigns unknown when two known values conflict", {
  df <- data.frame(ID = c(1, 1, 2),
                   Gender = c("Male", "Female", "Unknown"))

  res <- suppressMessages(
    recode_values(df, var1 = "ID", var2 = "Gender", unknown_category = "Unknown")
  ) %>%
    dplyr::arrange(ID)

  expect_equal(res$Gender, c("Unknown", "Unknown"))
})

test_that("recode_values() returns one row per group", {
  df <- data.frame(ID = c(1, 1, 1, 2, 3),
                   Gender = c("Male", "Male", "Male", "Female", "Unknown"))

  res <- suppressMessages(
    recode_values(df, var1 = "ID", var2 = "Gender", unknown_category = "Unknown")
  )

  expect_equal(nrow(res), 3)
  expect_equal(anyDuplicated(res$ID), 0L)
})
