test_that("cal_humidex() returns expected value", {
  expect_equal(cal_humidex(e = 15, t = 28, t_unit = "celsius"), 30.775)
  expect_equal(cal_humidex(e = 10, t = 20, t_unit = "celsius"), 20)
})

test_that("cal_humidex() gives same result across temperature units", {
  c_val <- cal_humidex(e = 15, t = 28, t_unit = "celsius")
  expect_equal(cal_humidex(e = 15, t = 82.4, t_unit = "fahrenheit"), c_val, tolerance = 1e-3)
  expect_equal(cal_humidex(e = 15, t = 301.15, t_unit = "kelvin"), c_val, tolerance = 1e-3)
})

test_that("cal_humidex() is vectorised and requires t_unit", {
  expect_length(cal_humidex(e = c(15, 20), t = c(28, 30), t_unit = "celsius"), 2)
  expect_error(cal_humidex(e = 15, t = 28), "t_unit")
})
