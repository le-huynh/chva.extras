test_that("cal_mixing_ratio() returns expected value", {
  # 0.622 * 12 * 1000 / (1013.25 - 12)
  expect_equal(cal_mixing_ratio(e = 12, p = 1013.25), 7.454682, tolerance = 1e-6)
})

test_that("cal_mixing_ratio() is zero for dry air and vectorised", {
  expect_equal(cal_mixing_ratio(e = 0, p = 1013.25), 0)
  expect_length(cal_mixing_ratio(e = c(10, 12), p = c(1000, 1013.25)), 2)
})
