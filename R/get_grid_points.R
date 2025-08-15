#' Extract spatial grid points within a specified boundary
#'
#' Extract spatial grid points from a gridded `SpatRaster` object that fall
#' within the boundary of a specified spatial object (e.g., county, city,
#' ZIP code, etc.).
#' The output can be limited to points strictly within the boundary or
#' include all masked points overlapping the boundary extent.
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
#'                                  sf_boundary = va_county,
#'                                  boundary_name = "Amelia County",
#'                                  boundary_col_name = county,
#'                                  output = "masked")
#'
#' within_output <- get_grid_points(gridded_data = richmond_msa,
#'                                  sf_boundary = va_county,
#'                                  boundary_name = "Amelia County",
#'                                  boundary_col_name = county,
#'                                  output = "within")

get_grid_points <- function(gridded_data,
                            sf_boundary,
                            boundary_name,
                            boundary_col_name,
                            output = c("within", "masked")){

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
        df_boundary <- chva.extras::reshape_raster_timeseries(data = rast_mask) %>%
                sf::st_as_sf(coords = c("x", "y"),
                             crs = "WGS84")

        df_within_boundary <- sf::st_within(df_boundary,
                                            boundary_sf,
                                            sparse = FALSE) %>%
                tibble::tibble(within_val = .) %>%
                dplyr::transmute(within_val = as.logical(within_val)) %>%
                dplyr::bind_cols(df_boundary) %>%
                dplyr::filter(within_val == TRUE) %>%
                dplyr::select(-within_val)

        output <- match.arg(output)
        if (output == "within") return(df_within_boundary)
        if (output == "masked") return(df_boundary)
}

