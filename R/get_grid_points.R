#' Extract spatial grid points within a specified boundary
#'
#' Extract spatial grid points from a gridded `SpatRaster` object that
#' lie within or intersect the boundary of a specified spatial object
#' (e.g., county, city, ZIP code, etc.).
#'
#' @param gridded_data A `SpatRaster` object containing gridded time series data
#'      (e.g., temperature).
#' @param sf_boundary An `sf` object containing the boundaries of interest.
#'      This object must contain the boundary specified by `boundary_name`
#'      in the column identified by `boundary_col_name`.
#'      For Virginia, the \link{sf_va_county} dataset provided in this package
#'      may be used.
#' @param boundary_name Character string.
#'      Name of the boundary to extract.
#'      Must match an entry in the `boundary_col_name` column of `sf_boundary`.
#' @param boundary_col_name Name of the column in `sf_boundary` that contains
#'      `boundary_name`.
#'
#' @returns
#' A `sf` object of all points from the masked raster (may include edge pixels).
#'
#' @export
#'
#' @examples
#' library(sf)
#'
#' richmond_msa <- load_era5_temperature()
#' va_county <- sf_va_county
#'
#' masked_output <- get_grid_points(gridded_data = richmond_msa,
#'                                  sf_boundary = va_county,
#'                                  boundary_name = "Amelia County",
#'                                  boundary_col_name = county)
#' masked_output

get_grid_points <- function(gridded_data,
                            sf_boundary,
                            boundary_name,
                            boundary_col_name){

        # filter the spatial object based on the provided boundary_name
        boundary_sf <- sf_boundary %>%
                 dplyr::filter({{boundary_col_name}} == boundary_name)

        # match CRS
        vect_boundary <- terra::vect(sf::st_transform(boundary_sf,
                                                       terra::crs(gridded_data)))
        # trim to bounding box
        rast_crop <- terra::crop(gridded_data, vect_boundary)
        # mask to shape
        rast_mask <- terra::mask(rast_crop, vect_boundary)
        # reshape raster to dataframe
        df_masked <- chva.extras::reshape_raster_timeseries(data = rast_mask) %>%
                sf::st_as_sf(coords = c("x", "y"),
                             crs = "WGS84")

        return(df_masked)
}

