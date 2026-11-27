test_that("cal_dewpoint_temperature() returns plausible values", {
  # Saturated air: dewpoint equals air temperature
  expect_equal(cal_dewpoint_temperature(rh = 100, t = 20, t_unit = "celsius"), 20, tolerance = 1e-2)
  # Dewpoint is below air temperature when air is not saturated
  expect_lt(cal_dewpoint_temperature(rh = 39.7, t = 28, t_unit = "celsius"), 28)
  expect_equal(cal_dewpoint_temperature(rh = 39.7, t = 28, t_unit = "celsius"), 12.9, tolerance = 1e-2)
})

test_that("cal_dewpoint_temperature() gives same result across temperature units", {
  c_val <- cal_dewpoint_temperature(rh = 50, t = 20, t_unit = "celsius")
  expect_equal(cal_dewpoint_temperature(rh = 50, t = 68, t_unit = "fahrenheit"), c_val, tolerance = 1e-3)
  expect_equal(cal_dewpoint_temperature(rh = 50, t = 293.15, t_unit = "kelvin"), c_val, tolerance = 1e-3)
})

test_that("cal_dewpoint_temperature() validates inputs", {
  expect_error(cal_dewpoint_temperature(rh = 120, t = 20, t_unit = "celsius"), "between 0% and 100%")
  expect_error(cal_dewpoint_temperature(rh = -1, t = 20, t_unit = "celsius"), "between 0% and 100%")
  expect_error(cal_dewpoint_temperature(rh = c(50, 101), t = c(20, 20), t_unit = "celsius"),
               "between 0% and 100%")
  expect_error(cal_dewpoint_temperature(rh = 50, t = 20), "t_unit")
})

test_that("cal_dewpoint_temperature() is vectorised", {
  res <- cal_dewpoint_temperature(rh = c(40, 60, 80), t = c(20, 20, 20), t_unit = "celsius")
  expect_length(res, 3)
  expect_true(all(diff(res) > 0))
})
