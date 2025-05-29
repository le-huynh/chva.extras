#' Calculate specific humidity
#'
#' Calculate specific humidity \eqn{q} (g/kg) from
#' vapor pressure \eqn{e} (hPa) and air pressure \eqn{p} (hPa).

#' @param e Numeric. Vapor pressure in hectoPascal (hPa).
#' @param p Numeric. Air pressure in hectoPascal (hPa).
#'
#' @details
#' Specific humidity \eqn{q} (g/kg) is defined as the mass of moisture per mass of air:
#'
#' \deqn{q = \frac{0.622 \cdot e \cdot 1000}{p - 0.378 \cdot e}}
#'
#' where \eqn{e} is the vapor pressure (hPa), and \eqn{p} is the air pressure (hPa).
#'
#' @returns Numeric value of specific humidity in g/kg.
#' @export
#'
#' @references
#' Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield.
#' “Humidity: A Review and Primer on Atmospheric Moisture and Human Health.”
#' Environmental Research 144 (January 2016): 106–16.
#' [https://doi.org/10.1016/j.envres.2015.10.014](https://doi.org/10.1016/j.envres.2015.10.014).
#'
#' @examples
#' cal_specific_humidity(e = 12, p = 1013.25)
#'
cal_specific_humidity <- function(e, p){

        q <- 0.622 * e * 1000 / (p - 0.378 * e)

        return(q)
}
