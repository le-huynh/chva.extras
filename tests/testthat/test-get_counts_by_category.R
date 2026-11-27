test_that("get_counts_by_category() returns wide counts with zeros filled", {
  df <- data.frame(
    Incurred_Date = as.Date(c("2021-01-02", "2021-01-01", "2021-01-01", "2021-01-02")),
    Status = c("Open", "Open", "Closed", "Open")
  )

  res <- get_counts_by_category(df,
                                group_column = Incurred_Date,
                                count_column = Status,
                                names_prefix = "Status_")

  expect_setequal(names(res), c("Incurred_Date", "Status_Open", "Status_Closed"))
  expect_equal(res$Incurred_Date, as.Date(c("2021-01-01", "2021-01-02")))
  expect_equal(res$Status_Open, c(1, 2))
  expect_equal(res$Status_Closed, c(1, 0))
  expect_false(anyNA(res))
})
