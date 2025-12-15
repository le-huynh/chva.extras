# Interpolate missing values in grouped data

Perform linear interpolation to fill missing (`NA`) values in specified
columns (`vars2`), with grouping based on a unique row identifier
(`var1`). Interpolation is performed row-wise. See **Examples** for the
structure of input data.

## Usage

``` r
interpolate_na(data, var1, vars2, maxgap = 1, rule = 1)
```

## Arguments

- data:

  A data frame containing the variables to be interpolated.

- var1:

  A variable serving as the unique row identifier (group). Each value in
  `var1` must be unique. If duplicate values exist, the function will
  return an error.

- vars2:

  A vector specifying the numeric columns to interpolate.

- maxgap:

  An integer defining the maximum number of consecutive `NA` values to
  interpolate. Defaults to `1`. If gaps exceed this limit, the values
  remain `NA`.

- rule:

  An integer (1 or 2) specifying the extrapolation rule. Defaults to
  `1`, meaning no extrapolation beyond available data range. Rule `2`
  uses the nearest observed value for out-of-range points. A vector
  (e.g., `rule = c(2,1)`) can specify different extrapolation rules for
  the left and right sides.

## Value

A data frame with missing values interpolated in `vars2`.

## Examples

``` r
df <- data.frame(
  date = c("2022-03-01", "2022-08-13", "2023-02-09", "2024-09-22"),
  temp_1am = c(NA, 20, 5, 24),
  temp_6am = c(6, NA, 6, NA),
  temp_11am = c(13, 25, 8, NA),
  temp_4pm = c(18, 30, NA, 30)
)

interpolate_na(df,
               var1 = "date",
               vars2 = c("temp_1am", "temp_6am", "temp_11am", "temp_4pm"))
#> # A tibble: 4 × 5
#>   date       temp_1am temp_6am temp_11am temp_4pm
#>   <chr>         <dbl>    <dbl>     <dbl>    <dbl>
#> 1 2022-03-01       NA      6          13       18
#> 2 2022-08-13       20     22.5        25       30
#> 3 2023-02-09        5      6           8       NA
#> 4 2024-09-22       24     NA          NA       30

interpolate_na(df,
               var1 = "date",
               vars2 = c("temp_1am", "temp_6am", "temp_11am", "temp_4pm"),
               rule = 2)
#> # A tibble: 4 × 5
#>   date       temp_1am temp_6am temp_11am temp_4pm
#>   <chr>         <dbl>    <dbl>     <dbl>    <dbl>
#> 1 2022-03-01        6      6          13       18
#> 2 2022-08-13       20     22.5        25       30
#> 3 2023-02-09        5      6           8        8
#> 4 2024-09-22       24     NA          NA       30
```
