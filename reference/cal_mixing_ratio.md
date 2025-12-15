# Calculate mixing ratio

Calculate mixing ratio \\w\\ (g/kg) from vapor pressure \\e\\ (hPa) and
air pressure \\p\\ (hPa).

## Usage

``` r
cal_mixing_ratio(e, p)
```

## Arguments

- e:

  Numeric. Vapor pressure in hectoPascal (hPa).

- p:

  Numeric. Air pressure in hectoPascal (hPa).

## Value

Numeric value of mixing ratio in g/kg.

## Details

Mixing ratio \\w\\ (g/kg) is defined as the mass of moisture per mass of
dry air:

\$\$q = \frac{0.622 \cdot e \cdot 1000}{p - e}\$\$

where \\e\\ is the vapor pressure (hPa), and \\p\\ is the air pressure
(hPa).

## References

Davis, Robert E., Glenn R. McGregor, and Kyle B. Enfield. “Humidity: A
Review and Primer on Atmospheric Moisture and Human Health.”
Environmental Research 144 (January 2016): 106–16.
<https://doi.org/10.1016/j.envres.2015.10.014>.

## Examples

``` r
cal_mixing_ratio(e = 12, p = 1013.25)
#> [1] 7.454682
```
