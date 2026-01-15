# Extract spatial grid points within a specified boundary

Extract spatial grid points from a gridded `SpatRaster` object that lie
within or intersect the boundary of a specified spatial object (e.g.,
county, city, ZIP code, etc.).

## Usage

``` r
get_grid_points(gridded_data, sf_boundary, boundary_name, boundary_col_name)
```

## Arguments

- gridded_data:

  A `SpatRaster` object containing gridded time series data (e.g.,
  temperature).

- sf_boundary:

  An `sf` object containing the boundaries of interest. This object must
  contain the boundary specified by `boundary_name` in the column
  identified by `boundary_col_name`. For Virginia, the
  [sf_va_county](https://le-huynh.github.io/chva.extras/reference/sf_va_county.md)
  dataset provided in this package may be used.

- boundary_name:

  Character string. Name of the boundary to extract. Must match an entry
  in the `boundary_col_name` column of `sf_boundary`.

- boundary_col_name:

  Name of the column in `sf_boundary` that contains `boundary_name`.

## Value

A `sf` object of all points from the masked raster (may include edge
pixels).

## Examples

``` r
library(sf)
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE

richmond_msa <- load_era5_temperature()
va_county <- sf_va_county

masked_output <- get_grid_points(gridded_data = richmond_msa,
                                 sf_boundary = va_county,
                                 boundary_name = "Amelia County",
                                 boundary_col_name = county)
#> Warning: Expected 2 pieces. Missing pieces filled with `NA` in 45 rows [21, 45, 69, 93,
#> 117, 141, 165, 189, 213, 237, 261, 285, 309, 333, 357, 381, 405, 429, 453, 477,
#> ...].
masked_output
#> Simple feature collection with 1080 features and 3 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -78.235 ymin: 37.208 xmax: -77.735 ymax: 37.408
#> Geodetic CRS:  WGS 84
#> # A tibble: 1,080 × 4
#>    timeUTC             timeET              value         geometry
#>  * <chr>               <dttm>              <dbl>      <POINT [°]>
#>  1 2017-05-14 04:00:00 2017-05-14 00:00:00  285. (-78.235 37.408)
#>  2 2017-05-14 05:00:00 2017-05-14 01:00:00  284. (-78.235 37.408)
#>  3 2017-05-14 06:00:00 2017-05-14 02:00:00  283. (-78.235 37.408)
#>  4 2017-05-14 07:00:00 2017-05-14 03:00:00  283. (-78.235 37.408)
#>  5 2017-05-14 08:00:00 2017-05-14 04:00:00  283. (-78.235 37.408)
#>  6 2017-05-14 09:00:00 2017-05-14 05:00:00  283. (-78.235 37.408)
#>  7 2017-05-14 10:00:00 2017-05-14 06:00:00  283. (-78.235 37.408)
#>  8 2017-05-14 11:00:00 2017-05-14 07:00:00  284. (-78.235 37.408)
#>  9 2017-05-14 12:00:00 2017-05-14 08:00:00  287. (-78.235 37.408)
#> 10 2017-05-14 13:00:00 2017-05-14 09:00:00  290. (-78.235 37.408)
#> # ℹ 1,070 more rows
```
