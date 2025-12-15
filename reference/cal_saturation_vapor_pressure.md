# Calculate saturation vapor pressure

Calculate saturation vapor pressure \\e_s\\ (hPa) from air temperature
\\T\\ (°C).

## Usage

``` r
cal_saturation_vapor_pressure(t, t_unit)
```

## Arguments

- t:

  Numeric. Air temperature in degree Celsius (°C), degree Fahrenheit
  (°F), or Kelvin (K).

- t_unit:

  Character string. Unit of the temperature value. Must be one of
  `"celsius"`, `"fahrenheit"`, or `"kelvin"`.

## Value

Numeric value of saturation vapor pressure in hPa.

## Details

Saturation vapor pressure \\e_s\\ (hPa) is the vapor pressure of
saturated air. It is calculated using the formula:

\$\$e_s = 6.108 \cdot exp(\frac{17.27 \cdot T}{T + 237.3})\$\$

where \\T\\ is air temperature (°C).

The temperature input is converted to degree Celsius (°C) based on the
provided `t_unit` before calculation.

## References

Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield. “Humidity: A
Review and Primer on Atmospheric Moisture and Human Health.”
Environmental Research 144 (January 2016): 106–16.
<https://doi.org/10.1016/j.envres.2015.10.014>.

## Examples

``` r
cal_saturation_vapor_pressure(t = 20, t_unit = 'celsius')
#> [1] 23.38281
cal_saturation_vapor_pressure(t = 68, t_unit = 'fahrenheit')
#> [1] 23.38281
```
