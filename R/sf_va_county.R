#' Geographic boundaries of counties and independent cities in Virginia
#'
#' A simple feature collection of 133 counties and independent cities in Virginia.
#'
#' @format ## `sf_va_county`
#' A simple feature collection with 133 features and 3 fields:
#' \describe{
#'   \item{county}{Character. Name of the county or independent city.}
#'   \item{shapeID}{Character. Unique shape identifier.}
#'   \item{geometry}{`MULTIPOLYGON`. The spatial boundary in EPSG:4326 (WGS 84).}
#' }
#' @source Data originally obtained from [geoBoundaries](https://www.geoboundaries.org),
#' and post-processed to get the current administrative boundaries of counties
#' and independent cities in Virginia.

"sf_va_county"

