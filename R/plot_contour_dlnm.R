#' Generate a filled contour plot for DLNM output with custom color levels
#'
#' This function is a modified version of [dlnm::plot.crosspred()]
#' from the \pkg{dlnm} package.
#' It generates a filled contour plot to visualize the estimated
#' exposure-lag-response association from a distributed lag non-linear model
#' (DLNM) object of class \code{"crosspred"}.
#'
#' This function builds on [dlnm::plot.crosspred()] from
#' the \pkg{dlnm} package, adding the ability to customize z-scale color levels
#' via \code{z_range}, \code{nlevels}, and \code{color*}, which are set
#' automatically in the original implementation.
#'
#' @param x An object of class "crosspred", typically generated using
#'      \code{\link[dlnm]{crosspred}}.
#' @param z_range Optional numeric vector specifying the range of values
#'      for the contour levels. If \code{NULL}, the range defaults to the
#'      same automatic setting used in [dlnm::plot.crosspred()].
#' @param nlevels Integer. The number of contour levels to display. Default is 20.
#' @param color1 Character string. Color used for negative (below reference) effects.
#'      Default is \code{"blue"}.
#' @param color2 Character string. Color used for positive (above reference) effects.
#'      Default is \code{"red"}.
#' @param color3 Character string. Color used for the reference effect level.
#'      Default is \code{"white"}.
#' @param ci_level Numeric. A value between 0 and 1 specifying the confidence level.
#'      Defaults to the \code{ci_level} stored in the \code{x} object.
#' @param exp Logical. Indicating whether to exponentiate the estimates
#'      (e.g., for relative risks).
#'      If \code{NULL}, exponentiation is automatically applied for log or logit link models.
#' @param ... Additional graphical parameters passed to
#'      [graphics::filled.contour()].
#'
#' @details
#' Generate a contour plot of predicted effects over the predictor-lag space.
#' Additional graphical options like \code{plot.title}, \code{plot.axes},
#' and \code{key.title} can be provided to adjust titles and axis/key labels.
#' When \code{z_range} is not provided, the function produces a contour plot
#' identical to that returned by [dlnm::plot.crosspred()].
#'
#' @returns A filled contour plot.
#' @export
#'
#' @references
#' Gasparrini A.
#' “Distributed lag linear and non-linear models in R: the package dlnm.”
#' Journal of Statistical Software. 2011; 43(8):1-20.
#' [https://doi.org/10.18637/jss.v043.i08](https://doi.org/10.18637/jss.v043.i08).
#'
#' @seealso [dlnm::crosspred()], [dlnm::plot.crosspred()], [graphics::filled.contour()]
#'
#' @examples
#' # Fit a model and generate "crosspred" object
#' library(dlnm)
#' library(splines)
#'
#' cb.pm <- crossbasis(chicagoNMMAPS$pm10,
#'                     lag = 7,
#'                     argvar = list(fun = "lin"),
#'                     arglag = list(fun = "strata"))
#'
#' varknots <- equalknots(chicagoNMMAPS$temp, fun = "bs", df = 5, degree = 2)
#' lagknots <- logknots(30, 3)
#' cb.temp <- crossbasis(chicagoNMMAPS$temp,
#'                       lag = 30,
#'                       argvar = list(fun = "bs", knots = varknots),
#'                       arglag = list(knots = lagknots))
#'
#' model <- glm(death ~ cb.pm + cb.temp + ns(time, 7*14) + dow,
#'              family = quasipoisson(),
#'              data = chicagoNMMAPS)
#'
#' pred.pm <- crosspred(cb.temp, model, cen = 21, by = 1)
#'
#' # When `z_range` is not provided, the function produces a contour plot
#' # identical to that returned by `dlnm::plot.crosspred()`.
#' plot_contour_dlnm(pred.pm,
#'                   xlab = "Temperature",
#'                   key.title = title("RR"),
#'                   plot.title = title("Contour plot",
#'                                      xlab = "Temperature",
#'                                      ylab = "Lag"))
#'
#' # Change `z_range` and `nlevels` to get user-defined color levels.
#' plot_contour_dlnm(pred.pm,
#'                   z_range = c(0.85, 1.4),
#'                   nlevels = 30,
#'                   xlab = "Temperature",
#'                   key.title = title("RR"),
#'                   plot.title = title("Contour plot",
#'                                      xlab = "Temperature",
#'                                      ylab = "Lag"))
#'
#' # Customize colors
#' plot_contour_dlnm(pred.pm,
#'                   z_range = c(0.85, 1.4),
#'                   nlevels = 30,
#'                   color1 = "darkgreen",
#'                   xlab = "Temperature",
#'                   key.title = title("RR"),
#'                   plot.title = title("Contour plot",
#'                                      xlab = "Temperature",
#'                                      ylab = "Lag"))

plot_contour_dlnm <- function(x,
                              z_range = NULL,
                              nlevels = 20,
                              color1 = "blue",
                              color2 = "red",
                              color3 = "white",
                              ci_level = x$ci.level,
                              exp = NULL,
                              ...) {

  # Check that input is of class 'crosspred' (required from DLNM package)
  if (all(class(x) != "crosspred")) stop("Please provide an object of class 'crosspred' for 'x'.")

  # Stop if there is no lag structure (i.e., lag = 0)
  if (x$lag[2] == 0) stop("Contour plot cannot be generated for unlagged associations.")

  # Validate confidence interval level
  if (!is.numeric(ci_level) || ci_level >= 1 || ci_level <= 0) {
    stop("Please provide a numeric 'ci_level' value between 0 and 1.")
  }

  # Check that 'exp' is logical if provided
  if (!is.null(exp) && !is.logical(exp)) stop("Please provide logical value for 'exp'.")

  # Compute confidence intervals
  z_level <- stats::qnorm(1 - (1 - ci_level) / 2)
  x$mathigh <- x$matfit + z_level * x$matse
  x$matlow <- x$matfit - z_level * x$matse
  x$allhigh <- x$allfit + z_level * x$allse
  x$alllow <- x$allfit - z_level * x$allse
  no_effect <- 0

  # If model uses log or logit link (or user requests), exponentiate the estimates
  if ((is.null(exp) && !is.null(x$model.link) && x$model.link %in% c("log", "logit")) ||
    (!is.null(exp) && exp == TRUE)) {
    x$matfit <- exp(x$matfit)
    x$mathigh <- exp(x$mathigh)
    x$matlow <- exp(x$matlow)
    x$allfit <- exp(x$allfit)
    x$allhigh <- exp(x$allhigh)
    x$alllow <- exp(x$alllow)
    no_effect <- 1 # at reference value, relative risk = 1
  }

  # Set contour levels based on fitted matrix or user-specified range
  if (is.null(z_range)) {
    levels <- pretty(x$matfit, 20)
  } else {
    levels <- pretty(z_range, nlevels)
  }

  # Define color palette: one for below and one for above the no-effect line
  col1 <- grDevices::colorRampPalette(c(color1, color3))
  col2 <- grDevices::colorRampPalette(c(color3, color2))
  col <- c(col1(sum(levels < no_effect)), col2(sum(levels > no_effect)))

  # Plot filled contour
  graphics::filled.contour(
    x = x$predvar,
    y = seq(from = x$lag[1], to = x$lag[2], by = x$bylag),
    z = x$matfit,
    col = col,
    levels = levels,
    nlevels = nlevels,
    ...)
}

