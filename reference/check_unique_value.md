# Check unique values in a column

`check_unique_value()` counts the unique values of a specified column.

`check_unique_value_overview()` takes a list of outputs from
`check_unique_value()` and checks the consistency of unique values
within a specified column across multiple datasets.

## Usage

``` r
check_unique_value(data, column_to_check)

check_unique_value_overview(data, column_to_check)
```

## Arguments

- data:

  For `check_unique_value()`, a data frame or an element of a list
  dataset (output from
  [`get_dataset()`](https://le-huynh.github.io/chva.extras/reference/get_dataset.md)).
  For `check_unique_value_overview()`, a list of outputs from
  `check_unique_value()`.

- column_to_check:

  A column to check for unique values, using `column_name` without
  quotes.

## Value

- `check_unique_value()`: A tibble with the unique values in the
  specified column and their counts.

&nbsp;

- `check_unique_value_overview()`: A tibble summarizing the number of
  unique values in each element of the list and indicating whether the
  unique values are consistent across all list elements.

## Examples

``` r
list_mtcars <- list(data1 = mtcars, data2 = mtcars, data3 = mtcars)

res_list <- list_mtcars %>%
        purrr::map(check_unique_value, column_to_check = cyl)

check_unique_value_overview(res_list, column_to_check = cyl)
#> # A tibble: 3 × 3
#>   name  unique_val_number matched_unique_val
#>   <chr>             <dbl> <lgl>             
#> 1 data1                 3 TRUE              
#> 2 data2                 3 TRUE              
#> 3 data3                 3 TRUE              
```
