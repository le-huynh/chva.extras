#' Calculate saturation vapor pressure
#'
#' Calculate saturation vapor pressure \eqn{e_s} (hPa) from air temperature
#' \eqn{T} (°C).
#'
#' @param t Numeric. Air temperature in degree Celsius (°C),
#'      degree Fahrenheit (°F), or Kelvin (K).
#' @param t_unit Character string. Unit of the temperature value.
#'      Must be one of `"celsius"`, `"fahrenheit"`, or `"kelvin"`.
#'
#' @details
#' Saturation vapor pressure \eqn{e_s} (hPa) is the vapor pressure of saturated air.
#' It is calculated using the formula:
#'
#' \deqn{e_s = 6.108 \cdot exp(\frac{17.27 \cdot T}{T + 237.3})}
#'
#' where \eqn{T} is air temperature (°C).
#'
#' The temperature input is converted to degree Celsius (°C) based on
#' the provided `t_unit` before calculation.
#'
#' @returns Numeric value of saturation vapor pressure in hPa.
#' @export
#'
#' @references
#' Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield.
#' “Humidity: A Review and Primer on Atmospheric Moisture and Human Health.”
#' Environmental Research 144 (January 2016): 106–16.
#' [https://doi.org/10.1016/j.envres.2015.10.014](https://doi.org/10.1016/j.envres.2015.10.014).
#'
#' @examples
#' cal_saturation_vapor_pressure(t = 20, t_unit = 'celsius')
#' cal_saturation_vapor_pressure(t = 68, t_unit = 'fahrenheit')
#'
cal_saturation_vapor_pressure <- function(t, t_unit){

        if (missing(t_unit)) (stop("Please provide `t_unit` with 'celsius', 'fahrenheit', or 'kelvin'."))

        if (t_unit == 'celsius') t <- t
        if (t_unit == 'kelvin') t <- weathermetrics::kelvin.to.celsius(t)
        if (t_unit == 'fahrenheit') t <- weathermetrics::fahrenheit.to.celsius(t)

        t_term <- (17.27 * t) / (t + 237.3)
        es <- 6.108 * exp(t_term)

        return(es)
}

