% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cal_absolute_humidity.R
\name{cal_absolute_humidity}
\alias{cal_absolute_humidity}
\title{Calculate absolute humidity}
\usage{
cal_absolute_humidity(e, t, t_unit)
}
\arguments{
\item{e}{Numeric. Vapor pressure in Pascal (Pa).}

\item{t}{Numeric. Air temperature in Kelvin (K), degree Celsius (°C),
or degree Fahrenheit (°K).}

\item{t_unit}{Character string. Unit of the temperature value.
Must be one of \code{"celsius"}, \code{"fahrenheit"}, or \code{"kelvin"}.}
}
\value{
Numeric value of absolute humidity in kg/m³.
}
\description{
Calculate absolute humidity \eqn{\rho_v} (kg/m³) from
vapor pressure \eqn{e} (Pa) and temperature \eqn{t} (K).
}
\details{
Absolute humidity \eqn{\rho_v} (kg/m³), or density of water vapor, is
the mass of moisture per total volume of air.
It is calculated using the formula:

\deqn{\rho_v = \frac{e}{R_v \cdot T}}

where \eqn{e} is vapor pressure (Pa), \eqn{T} is air temperature (Kelvin),
and \eqn{R_v} is the specific gas constant for moist air (461.5 J·kg⁻¹·K⁻¹).

The temperature input is converted to Kelvin based on the provided \code{t_unit}
before calculation.
}
\examples{
cal_absolute_humidity(e = 1000, t = 20, t_unit = "celsius")
cal_absolute_humidity(e = 1000, t = 68, t_unit = "fahrenheit")
cal_absolute_humidity(e = 1500, t = 298.15, t_unit = "kelvin")

}
\references{
Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield.
“Humidity: A Review and Primer on Atmospheric Moisture and Human Health.”
Environmental Research 144 (January 2016): 106–16.
\url{https://doi.org/10.1016/j.envres.2015.10.014}.
}
