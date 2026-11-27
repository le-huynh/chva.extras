test_that("cal_apparent_temperature() returns expected value", {
  # -2.653 + 0.994 * 28 + 0.0153 * 12^2
  expect_equal(cal_apparent_temperature(t = 28, td = 12, t_unit = "celsius"), 27.3822)
})

test_that("cal_apparent_temperature() gives same result across temperature units", {
  c_val <- cal_apparent_temperature(t = 28, td = 12, t_unit = "celsius")
  expect_equal(cal_apparent_temperature(t = 82.4, td = 53.6, t_unit = "fahrenheit"), c_val, tolerance = 1e-3)
  expect_equal(cal_apparent_temperature(t = 301.15, td = 285.15, t_unit = "kelvin"), c_val, tolerance = 1e-3)
})

test_that("cal_apparent_temperature() is vectorised and requires t_unit", {
  expect_length(cal_apparent_temperature(t = c(28, 30), td = c(12, 15), t_unit = "celsius"), 2)
  expect_error(cal_apparent_temperature(t = 28, td = 12), "t_unit")
})
