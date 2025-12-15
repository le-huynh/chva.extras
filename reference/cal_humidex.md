# Calculate Humidex

Calculate Humidex \\H_x\\ (°C) from vapor pressure \\e\\ (hPa) and air
temperature \\T\\ (°C).

## Usage

``` r
cal_humidex(e, t, t_unit)
```

## Arguments

- e:

  Numeric. Vapor pressure in hectoPascal (hPa).

- t:

  Numeric. Air temperature in degree Celsius (°C), degree Fahrenheit
  (°F), or Kelvin (K).

- t_unit:

  Character string. Unit of the temperature value. Must be one of
  `"celsius"`, `"fahrenheit"`, or `"kelvin"`.

## Value

Numeric value of humidex in degree Celsius (°C).

## Details

The Humidex \\H_x\\ (°C) is calculated using the formula:

\$\$H_x = T + 0.555 \cdot (e - 10)\$\$

where \\e\\ is the vapor pressure (hPa), and \\T\\ is the air
temperature (°C).

The temperature input is converted to degree Celsius (°C) based on the
provided `t_unit` before calculation.

## References

Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield. “Humidity: A
Review and Primer on Atmospheric Moisture and Human Health.”
Environmental Research 144 (January 2016): 106–16.
<https://doi.org/10.1016/j.envres.2015.10.014>.

Masterton, J.M., and Richardson, F.A. “HUMIDEX: A Method of Quantifying
Human Discomfort Due to Excessive Heat and Humidity.” CLI 1-79 (1979).
Environment Canada, Atmospheric Environment Service Downsview, Ontario.

## Examples

``` r
cal_humidex(e = 15, t = 28, t_unit = "celsius")
#> [1] 30.775
cal_humidex(e = 10, t = 20, t_unit = "celsius")
#> [1] 20
```
