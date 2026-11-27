test_that("cal_specific_humidity() returns expected value", {
  # 0.622 * 12 * 1000 / (1013.25 - 0.378 * 12)
  expect_equal(cal_specific_humidity(e = 12, p = 1013.25), 7.399521, tolerance = 1e-6)
})

test_that("cal_specific_humidity() is below mixing ratio and vectorised", {
  expect_lt(cal_specific_humidity(e = 12, p = 1013.25), cal_mixing_ratio(e = 12, p = 1013.25))
  expect_equal(cal_specific_humidity(e = 0, p = 1013.25), 0)
  expect_length(cal_specific_humidity(e = c(10, 12), p = c(1000, 1013.25)), 2)
})
