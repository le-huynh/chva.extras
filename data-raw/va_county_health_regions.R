## code to prepare `va_county_health_regions` dataset

f <- system.file("extdata",
                 "va_county_health_regions.xlsx",
                 package = "chva.extras")

va_county_health_regions <- rio::import(f)

usethis::use_data(va_county_health_regions, overwrite = TRUE)

