# Extract spatial grid points within a specified boundary

Extract spatial grid points from a gridded `SpatRaster` object that fall
within the boundary of a specified spatial object (e.g., county, city,
ZIP code, etc.). The output can be limited to points strictly within the
boundary or include all masked points overlapping the boundary extent.

## Usage

``` r
get_grid_points(
  gridded_data,
  sf_boundary,
  boundary_name,
  boundary_col_name,
  output = c("within", "masked")
)
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

- output:

  Character string indicating the type of output. `"within"` (default)
  returns only grid points strictly within the boundary, `"masked"`
  returns all points from the masked raster (may include edge pixels).

## Value

- `output = "within"`: A tibble of grid points strictly within the
  specified boundary.

- `output = "masked"`: A `sf` object of all points from the masked
  raster (may include edge pixels).

## Examples

``` r
library(sf)
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE

richmond_msa <- load_era5_temperature()
va_county <- sf_va_county

masked_output <- get_grid_points(gridded_data = richmond_msa,
                                 sf_boundary = va_county,
                                 boundary_name = "Amelia County",
                                 boundary_col_name = county,
                                 output = "masked")
#> Warning: Expected 2 pieces. Missing pieces filled with `NA` in 45 rows [21, 45, 69, 93,
#> 117, 141, 165, 189, 213, 237, 261, 285, 309, 333, 357, 381, 405, 429, 453, 477,
#> ...].

within_output <- get_grid_points(gridded_data = richmond_msa,
                                 sf_boundary = va_county,
                                 boundary_name = "Amelia County",
                                 boundary_col_name = county,
                                 output = "within")
#> Warning: Expected 2 pieces. Missing pieces filled with `NA` in 45 rows [21, 45, 69, 93,
#> 117, 141, 165, 189, 213, 237, 261, 285, 309, 333, 357, 381, 405, 429, 453, 477,
#> ...].
```
