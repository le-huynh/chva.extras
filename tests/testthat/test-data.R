test_that("sf_va_county contains all Virginia counties and cities", {
  expect_s3_class(sf_va_county, "sf")
  expect_equal(nrow(sf_va_county), 133)
  expect_true("county" %in% names(sf_va_county))
  expect_equal(anyDuplicated(sf_va_county$county), 0L)
  expect_equal(sf::st_crs(sf_va_county)$epsg, 4326L)
})

test_that("va_county_health_regions is a complete crosswalk", {
  expect_s3_class(va_county_health_regions, "data.frame")
  expect_equal(nrow(va_county_health_regions), 133)
  expect_true(all(c("County", "County_full_name", "Health_Planning_District",
                    "Health_Planning_Region", "MSA_Rating_Area")
                  %in% names(va_county_health_regions)))
  expect_false(anyNA(va_county_health_regions$Health_Planning_Region))
  expect_setequal(va_county_health_regions$County_full_name, sf_va_county$county)
})

test_that("va_zcta_health_regions has the expected structure", {
  expect_s3_class(va_zcta_health_regions, "data.frame")
  expect_gt(nrow(va_zcta_health_regions), 0)
  expect_true(all(c("zipcode", "zcta", "zcta_county", "Health_Planning_District",
                    "Health_Planning_Region", "MSA_Rating_Area")
                  %in% names(va_zcta_health_regions)))
  expect_true(all(va_zcta_health_regions$Health_Planning_Region %in%
                    va_county_health_regions$Health_Planning_Region))
})

test_that("sf_va_zcta contains ZCTA geometries", {
  skip_on_cran() # large dataset

  expect_s3_class(sf_va_zcta, "data.frame")
  expect_true(all(c("ZCTA5CE20", "zcta_county", "geometry") %in% names(sf_va_zcta)))
  expect_s3_class(sf_va_zcta$geometry, "sfc")
  expect_true(all(nchar(sf_va_zcta$ZCTA5CE20) == 5))
  expect_true(all(sf_va_zcta$zcta_county %in% sf_va_county$county))
})
