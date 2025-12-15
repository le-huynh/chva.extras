# Calculate temperature-humidity index

Calculate temperature-humidity index \\THI\\ (°F) from air temperature
\\T\\ (°F) and wet-bulb temperature \\T_w\\ (°F).

## Usage

``` r
cal_temperature_humidity_index(t, tw, t_unit)
```

## Arguments

- t, tw:

  Numeric. Air temperature and wet-bulb temperature in degree Celsius
  (°C), degree Fahrenheit (°F), or Kelvin (K).

- t_unit:

  Character string. Unit of the temperature values. Must be one of
  `"celsius"`, `"fahrenheit"`, or `"kelvin"`.

## Value

Numeric value of temperature-humidity index in degree Fahrenheit (°F).

## Details

Temperature-humidity index \\THI\\ (°F), or “discomfort index”, is an
index used to assess human comfort. It is calculated using the formula:

\$\$THI = 0.4 \cdot (T + T_w) + 15\$\$

where \\T\\ is the air temperature and \\T_w\\ is the wet-bulb
temperature, in degrees Fahrenheit (°F).

The temperature input is converted to degree Fahrenheit (°F) based on
the provided `t_unit` before calculation.

## References

Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield. “Humidity: A
Review and Primer on Atmospheric Moisture and Human Health.”
Environmental Research 144 (January 2016): 106–16.
<https://doi.org/10.1016/j.envres.2015.10.014>.

Thom, E. C. “The Discomfort Index.” Weatherwise 12, no. 2 (April 1959):
57–61. <https://doi.org/10.1080/00431672.1959.9926960>.

## See also

`psychrolib::GetTWetBulbFromHumRatio()`,
`psychrolib::GetTWetBulbFromRelHum()`,
`psychrolib::GetTWetBulbFromTDewPoint()`

## Examples

``` r
cal_temperature_humidity_index(t = 68, tw = 52.34, t_unit = 'fahrenheit')
#> [1] 63.136
cal_temperature_humidity_index(t = 20, tw = 11.3, t_unit = 'celsius')
#> [1] 63.136
```
