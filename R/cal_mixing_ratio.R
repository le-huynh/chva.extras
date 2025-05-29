#' Calculate mixing ratio
#'
#' Calculate mixing ratio \eqn{w} (g/kg) from
#' vapor pressure \eqn{e} (hPa) and air pressure \eqn{p} (hPa).

#' @param e Numeric. Vapor pressure in hectoPascal (hPa).
#' @param p Numeric. Air pressure in hectoPascal (hPa).
#'
#' @details
#' Mixing ratio \eqn{w} (g/kg) is defined as the mass of moisture per mass of
#' dry air:
#'
#' \deqn{q = \frac{0.622 \cdot e \cdot 1000}{p - e}}
#'
#' where \eqn{e} is the vapor pressure (hPa), and \eqn{p} is the air pressure (hPa).
#'
#' @returns Numeric value of mixing ratio in g/kg.
#' @export
#'
#' @references
#' Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield.
#' “Humidity: A Review and Primer on Atmospheric Moisture and Human Health.”
#' Environmental Research 144 (January 2016): 106–16.
#' [https://doi.org/10.1016/j.envres.2015.10.014](https://doi.org/10.1016/j.envres.2015.10.014).
#'
#' @examples
#' cal_mixing_ratio(e = 12, p = 1013.25)
#'
cal_mixing_ratio <- function(e, p){

        w <- 0.622 * e * 1000 / (p - e)

        return(w)
}
