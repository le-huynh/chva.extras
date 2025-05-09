#' Extract grid points within a specific county boundary
#'
#' Extract spatial grid points from a gridded `SpatRaster` object that fall
#' within the boundary of a specified county.
#' Output can be limited to points strictly within the boundary or
#' include all masked points overlapping the boundary extent.
#'
#' @param gridded_data A `SpatRaster` object containing gridded time series data
#'      (e.g., temperature).
#' @param sf_county A `sf` object containing county boundary.
#'      For Virginia, the \link{sf_va_county} dataset provided in this package
#'      may be used.
#' @param county_name Character string.
#'      Name of the county or independent city to extract.
#'      Must match an entry in the `county` column of `sf_county`.
#' @param output Character string indicating the type of output.
#'      `"within"` (default) returns only grid points strictly within the boundary,
#'      `"masked"` returns all points from the masked raster (may include edge pixels).
#'
#' @returns
#' \itemize{
#'   \item \code{output = "within"}: A tibble of grid points strictly within
#'      the specified boundary.
#'   \item \code{output = "masked"}: A `sf` object of all points from
#'      the masked raster (may include edge pixels).
#' }
#' @export
#'
#' @examples
#' library(sf)
#'
#' richmond_msa <- load_era5_temperature()
#' va_county <- sf_va_county
#'
#' masked_output <- get_grid_points(gridded_data = richmond_msa,
#'                                  sf_county = va_county,
#'                                  county_name = "Amelia County",
#'                                  output = "masked")
#'
#' within_output <- get_grid_points(gridded_data = richmond_msa,
#'                                  sf_county = va_county,
#'                                  county_name = "Amelia County",
#'                                  output = "within")

get_grid_points <- function(gridded_data,
                            sf_county,
                            county_name,
                            output = c("within", "masked")){

        county_sf <- sf_county %>% dplyr::filter(county == county_name)

        # match CRS
        vect_county <- terra::vect(sf::st_transform(county_sf,
                                                    terra::crs(gridded_data)))
        # trim to bounding box
        rast_crop <- terra::crop(gridded_data, vect_county)
        # mask to shape
        rast_mask <- terra::mask(rast_crop, vect_county)
        # reshape raster to dataframe
        df_county <- chva.extras::reshape_raster_timeseries(data = rast_mask) %>%
                sf::st_as_sf(coords = c("x", "y"),
                             crs = "WGS84")

        df_within_county <- sf::st_within(df_county,
                                          county_sf,
                                          sparse = FALSE) %>%
                tibble::tibble(within = .) %>%
                dplyr::bind_cols(df_county) %>%
                dplyr::filter(within) %>%
                dplyr::select(-within)

        output <- match.arg(output)
        if (output == "within") return(df_within_county)
        if (output == "masked") return(df_county)
}

