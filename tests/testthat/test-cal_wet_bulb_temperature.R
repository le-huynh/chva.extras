test_that("cal_wet_bulb_temperature() returns expected value", {
  expect_equal(cal_wet_bulb_temperature(t = 28, td = 12, t_unit = "celsius"), 12 + 16 / 3)
  # Saturated air: wet-bulb equals air temperature
  expect_equal(cal_wet_bulb_temperature(t = 20, td = 20, t_unit = "celsius"), 20)
})

test_that("cal_wet_bulb_temperature() gives same result across temperature units", {
  c_val <- cal_wet_bulb_temperature(t = 28, td = 12, t_unit = "celsius")
  expect_equal(cal_wet_bulb_temperature(t = 82.4, td = 53.6, t_unit = "fahrenheit"), c_val, tolerance = 1e-3)
  expect_equal(cal_wet_bulb_temperature(t = 301.15, td = 285.15, t_unit = "kelvin"), c_val, tolerance = 1e-3)
})

test_that("cal_wet_bulb_temperature() is vectorised and requires t_unit", {
  expect_length(cal_wet_bulb_temperature(t = c(28, 30), td = c(12, 15), t_unit = "celsius"), 2)
  expect_error(cal_wet_bulb_temperature(t = 28, td = 12), "t_unit")
})
