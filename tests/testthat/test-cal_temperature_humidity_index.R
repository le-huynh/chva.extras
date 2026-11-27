test_that("cal_temperature_humidity_index() returns expected value", {
  # 0.4 * (68 + 52.34) + 15
  expect_equal(cal_temperature_humidity_index(t = 68, tw = 52.34, t_unit = "fahrenheit"), 63.136)
})

test_that("cal_temperature_humidity_index() gives same result across temperature units", {
  f_val <- cal_temperature_humidity_index(t = 68, tw = 50, t_unit = "fahrenheit")
  expect_equal(cal_temperature_humidity_index(t = 20, tw = 10, t_unit = "celsius"), f_val, tolerance = 1e-3)
  expect_equal(cal_temperature_humidity_index(t = 293.15, tw = 283.15, t_unit = "kelvin"), f_val, tolerance = 1e-3)
})

test_that("cal_temperature_humidity_index() is vectorised and requires t_unit", {
  expect_length(cal_temperature_humidity_index(t = c(68, 70), tw = c(50, 55), t_unit = "fahrenheit"), 2)
  expect_error(cal_temperature_humidity_index(t = 68, tw = 50), "t_unit")
})
