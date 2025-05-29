#' Calculate absolute humidity
#'
#' Calculate absolute humidity \eqn{\rho_v} (kg/m³) from
#' vapor pressure \eqn{e} (Pa) and temperature \eqn{t} (K).
#'
#' @param e Numeric. Vapor pressure in Pascal (Pa).
#' @param t Numeric. Air temperature in Kelvin (K), degree Celsius (°C),
#'      or degree Fahrenheit (°K).
#' @param t_unit Character string. Unit of the temperature value.
#'      Must be one of `"celsius"`, `"fahrenheit"`, or `"kelvin"`.
#'
#' @details
#' Absolute humidity \eqn{\rho_v} (kg/m³), or density of water vapor, is
#' the mass of moisture per total volume of air.
#' It is calculated using the formula:
#'
#' \deqn{\rho_v = \frac{e}{R_v \cdot T}}
#'
#' where \eqn{e} is vapor pressure (Pa), \eqn{T} is air temperature (Kelvin),
#' and \eqn{R_v} is the specific gas constant for moist air (487 J·kg⁻¹·K⁻¹).
#'
#' The temperature input is converted to Kelvin based on the provided `t_unit`
#' before calculation.
#'
#' @returns Numeric value of absolute humidity in kg/m³.
#' @export
#'
#' @references
#' Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield.
#' “Humidity: A Review and Primer on Atmospheric Moisture and Human Health.”
#' Environmental Research 144 (January 2016): 106–16.
#' [https://doi.org/10.1016/j.envres.2015.10.014](https://doi.org/10.1016/j.envres.2015.10.014).
#'
#' @examples
#' cal_absolute_humidity(e = 1200, t = 25, t_unit = "celsius")
#' cal_absolute_humidity(e = 1200, t = 298.15, t_unit = "kelvin")
#'
cal_absolute_humidity <- function(e, t, t_unit){

        if (missing(t_unit)) (stop("Please provide `t_unit` with 'celsius', 'fahrenheit', or 'kelvin'."))

        if (t_unit == 'kelvin') t <- t
        if (t_unit == 'celsius') t <- weathermetrics::celsius.to.kelvin(t)
        if (t_unit == 'fahrenheit') t <- weathermetrics::fahrenheit.to.kelvin(t)

        # specific gas constant for moist air
        Rv <- 487

        # calculate absolute_humidity
        rho_v <- e / (Rv * t)

        return(rho_v)
}

