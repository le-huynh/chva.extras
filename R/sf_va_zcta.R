#' Geographic boundaries of ZCTAs in Virginia
#'
#' A simple feature collection of ZIP Code Tabulation Areas (ZCTAs) in Virginia.
#'
#' @format ## `sf_va_zcta`
#' \describe{
#'   \item{ZCTA5CE20}{Five-digit ZCTA code (2020).}
#'   \item{zcta_county}{County or independent city associated with the ZCTA.}
#'   \item{geometry}{Polygon geometry of the ZCTA.}
#' }
#'
#' @source Data originally obtained from the [U.S. Census Bureau, 2020 TIGER/Line Shapefiles](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/zctas.html),
#' and post-processed to get the ZCTAs in Virginia.

"sf_va_zcta"

