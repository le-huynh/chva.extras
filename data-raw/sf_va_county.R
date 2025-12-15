## code to prepare `sf_va_county` dataset

# Virginia geometry
va_sf <- rgeoboundaries::gb_adm1("United States") %>%
         dplyr::filter(shapeName == "Virginia")

# US counties
us_county_sf <- rgeoboundaries::gb_adm2("United States")

# centroid of each county
us_county_centroid <- sf::st_centroid(us_county_sf)

# VA counties
va_county_sf <- sf::st_within(us_county_centroid, va_sf, sparse = FALSE) %>%
                tibble::tibble(virginia = .) %>%
                dplyr::bind_cols(us_county_sf) %>%
                dplyr::full_join(us_county_centroid %>%
                                         dplyr::rename(centroid = geometry)) %>%
                dplyr::filter(virginia == TRUE) %>%
                dplyr::select(-virginia)

va_city <- c(
        "Alexandria",
        "Bristol", "Buena Vista",
        "Charlottesville", "Chesapeake", "Colonial Heights", "Covington",
        "Danville",
        "Emporia",
        "Fairfax", "Falls Church", "Franklin", "Fredericksburg",
        "Galax",
        "Hampton", "Harrisonburg", "Hopewell",
        "Lexington", "Lynchburg",
        "Manassas", "Manassas Park", "Martinsville",
        "Newport News", "Norfolk", "Norton",
        "Petersburg", "Poquoson", "Portsmouth",
        "Radford", "Richmond", "Roanoke",
        "Salem", "Staunton", "Suffolk",
        "Virginia Beach",
        "Waynesboro", "Williamsburg", "Winchester"
)

(va_county_adm <- va_county_sf %>%
                dplyr::arrange(shapeName) %>%
                dplyr::mutate(adm_level = dplyr::case_when(shapeName %in% va_city ~ "City",
                                                           TRUE ~ "County"),
                              adm_level = dplyr::case_when(shapeID %in%
                                                     c("52423323B7849589815213", # Fairfax
                                                       "52423323B83651152467254", # Franklin
                                                       "52423323B34545641874308", # Richmond
                                                       "52423323B87249104839261" #Roanoke
                                                     ) ~ "County",
                                                     TRUE ~ adm_level),
                       .after = shapeName) %>%
                dplyr::select(shapeName,
                              adm_level,
                              shapeID,
                              geometry))

sf_va_county <- va_county_adm %>%
                tidyr::unite("county", shapeName:adm_level, sep = " ") %>%
                sf::st_as_sf()

usethis::use_data(sf_va_county, overwrite = TRUE)

