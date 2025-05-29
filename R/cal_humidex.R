#' Calculate Humidex
#'
#' Calculate Humidex \eqn{H_x} (°C) from vapor pressure \eqn{e} (hPa) and
#' air temperature \eqn{T} (°C).
#'
#' @param e Numeric. Vapor pressure in hectoPascal (hPa).
#' @param t Numeric. Air temperature in degree Celsius (°C),
#'      degree Fahrenheit (°F), or Kelvin (K).
#' @param t_unit Character string. Unit of the temperature value.
#'      Must be one of `"celsius"`, `"fahrenheit"`, or `"kelvin"`.
#'
#' @details
#' The Humidex \eqn{H_x} (°C) is calculated using the formula:
#'
#' \deqn{H_x = T + 0.555 \cdot (e - 10)}
#'
#' where \eqn{e} is the vapor pressure (hPa), and \eqn{T} is the air temperature (°C).
#'
#' The temperature input is converted to degree Celsius (°C) based on
#' the provided `t_unit` before calculation.
#'
#' @returns Numeric value of humidex in degree Celsius (°C).
#' @export
#'
#' @references
#' Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield.
#' “Humidity: A Review and Primer on Atmospheric Moisture and Human Health.”
#' Environmental Research 144 (January 2016): 106–16.
#' [https://doi.org/10.1016/j.envres.2015.10.014](https://doi.org/10.1016/j.envres.2015.10.014).
#'
#' Masterton, J.M., and Richardson, F.A.
#' “HUMIDEX: A Method of Quantifying Human Discomfort Due to Excessive Heat and Humidity.”
#' CLI 1-79 (1979). Environment Canada, Atmospheric Environment Service Downsview, Ontario.
#'
#' @examples
#' cal_humidex(e = 15, t = 28, t_unit = "celsius")
#' cal_humidex(e = 10, t = 20, t_unit = "celsius")
#'
cal_humidex <- function(e, t, t_unit){

        if (missing(t_unit)) (stop("Please provide `t_unit` with 'celsius', 'fahrenheit', or 'kelvin'."))
        if (t_unit == 'celsius') t <- t
        if (t_unit == 'kelvin') t <- weathermetrics::kelvin.to.celsius(t)
        if (t_unit == 'fahrenheit') t <- weathermetrics::fahrenheit.to.celsius(t)

        hx <- t + 0.555 * (e - 10)

        return(hx)
}

