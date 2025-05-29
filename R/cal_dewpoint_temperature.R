#' Calculate dewpoint temperature
#'
#' Calculate dewpoint temperature \eqn{T_d} (°C) from air temperature
#' \eqn{T} (°C) and relative humidity \eqn{RH} (%).
#'
#' @param rh Numeric. Relative humidity in %, from 0 to 100.
#' @param t Numeric. Air temperature in degree Celsius (°C),
#'      degree Fahrenheit (°F), or Kelvin (K).
#' @param t_unit Character string. Unit of the temperature value.
#'      Must be one of `"celsius"`, `"fahrenheit"`, or `"kelvin"`.
#'
#' @details
#' The dewpoint temperature \eqn{T_d} (°C) is the temperature at which
#' air becomes saturated (relative humidity reaches 100%).
#' This function uses the approximation derived from the Clausius–Clapeyron equation:
#'
#' \deqn{e_s = 6.108 \cdot exp(\frac{17.27 \cdot T}{T + 237.3})}
#'
#' \deqn{T_d = \frac{237.3 \cdot \ln\left(\frac{e_s \cdot RH}{611}\right)}{7.5 \cdot \ln(10) - \ln\left(\frac{e_s \cdot RH}{611}\right)}}
#'
#' where:
#' - \eqn{T} is air temperature (°C),
#' - \eqn{e_s} is the saturation vapor pressure in hPa,
#' - \eqn{RH} is relative humidity in %.
#'
#' The temperature input is converted to degree Celsius (°C) based on
#' the provided `t_unit` before calculation.
#'
#' @returns Numeric value of dewpoint temperature in degree Celsius (°C).
#' @export
#'
#' @references
#' National Weather Service. *Wet-bulb Temperature and Dewpoint Temperature from Air Temperature and Relative Humidity*.
#' Retrieved from \url{https://www.weather.gov/media/epz/wxcalc/wetBulbTdFromRh.pdf}
#'
#' @seealso [weathermetrics::humidity.to.dewpoint()],
#'      [weathermetrics::dewpoint.to.humidity()],
#'      [cal_saturation_vapor_pressure()],
#'      [cal_relative_humidity()]
#'
#' @examples
#' cal_dewpoint_temperature(rh = 39.7, t = 28, t_unit = 'celsius')
#' cal_dewpoint_temperature(rh = 42.8, t = 20, t_unit = 'celsius')
#'
cal_dewpoint_temperature <- function(rh, t, t_unit){

        if (rh < 0 | rh > 100) (stop("`rh` value must be between 0% and 100%."))

        if (missing(t_unit)) (stop("Please provide `t_unit` with 'celsius', 'fahrenheit', or 'kelvin'."))
        if (t_unit == 'celsius') t <- t
        if (t_unit == 'kelvin') t <- weathermetrics::kelvin.to.celsius(t)
        if (t_unit == 'fahrenheit') t <- weathermetrics::fahrenheit.to.celsius(t)

        es <- cal_saturation_vapor_pressure(t = t, t_unit = t_unit)
        cal_term <- (es * rh) / 611
        td = (237.3 * log(cal_term)) / (7.5 * log(10) - log(cal_term))

        return(td)
}

