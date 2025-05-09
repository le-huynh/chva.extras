% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reshape_raster_timeseries.R
\name{reshape_raster_timeseries}
\alias{reshape_raster_timeseries}
\title{Reshape raster to dataframe}
\usage{
reshape_raster_timeseries(data)
}
\arguments{
\item{data}{SpatRaster}
}
\value{
A tibble with columns:
\itemize{
\item \code{x}, \code{y}: Spatial coordinates
\item \code{timeUTC}: Original timestamp (in UTC) extracted from layer names
\item \code{timeET}: Converted timestamp in US/Eastern time zone
\item \code{value}: Raster cell value at the given time and location
}
}
\description{
Converts a SpatRaster time series into a tidy data frame in long format,
including spatial coordinates (\code{x}, \code{y}) and time information in both
UTC and Eastern Time.
}
\examples{
r <- load_era5_temperature()
reshape_raster_timeseries(r)
}
