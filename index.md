# chva.extras

Supplementary Tools for Climate and Health Research in VA

`chva.extras` is a collection of supplementary functions and templates
designed to support climate and health research in VA, including tools
for data manipulation, analysis, and visualization, tailored to handle
large datasets.

## Installation

To get the latest in-development features, install the development
version from GitHub:

``` r
if(!requireNamespace("devtools", quietly = TRUE)) {
 install.packages("devtools")
}
devtools::install_github("le-huynh/chva.extras")
```

This package is also accessible for download via Zenodo with the DOI
[10.5281/zenodo.14910967](https://doi.org/10.5281/zenodo.14910966).

### Functions

See [Package
index](https://le-huynh.github.io/chva.extras/reference/index.html) for
full list of functions.

1.  Convert files to Parquet format

- [`get_parquet_arrow()`](https://le-huynh.github.io/chva.extras/reference/get_parquet_arrow.md):
  Convert multiple files to Parquet format.  
- [`get_parquet_by_chunk()`](https://le-huynh.github.io/chva.extras/reference/get_parquet_by_chunk.md):
  Convert file to Parquet format by chunks.

2.  Support handy workflow

- [`check_overview()`](https://le-huynh.github.io/chva.extras/reference/check_overview.md):
  Provide an overview of datasets.  
- [`check_unique_value()`](https://le-huynh.github.io/chva.extras/reference/check_unique_value.md):
  Count unique values of a specified column.  
- [`get_dataset()`](https://le-huynh.github.io/chva.extras/reference/get_dataset.md):
  Get full working datasets as a named list of
  [Dataset](https://arrow.apache.org/docs/r/reference/Dataset.html) R6
  objects.  
- [`recode_values()`](https://le-huynh.github.io/chva.extras/reference/recode_values.md):
  Recode values based on grouping logic.

3.  Compute indices used in climate health research

- Humidity variables:
  [`cal_absolute_humidity()`](https://le-huynh.github.io/chva.extras/reference/cal_absolute_humidity.md),
  [`cal_dewpoint_temperature()`](https://le-huynh.github.io/chva.extras/reference/cal_dewpoint_temperature.md),
  [`cal_mixing_ratio()`](https://le-huynh.github.io/chva.extras/reference/cal_mixing_ratio.md),
  [`cal_relative_humidity()`](https://le-huynh.github.io/chva.extras/reference/cal_relative_humidity.md),
  [`cal_specific_humidity()`](https://le-huynh.github.io/chva.extras/reference/cal_specific_humidity.md).  
- Comfort indices:
  [`cal_apparent_temperature()`](https://le-huynh.github.io/chva.extras/reference/cal_apparent_temperature.md),
  [`cal_humidex()`](https://le-huynh.github.io/chva.extras/reference/cal_humidex.md),
  [`cal_temperature_humidity_index()`](https://le-huynh.github.io/chva.extras/reference/cal_temperature_humidity_index.md).  
- [`cal_saturation_vapor_pressure()`](https://le-huynh.github.io/chva.extras/reference/cal_saturation_vapor_pressure.md)

4.  Support visualization

- [`plot_contour_dlnm()`](https://le-huynh.github.io/chva.extras/reference/plot_contour_dlnm.md):
  Generate a filled contour plot for DLNM output with custom color
  levels.

## Acknowledgements

This R package was produced with support from the [UVA Environmental
Institute](https://environment.virginia.edu/) through the [Strategic
Investment Fund](https://sif.virginia.edu/).
