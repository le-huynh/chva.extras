# Calculate apparent temperature

Calculate apparent temperature \\AT\\ (°C) from air temperature \\T\\
(°C) and dewpoint temperature \\T_d\\ (°C).

## Usage

``` r
cal_apparent_temperature(t, td, t_unit)
```

## Arguments

- t, td:

  Numeric. Air temperature and dewpoint temperature in degree Celsius
  (°C), degree Fahrenheit (°F), or Kelvin (K).

- t_unit:

  Character string. Unit of the temperature values. Must be one of
  `"celsius"`, `"fahrenheit"`, or `"kelvin"`.

## Value

Numeric value of apparent temperature in degree Celsius (°C).

## Details

Apparent temperature \\AT\\ (°C) is an index used to assess human
comfort in the warm season. It is calculated using the formula:

\$\$AT = -2.653 + 0.994 \cdot T + 0.0153 \cdot T_d^2\$\$

where \\T\\ is the air temperature and \\T_d\\ is the dewpoint
temperature, in degrees Celsius (°C).

The temperature input is converted to degree Celsius (°C) based on the
provided `t_unit` before calculation.

## References

Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield. “Humidity: A
Review and Primer on Atmospheric Moisture and Human Health.”
Environmental Research 144 (January 2016): 106–16.
<https://doi.org/10.1016/j.envres.2015.10.014>.

Kalkstein, Laurence S., and Kathleen M. Valimont. “An Evaluation of
Summer Discomfort in the United State Using a Relative Climatological
Index.” Bulletin of the American Meteorological Society 67, no. 7 (July
1986): 842–48.
<https://doi.org/10.1175/1520-0477(1986)067%3C0842:AEOSDI%3E2.0.CO;2>.

## See also

[`cal_dewpoint_temperature()`](https://le-huynh.github.io/chva.extras/reference/cal_dewpoint_temperature.md)

## Examples

``` r
cal_apparent_temperature(t = 28, td = 12, t_unit = "celsius")
#> [1] 27.3822
cal_apparent_temperature(t = 82.4, td = 53.6, t_unit = "fahrenheit")
#> [1] 27.3822
```
