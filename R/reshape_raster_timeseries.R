#' Reshape raster to dataframe
#'
#' Converts a SpatRaster time series into a tidy data frame in long format,
#' including spatial coordinates (`x`, `y`) and time information in both
#' UTC and Eastern Time.
#'
#' @param data SpatRaster
#'
#' @returns A tibble with columns:
#'   - `x`, `y`: Spatial coordinates
#'   - `timeUTC`: Original timestamp (in UTC) extracted from layer names
#'   - `timeET`: Converted timestamp in US/Eastern time zone
#'   - `value`: Raster cell value at the given time and location
#'
#' @export
#'
#' @examples
#' r <- load_era5_temperature()
#' reshape_raster_timeseries(r)

reshape_raster_timeseries <- function(data){

        res <- data %>%
                terra::as.data.frame(xy = TRUE,
                                     time = TRUE,
                                     na.rm = TRUE) %>%
                tidyr::pivot_longer(cols = c(-x, -y),
                                    names_to = "timeUTC",
                                    values_to = "value") %>%
                # time 00:00:00 is missing -> add 00:00:00 to date
                tidyr::separate(col = timeUTC,
                                into = c("date", "time"),
                                sep = " ") %>%
                dplyr::mutate(time = dplyr::case_when(is.na(time) ~ "00:00:00",
                                               TRUE ~ time)) %>%
                tidyr::unite("timeUTC", date:time, sep = " ") %>%
                dplyr::mutate(timeET = lubridate::ymd_hms(timeUTC, tz = "UTC"),
                              timeET = lubridate::with_tz(timeET, "US/Eastern"),
                              .after = timeUTC)

        return(res)
}

