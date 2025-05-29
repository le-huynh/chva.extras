#' Calculate apparent temperature
#'
#' Calculate apparent temperature \eqn{AT} (°C) from air temperature
#' \eqn{T} (°C) and dewpoint temperature \eqn{T_d} (°C).
#'
#' @param t,td Numeric. Air temperature and dewpoint temperature in degree Celsius (°C),
#'      degree Fahrenheit (°F), or Kelvin (K).
#' @param t_unit Character string. Unit of the temperature values.
#'      Must be one of `"celsius"`, `"fahrenheit"`, or `"kelvin"`.
#'
#' @details
#' Apparent temperature \eqn{AT} (°C) is an index used to assess
#' human comfort in the warm season.
#' It is calculated using the formula:
#'
#' \deqn{AT = -2.653 + 0.994 \cdot T + 0.0153 \cdot T_d^2}
#'
#' where \eqn{T} is the air temperature and \eqn{T_d} is the dewpoint temperature,
#' in degrees Celsius (°C).
#'
#' The temperature input is converted to degree Celsius (°C) based on
#' the provided `t_unit` before calculation.
#'
#' @returns Numeric value of apparent temperature in degree Celsius (°C).
#' @export
#'
#' @references
#' Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield.
#' “Humidity: A Review and Primer on Atmospheric Moisture and Human Health.”
#' Environmental Research 144 (January 2016): 106–16.
#' [https://doi.org/10.1016/j.envres.2015.10.014](https://doi.org/10.1016/j.envres.2015.10.014).
#'
#' Kalkstein, Laurence S., and Kathleen M. Valimont.
#' “An Evaluation of Summer Discomfort in the United State Using a Relative Climatological Index.”
#' Bulletin of the American Meteorological Society 67, no. 7 (July 1986): 842–48.
#' [https://doi.org/10.1175/1520-0477(1986)067<0842:AEOSDI>2.0.CO;2](https://doi.org/10.1175/1520-0477(1986)067<0842:AEOSDI>2.0.CO;2).
#'
#' @seealso [cal_dewpoint_temperature()]
#'
#' @examples
#' cal_apparent_temperature(t = 28, td = 12, t_unit = "celsius")
#' cal_apparent_temperature(t = 82.4, td = 53.6, t_unit = "fahrenheit")
#'
cal_apparent_temperature <- function(t, td, t_unit){

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

        at <- -2.653 + 0.994*t + 0.0153*td^2

        return(at)
}

