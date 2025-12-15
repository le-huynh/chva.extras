# Calculate wet-bulb temperature

Calculate wet-bulb temperature \\T_w\\ (°C) from air temperature \\T\\
(°C) and dewpoint temperature \\T_d\\ (°C).

## Usage

``` r
cal_wet_bulb_temperature(t, td, t_unit)
```

## Arguments

- t, td:

  Numeric. Air temperature and dewpoint temperature in degree Celsius
  (°C), degree Fahrenheit (°F), or Kelvin (K).

- t_unit:

  Character string. Unit of the temperature values. Must be one of
  `"celsius"`, `"fahrenheit"`, or `"kelvin"`.

## Value

Numeric value of wet-bulb temperature in degree Celsius (°C).

## Details

Wet-bulb temperature \\T_w\\ (°C) is the temperature at which air
becomes saturated by evaporation at constant pressure. It is calculated
using the formula:

\$\$T_w = T_d + 1/3 \* (T - T_d)\$\$

where \\T\\ is the air temperature and \\T_d\\ is the dewpoint
temperature, in degrees Celsius (°C).

The temperature input is converted to degree Celsius (°C) based on the
provided `t_unit` before calculation.

## References

Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield. “Humidity: A
Review and Primer on Atmospheric Moisture and Human Health.”
Environmental Research 144 (January 2016): 106–16.
<https://doi.org/10.1016/j.envres.2015.10.014>.

Normand, Charles. “Energy in the Atmosphere.” Quarterly Journal of the
Royal Meteorological Society 72, no. 312–313 (April 1946): 145–67.
<https://doi.org/10.1002/qj.49707231202>.

## Examples

``` r
cal_wet_bulb_temperature(t = 28, td = 12, t_unit = "celsius")
#> [1] 17.33333
cal_wet_bulb_temperature(t = 82.4, td = 53.6, t_unit = "fahrenheit")
#> [1] 17.33333
```
