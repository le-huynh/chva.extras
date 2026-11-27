test_that("cal_relative_humidity() returns expected value", {
  expect_equal(cal_relative_humidity(e = 10, es = 23.4), 42.73504, tolerance = 1e-6)
  expect_equal(cal_relative_humidity(e = 7, es = 14), 50)
})

test_that("cal_relative_humidity() is 100 at saturation and vectorised", {
  expect_equal(cal_relative_humidity(e = 23.4, es = 23.4), 100)
  expect_length(cal_relative_humidity(e = c(10, 12), es = c(20, 24)), 2)
})
