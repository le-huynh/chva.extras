# Load hourly ERA5-Land temperature data for the Richmond MSA

Load a `SpatRaster` object containing hourly temperature data from
[ERA5-Land](https://cds.climate.copernicus.eu/datasets/reanalysis-era5-land?tab=overview)
for the Richmond Metropolitan Statistical Area (MSA). The time dimension
in the raster spans from 2017-05-14 00:00:00 to 2017-05-16 23:00:00
Eastern Time.

## Usage

``` r
load_era5_temperature()
```

## Value

A `SpatRaster`

## Examples

``` r
r <- load_era5_temperature()
```
