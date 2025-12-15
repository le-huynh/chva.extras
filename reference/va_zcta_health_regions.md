# Virginia ZIP code, ZCTA, county and Health Planning Region crosswalk

A reference dataset linking ZIP codes, ZIP Code Tabulation Areas (ZCTAs)
in Virginia to counties and health planning geographies (Health Planning
District, Health Planning Region, and Metropolitan Statistical Area
(MSA) Rating Area).

## Usage

``` r
va_zcta_health_regions
```

## Format

### `va_zcta_health_regions`

- zipcode:

  Five-digit USPS ZIP code.

- zip_county:

  County or independent city associated with the ZIP code.

- zcta:

  Five-digit Census ZIP Code Tabulation Area (ZCTA).

- zcta_county:

  County or independent city associated with the ZCTA.

- Health_Planning_District:

  Virginia Health Planning District associated with the `zcta_county`.

- Health_Planning_Region:

  Virginia Health Planning Region associated with the `zcta_county`.

- MSA_Rating_Area:

  Metropolitan Statistical Area (Rating Area) associated with the
  `zcta_county`.

- zip_type:

  Classification of the ZIP code (for example, Zip Code Area or Post
  Office).

- zip_join_type:

  Type of linkage between the ZIP code and ZCTAs (i.e., “ZIP matches
  ZCTA” or “Spatial join to ZCTA”).

## Source

[Virginia Rating Areas
map](https://www.scc.virginia.gov/media/sccvirginiagov-home/applications-assets/aca-rating-area-map.pdf)
provided by the Virginia State Corporation Commission (SCC).

[Local Health
Districts](https://www.vdh.virginia.gov/local-health-districts/)
provided by Virginia Department of Health.

[Zip to ZCTA Crosswalk](https://share.google/XgDXQAWMmtYmoUSxT) provided
by HRSA Data Warehouse.
