# Calculate relative humidity

Calculate relative humidity \\RH\\ (%) from actual and saturation values
of vapor pressure, mixing ratio, specific humidity, or absolute
humidity.

## Usage

``` r
cal_relative_humidity(e, es)
```

## Arguments

- e:

  Numeric. Actual humidity value. Can be vapor pressure, mixing ratio,
  specific humidity, or absolute humidity.

- es:

  Numeric. Saturation value corresponding to `e`, using the same unit
  and type.

## Value

Numeric value of relative humidity (%).

## Details

Relative humidity \\RH\\ (%) quantifies the air’s proximity to
saturation. It is calculated using the formula:

\$\$RH = \frac{e}{e_s} \cdot 100 \approx \frac{w}{w_s} \cdot 100 \approx
\frac{q}{q_s} \cdot 100 \approx \frac{\rho_v}{\rho\_{vs}} \cdot 100\$\$

where \\e, w, q, \rho_v\\ is the actual value and \\e_s, w_s, q_s,
\rho\_{vs}\\ is the corresponding saturation value of vapor pressure,
mixing ratio, specific humidity, or absolute humidity.

## References

Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield. “Humidity: A
Review and Primer on Atmospheric Moisture and Human Health.”
Environmental Research 144 (January 2016): 106–16.
<https://doi.org/10.1016/j.envres.2015.10.014>.

## See also

[`cal_saturation_vapor_pressure()`](https://le-huynh.github.io/chva.extras/reference/cal_saturation_vapor_pressure.md),
[`cal_mixing_ratio()`](https://le-huynh.github.io/chva.extras/reference/cal_mixing_ratio.md),
[`cal_specific_humidity()`](https://le-huynh.github.io/chva.extras/reference/cal_specific_humidity.md),
[`cal_absolute_humidity()`](https://le-huynh.github.io/chva.extras/reference/cal_absolute_humidity.md),
[`weathermetrics::dewpoint.to.humidity()`](https://rdrr.io/pkg/weathermetrics/man/dewpoint.to.humidity.html)

## Examples

``` r
# Using vapor pressure (in hPa)
cal_relative_humidity(e = 10, es = 23.4)
#> [1] 42.73504

# Using specific humidity (in g/kg)
cal_relative_humidity(e = 7, es = 14)
#> [1] 50
```
