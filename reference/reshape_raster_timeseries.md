# Reshape raster to dataframe

Converts a SpatRaster time series into a tidy data frame in long format,
including spatial coordinates (`x`, `y`) and time information in both
UTC and Eastern Time.

## Usage

``` r
reshape_raster_timeseries(data, ...)
```

## Arguments

- data:

  SpatRaster

- ...:

  Passed to
  [`terra::as.data.frame()`](https://rspatial.github.io/terra/reference/as.data.frame.html)

## Value

A tibble with columns:

- `x`, `y`: Spatial coordinates

- `timeUTC`: Original timestamp (in UTC) extracted from layer names

- `timeET`: Converted timestamp in US/Eastern time zone

- `value`: Raster cell value at the given time and location

## Examples

``` r
r <- load_era5_temperature()
reshape_raster_timeseries(r)
#> Warning: Expected 2 pieces. Missing pieces filled with `NA` in 450 rows [21, 45, 69, 93,
#> 117, 141, 165, 189, 213, 237, 261, 285, 309, 333, 357, 381, 405, 429, 453, 477,
#> ...].
#> # A tibble: 10,800 × 5
#>        x     y timeUTC             timeET              value
#>    <dbl> <dbl> <chr>               <dttm>              <dbl>
#>  1 -78.1  37.9 2017-05-14 04:00:00 2017-05-14 00:00:00  284.
#>  2 -78.1  37.9 2017-05-14 05:00:00 2017-05-14 01:00:00  283.
#>  3 -78.1  37.9 2017-05-14 06:00:00 2017-05-14 02:00:00  282.
#>  4 -78.1  37.9 2017-05-14 07:00:00 2017-05-14 03:00:00  282.
#>  5 -78.1  37.9 2017-05-14 08:00:00 2017-05-14 04:00:00  282.
#>  6 -78.1  37.9 2017-05-14 09:00:00 2017-05-14 05:00:00  282.
#>  7 -78.1  37.9 2017-05-14 10:00:00 2017-05-14 06:00:00  282.
#>  8 -78.1  37.9 2017-05-14 11:00:00 2017-05-14 07:00:00  283.
#>  9 -78.1  37.9 2017-05-14 12:00:00 2017-05-14 08:00:00  286.
#> 10 -78.1  37.9 2017-05-14 13:00:00 2017-05-14 09:00:00  290.
#> # ℹ 10,790 more rows
```
