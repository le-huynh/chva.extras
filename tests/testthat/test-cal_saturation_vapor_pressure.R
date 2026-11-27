test_that("cal_saturation_vapor_pressure() returns expected values", {
  expect_equal(cal_saturation_vapor_pressure(t = 0, t_unit = "celsius"), 6.108)
  expect_equal(cal_saturation_vapor_pressure(t = 20, t_unit = "celsius"), 23.38, tolerance = 1e-3)
})

test_that("cal_saturation_vapor_pressure() gives same result across temperature units", {
  c_val <- cal_saturation_vapor_pressure(t = 20, t_unit = "celsius")
  expect_equal(cal_saturation_vapor_pressure(t = 68, t_unit = "fahrenheit"), c_val, tolerance = 1e-3)
  expect_equal(cal_saturation_vapor_pressure(t = 293.15, t_unit = "kelvin"), c_val, tolerance = 1e-3)
})

test_that("cal_saturation_vapor_pressure() increases with temperature and requires t_unit", {
  res <- cal_saturation_vapor_pressure(t = c(0, 10, 20, 30), t_unit = "celsius")
  expect_length(res, 4)
  expect_true(all(diff(res) > 0))
  expect_error(cal_saturation_vapor_pressure(t = 20), "t_unit")
})
