# Tests for load_era5_temperature(), reshape_raster_timeseries() and
# get_grid_points().

test_that("load_era5_temperature() loads the example SpatRaster", {
  r <- load_era5_temperature()

  expect_s4_class(r, "SpatRaster")
  expect_equal(terra::nlyr(r), 72)
  expect_false(anyNA(terra::time(r)))
})

test_that("reshape_raster_timeseries() returns tidy long data", {
  r <- load_era5_temperature()
  res <- reshape_raster_timeseries(r)

  expect_s3_class(res, "data.frame")
  expect_named(res, c("x", "y", "timeUTC", "timeET", "value"))
  expect_lte(nrow(res), terra::ncell(r) * terra::nlyr(r))
  expect_equal(dplyr::n_distinct(res$timeUTC), terra::nlyr(r))

  expect_s3_class(res$timeET, "POSIXct")
  expect_equal(attr(res$timeET, "tzone"), "US/Eastern")
  expect_false(anyNA(res$timeET))
})

test_that("reshape_raster_timeseries() keeps midnight timestamps", {
  # Layers at 00:00:00 UTC lose their time part when converted to text;
  # the function must restore it.
  res <- reshape_raster_timeseries(load_era5_temperature())

  expect_true("2017-05-15 00:00:00" %in% res$timeUTC)
  expect_true(all(grepl("^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}$", res$timeUTC)))
})

test_that("get_grid_points() extracts points for one county", {
  r <- load_era5_temperature()

  res <- get_grid_points(gridded_data = r,
                         sf_boundary = sf_va_county,
                         boundary_name = "Amelia County",
                         boundary_col_name = county)

  expect_s3_class(res, "sf")
  expect_true(all(sf::st_geometry_type(res) == "POINT"))
  expect_gt(nrow(res), 0)
  expect_true(all(c("timeUTC", "timeET", "value") %in% names(res)))

  # All points lie within the county bounding box (plus one grid cell)
  bb <- sf::st_bbox(sf_va_county[sf_va_county$county == "Amelia County", ])
  xy <- sf::st_coordinates(res)
  res_cell <- terra::res(r)
  expect_true(all(xy[, "X"] >= bb[["xmin"]] - res_cell[1] & xy[, "X"] <= bb[["xmax"]] + res_cell[1]))
  expect_true(all(xy[, "Y"] >= bb[["ymin"]] - res_cell[2] & xy[, "Y"] <= bb[["ymax"]] + res_cell[2]))
})

test_that("get_grid_points() returns fewer points than the full raster", {
  r <- load_era5_temperature()
  full <- reshape_raster_timeseries(r)

  res <- get_grid_points(gridded_data = r,
                         sf_boundary = sf_va_county,
                         boundary_name = "Amelia County",
                         boundary_col_name = county)

  expect_lt(nrow(res), nrow(full))
})
