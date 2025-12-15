## code to prepare `sf_va_zcta` dataset

f <- system.file("extdata",
                 "va_zcta_sf.rds",
                 package = "chva.extras")

sf_va_zcta <- rio::import(f)

usethis::use_data(sf_va_zcta, overwrite = TRUE)

