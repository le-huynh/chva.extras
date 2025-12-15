# Calculate dewpoint temperature

Calculate dewpoint temperature \\T_d\\ (°C) from air temperature \\T\\
(°C) and relative humidity \\RH\\ (%).

## Usage

``` r
cal_dewpoint_temperature(rh, t, t_unit)
```

## Arguments

- rh:

  Numeric. Relative humidity in %, from 0 to 100.

- t:

  Numeric. Air temperature in degree Celsius (°C), degree Fahrenheit
  (°F), or Kelvin (K).

- t_unit:

  Character string. Unit of the temperature value. Must be one of
  `"celsius"`, `"fahrenheit"`, or `"kelvin"`.

## Value

Numeric value of dewpoint temperature in degree Celsius (°C).

## Details

The dewpoint temperature \\T_d\\ (°C) is the temperature at which air
becomes saturated (relative humidity reaches 100%). This function uses
the approximation derived from the Clausius–Clapeyron equation:

\$\$e_s = 6.108 \cdot exp(\frac{17.27 \cdot T}{T + 237.3})\$\$

\$\$T_d = \frac{237.3 \cdot \ln\left(\frac{e_s \cdot
RH}{611}\right)}{7.5 \cdot \ln(10) - \ln\left(\frac{e_s \cdot
RH}{611}\right)}\$\$

where:

- \\T\\ is air temperature (°C),

- \\e_s\\ is the saturation vapor pressure in hPa,

- \\RH\\ is relative humidity in %.

The temperature input is converted to degree Celsius (°C) based on the
provided `t_unit` before calculation.

## References

National Weather Service. *Wet-bulb Temperature and Dewpoint Temperature
from Air Temperature and Relative Humidity*. Retrieved from
<https://www.weather.gov/media/epz/wxcalc/wetBulbTdFromRh.pdf>

## See also

[`weathermetrics::humidity.to.dewpoint()`](https://rdrr.io/pkg/weathermetrics/man/humidity.to.dewpoint.html),
[`weathermetrics::dewpoint.to.humidity()`](https://rdrr.io/pkg/weathermetrics/man/dewpoint.to.humidity.html),
[`cal_saturation_vapor_pressure()`](https://le-huynh.github.io/chva.extras/reference/cal_saturation_vapor_pressure.md),
[`cal_relative_humidity()`](https://le-huynh.github.io/chva.extras/reference/cal_relative_humidity.md)

## Examples

``` r
cal_dewpoint_temperature(rh = 39.7, t = 28, t_unit = 'celsius')
#> [1] 13.02466
cal_dewpoint_temperature(rh = 42.8, t = 20, t_unit = 'celsius')
#> [1] 6.979868
```
