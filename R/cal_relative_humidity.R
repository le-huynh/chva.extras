#' Calculate relative humidity
#'
#' Calculate relative humidity \eqn{RH} (%) from actual and saturation values of
#' vapor pressure, mixing ratio, specific humidity, or absolute humidity.
#'
#' @param e Numeric. Actual humidity value. Can be vapor pressure, mixing ratio,
#'       specific humidity, or absolute humidity.
#' @param es Numeric. Saturation value corresponding to \code{e},
#'      using the same unit and type.
#'
#' @details
#' Relative humidity \eqn{RH} (%) quantifies the air’s proximity to saturation.
#' It is calculated using the formula:
#'
#' \deqn{RH = \frac{e}{e_s} \cdot 100 \approx \frac{w}{w_s} \cdot 100 \approx \frac{q}{q_s} \cdot 100 \approx \frac{\rho_v}{\rho_{vs}} \cdot 100}
#'
#' where \eqn{e, w, q, \rho_v} is the actual value and
#' \eqn{e_s, w_s, q_s, \rho_{vs}} is the corresponding saturation value of
#' vapor pressure, mixing ratio, specific humidity, or absolute humidity.
#'
#' @returns Numeric value of relative humidity (%).
#' @export
#'
#' @references
#' Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield.
#' “Humidity: A Review and Primer on Atmospheric Moisture and Human Health.”
#' Environmental Research 144 (January 2016): 106–16.
#' [https://doi.org/10.1016/j.envres.2015.10.014](https://doi.org/10.1016/j.envres.2015.10.014).
#'
#' @seealso [cal_saturation_vapor_pressure()], [cal_mixing_ratio()],
#'      [cal_specific_humidity()], [cal_absolute_humidity()],
#'      [weathermetrics::dewpoint.to.humidity()]
#'
#' @examples
#'
#' # Using vapor pressure (in hPa)
#' cal_relative_humidity(e = 10, es = 23.4)
#'
#' # Using specific humidity (in g/kg)
#' cal_relative_humidity(e = 7, es = 14)
#'
cal_relative_humidity <- function(e, es){

        rh <- (e / es) * 100

        return(rh)
}

