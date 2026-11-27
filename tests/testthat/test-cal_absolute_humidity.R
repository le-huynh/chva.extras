test_that("cal_absolute_humidity() returns expected value", {
  # 1000 / (461.5 * 293.15)
  expect_equal(cal_absolute_humidity(e = 1000, t = 20, t_unit = "celsius"),
               0.0073916, tolerance = 1e-4)
})

test_that("cal_absolute_humidity() gives same result across temperature units", {
  c_val <- cal_absolute_humidity(e = 1000, t = 20, t_unit = "celsius")
  expect_equal(cal_absolute_humidity(e = 1000, t = 68, t_unit = "fahrenheit"), c_val, tolerance = 1e-4)
  expect_equal(cal_absolute_humidity(e = 1000, t = 293.15, t_unit = "kelvin"), c_val, tolerance = 1e-4)
})

test_that("cal_absolute_humidity() is vectorised and requires t_unit", {
  expect_length(cal_absolute_humidity(e = c(1000, 1500), t = c(20, 25), t_unit = "celsius"), 2)
  expect_error(cal_absolute_humidity(e = 1000, t = 20), "t_unit")
})
