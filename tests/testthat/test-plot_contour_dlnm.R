make_crosspred <- function(lag = 10) {
  chicago <- dlnm::chicagoNMMAPS
  cb <- dlnm::crossbasis(chicago$temp,
                         lag = lag,
                         argvar = list(fun = "lin"),
                         arglag = list(fun = "poly", degree = 2))
  model <- stats::glm(chicago$death ~ cb + chicago$dow,
                      family = stats::quasipoisson())
  dlnm::crosspred(cb, model, cen = 21, by = 2)
}

test_that("plot_contour_dlnm() draws a contour plot", {
  skip_if_not_installed("dlnm")
  skip_on_cran()

  pred <- make_crosspred()
  grDevices::pdf(NULL)
  withr::defer(grDevices::dev.off())

  expect_no_error(plot_contour_dlnm(pred))
  expect_no_error(plot_contour_dlnm(pred, z_range = c(0.9, 1.1), nlevels = 30,
                                    color1 = "darkgreen"))
  expect_no_error(plot_contour_dlnm(pred, exp = FALSE))
  expect_no_error(plot_contour_dlnm(pred, ci_level = 0.9))
})

test_that("plot_contour_dlnm() validates its inputs", {
  skip_if_not_installed("dlnm")
  skip_on_cran()

  pred <- make_crosspred()

  expect_error(plot_contour_dlnm(list(a = 1)), "class 'crosspred'")
  expect_error(plot_contour_dlnm(pred, ci_level = 1.5), "ci_level")
  expect_error(plot_contour_dlnm(pred, ci_level = "0.95"), "ci_level")
  expect_error(plot_contour_dlnm(pred, exp = "yes"), "logical value for 'exp'")
  expect_error(plot_contour_dlnm(make_crosspred(lag = 0)), "unlagged")
})
