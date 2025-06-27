#' Calculate wet-bulb temperature
#'
#' Calculate wet-bulb temperature \eqn{T_w} (°C) from air temperature
#' \eqn{T} (°C) and dewpoint temperature \eqn{T_d} (°C).
#'
#' @param t,td Numeric. Air temperature and dewpoint temperature in degree Celsius (°C),
#'      degree Fahrenheit (°F), or Kelvin (K).
#' @param t_unit Character string. Unit of the temperature values.
#'      Must be one of `"celsius"`, `"fahrenheit"`, or `"kelvin"`.
#'
#' @details
#' Wet-bulb temperature \eqn{T_w} (°C) is the temperature at which air becomes
#' saturated by evaporation at constant pressure.
#' It is calculated using the formula:
#'
#' \deqn{T_w = T_d + 1/3 * (T - T_d)}
#'
#' where \eqn{T} is the air temperature and \eqn{T_d} is the dewpoint temperature,
#' in degrees Celsius (°C).
#'
#' The temperature input is converted to degree Celsius (°C) based on
#' the provided `t_unit` before calculation.
#'
#' @returns Numeric value of wet-bulb temperature in degree Celsius (°C).
#' @export
#'
#' @references
#' Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield.
#' “Humidity: A Review and Primer on Atmospheric Moisture and Human Health.”
#' Environmental Research 144 (January 2016): 106–16.
#' [https://doi.org/10.1016/j.envres.2015.10.014](https://doi.org/10.1016/j.envres.2015.10.014).
#'
#' Normand, Charles.
#' “Energy in the Atmosphere.”
#' Quarterly Journal of the Royal Meteorological Society 72, no. 312–313 (April 1946): 145–67.
#' [https://doi.org/10.1002/qj.49707231202](https://doi.org/10.1002/qj.49707231202).
#'
#' @examples
#' cal_wet_bulb_temperature(t = 28, td = 12, t_unit = "celsius")
#' cal_wet_bulb_temperature(t = 82.4, td = 53.6, t_unit = "fahrenheit")
#'
cal_wet_bulb_temperature <- function(t, td, t_unit){

        if (missing(t_unit)) (stop("Please provide `t_unit` with 'celsius', 'fahrenheit', or 'kelvin'."))

        if (t_unit == 'celsius') {
                t <- t
                td <- td
        }

        if (t_unit == 'kelvin') {
                t <- weathermetrics::kelvin.to.celsius(t)
                td <- weathermetrics::kelvin.to.celsius(td)
        }
        if (t_unit == 'fahrenheit') {
                t <- weathermetrics::fahrenheit.to.celsius(t)
                td <- weathermetrics::fahrenheit.to.celsius(td)
        }

        tw <- td + 1/3*(t-td)

        return(tw)
}

