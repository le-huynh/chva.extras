# Calculate absolute humidity

Calculate absolute humidity \\\rho_v\\ (kg/m³) from vapor pressure \\e\\
(Pa) and temperature \\t\\ (K).

## Usage

``` r
cal_absolute_humidity(e, t, t_unit)
```

## Arguments

- e:

  Numeric. Vapor pressure in Pascal (Pa).

- t:

  Numeric. Air temperature in Kelvin (K), degree Celsius (°C), or degree
  Fahrenheit (°K).

- t_unit:

  Character string. Unit of the temperature value. Must be one of
  `"celsius"`, `"fahrenheit"`, or `"kelvin"`.

## Value

Numeric value of absolute humidity in kg/m³.

## Details

Absolute humidity \\\rho_v\\ (kg/m³), or density of water vapor, is the
mass of moisture per total volume of air. It is calculated using the
formula:

\$\$\rho_v = \frac{e}{R_v \cdot T}\$\$

where \\e\\ is vapor pressure (Pa), \\T\\ is air temperature (Kelvin),
and \\R_v\\ is the specific gas constant for moist air (461.5
J·kg⁻¹·K⁻¹).

The temperature input is converted to Kelvin based on the provided
`t_unit` before calculation.

## References

Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield. “Humidity: A
Review and Primer on Atmospheric Moisture and Human Health.”
Environmental Research 144 (January 2016): 106–16.
<https://doi.org/10.1016/j.envres.2015.10.014>.

## Examples

``` r
cal_absolute_humidity(e = 1000, t = 20, t_unit = "celsius")
#> [1] 0.007391599
cal_absolute_humidity(e = 1000, t = 68, t_unit = "fahrenheit")
#> [1] 0.007391599
cal_absolute_humidity(e = 1500, t = 298.15, t_unit = "kelvin")
#> [1] 0.01090146
```
