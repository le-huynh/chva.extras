#' Virginia ZIP code, ZCTA, county and Health Planning Region crosswalk
#'
#' A reference dataset linking ZIP codes, ZIP Code Tabulation Areas (ZCTAs)
#' in Virginia to counties and health planning geographies (Health Planning District,
#' Health Planning Region, and Metropolitan Statistical Area (MSA) Rating Area).
#'
#' @format ## `va_zcta_health_regions`
#' \describe{
#'   \item{zipcode}{Five-digit USPS ZIP code.}
#'   \item{zip_county}{County or independent city associated with the ZIP code.}
#'   \item{zcta}{Five-digit Census ZIP Code Tabulation Area (ZCTA).}
#'   \item{zcta_county}{County or independent city associated with the ZCTA.}
#'   \item{Health_Planning_District}{Virginia Health Planning District associated with the `zcta_county`.}
#'   \item{Health_Planning_Region}{Virginia Health Planning Region associated with the `zcta_county`.}
#'   \item{MSA_Rating_Area}{Metropolitan Statistical Area (Rating Area) associated with the `zcta_county`.}
#'   \item{zip_type}{Classification of the ZIP code (for example, Zip Code Area or Post Office).}
#'   \item{zip_join_type}{Type of linkage between the ZIP code and ZCTAs (i.e., “ZIP matches ZCTA” or “Spatial join to ZCTA”).}
#' }
#'
#' @source
#' [Virginia Rating Areas map](https://www.scc.virginia.gov/media/sccvirginiagov-home/applications-assets/aca-rating-area-map.pdf)
#' provided by the Virginia State Corporation Commission (SCC).
#'
#' [Local Health Districts](https://www.vdh.virginia.gov/local-health-districts/)
#' provided by Virginia Department of Health.
#'
#' [Zip to ZCTA Crosswalk](https://share.google/XgDXQAWMmtYmoUSxT)
#' provided by HRSA Data Warehouse.

"va_zcta_health_regions"

