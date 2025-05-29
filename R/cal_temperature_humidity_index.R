#' Calculate temperature-humidity index
#'
#' Calculate temperature-humidity index \eqn{THI} (°F) from air temperature
#' \eqn{T} (°F) and wet-bulb temperature \eqn{T_w} (°F).
#'
#' @param t,tw Numeric. Air temperature and wet-bulb temperature in degree Celsius (°C),
#'      degree Fahrenheit (°F), or Kelvin (K).
#' @param t_unit Character string. Unit of the temperature values.
#'      Must be one of `"celsius"`, `"fahrenheit"`, or `"kelvin"`.
#'
#' @details
#' Temperature-humidity index \eqn{THI} (°F), or “discomfort index”, is an
#' index used to assess human comfort.
#' It is calculated using the formula:
#'
#' \deqn{THI = 0.4 \cdot (T + T_w) + 15}
#'
#' where \eqn{T} is the air temperature and \eqn{T_w} is the wet-bulb temperature,
#' in degrees Fahrenheit (°F).
#'
#' The temperature input is converted to degree Fahrenheit (°F) based on
#' the provided `t_unit` before calculation.
#'
#' @returns Numeric value of temperature-humidity index in degree Fahrenheit (°F).
#' @export
#'
#' @references
#' Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield.
#' “Humidity: A Review and Primer on Atmospheric Moisture and Human Health.”
#' Environmental Research 144 (January 2016): 106–16.
#' [https://doi.org/10.1016/j.envres.2015.10.014](https://doi.org/10.1016/j.envres.2015.10.014).
#'
#' Thom, E. C. “The Discomfort Index.” Weatherwise 12, no. 2 (April 1959): 57–61.
#' [https://doi.org/10.1080/00431672.1959.9926960](https://doi.org/10.1080/00431672.1959.9926960).
#'
#' @seealso [psychrolib::GetTWetBulbFromHumRatio()],
#'      [psychrolib::GetTWetBulbFromRelHum()],
#'      [psychrolib::GetTWetBulbFromTDewPoint()]
#'
#' @examples
#' cal_temperature_humidity_index(t = 68, tw = 52.34, t_unit = 'fahrenheit')
#' cal_temperature_humidity_index(t = 20, tw = 11.3, t_unit = 'celsius')
#'
cal_temperature_humidity_index <- function(t, tw, t_unit){

        if (missing(t_unit)) (stop("Please provide `t_unit` with 'fahrenheit', 'celsius', or 'kelvin'."))

        if (t_unit == 'fahrenheit') {
                t <- t
                tw <- tw
        }

        if (t_unit == 'kelvin') {
                t <- weathermetrics::kelvin.to.fahrenheit(t)
                tw <- weathermetrics::kelvin.to.fahrenheit(tw)
        }
        if (t_unit == 'celsius') {
                t <- weathermetrics::celsius.to.fahrenheit(t)
                tw <- weathermetrics::celsius.to.fahrenheit(tw)
        }

        thi <- 0.4 * (t + tw) + 15

        return(thi)
}

