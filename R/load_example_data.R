#' Load hourly ERA5-Land temperature data for the Richmond MSA
#'
#' Load a `SpatRaster` object containing hourly temperature data
#' from [ERA5-Land](https://cds.climate.copernicus.eu/datasets/reanalysis-era5-land?tab=overview)
#' for the Richmond Metropolitan Statistical Area (MSA).
#' The time dimension in the raster spans from 2017-05-14 00:00:00 to
#' 2017-05-16 23:00:00 Eastern Time.
#'
#' @returns A `SpatRaster`
#' @export
#'
#' @examples
#' r <- load_era5_temperature()

load_era5_temperature <- function() {

        f <- system.file("extdata",
                         "richmond_msa_era5_raw_2m_temperature.nc",
                         package = "chva.extras")

        if (f == "") stop("File not found in extdata.")

        res <- terra::rast(f)

        return(res)
}

