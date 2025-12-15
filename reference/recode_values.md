# Recode values based on grouping logic

This function groups data by `var1` and recodes `var2` based on specific
conditions. If `var1` has only one unique `var2` value, the original
value is retained. If `var1` has two unique `var2` values, the known
value is assigned if one matches `unknown_category`; otherwise,
`unknown_category` is assigned. If `var1` has more than two unique
`var2` values, `unknown_category` is assigned.

## Usage

``` r
recode_values(data, var1, var2, unknown_category)
```

## Arguments

- data:

  A data frame or an element of a list dataset (output from
  [`get_dataset()`](https://le-huynh.github.io/chva.extras/reference/get_dataset.md)).

- var1:

  A character string specifying the grouping variable.

- var2:

  A character string specifying the variable to be recoded.

- unknown_category:

  A character string specifying the ambiguous or unknown values in
  `var2`.

## Value

A data frame with `var1` and recoded `var2`.

## Examples

``` r
df <- data.frame(ID = c(1, 1, 2, 2, 3, 3, 3),
                 Gender = c("Male", "Unknown", "Female", "Female", "Male", "Female", "Unknown"))
df
#>   ID  Gender
#> 1  1    Male
#> 2  1 Unknown
#> 3  2  Female
#> 4  2  Female
#> 5  3    Male
#> 6  3  Female
#> 7  3 Unknown

recode_values(df, var1 = "ID", var2 = "Gender", unknown_category = "Unknown")
#> Joining with `by = join_by(ID, Gender)`
#> Joining with `by = join_by(ID, Gender)`
#> # A tibble: 3 × 2
#>      ID Gender 
#>   <dbl> <chr>  
#> 1     2 Female 
#> 2     1 Male   
#> 3     3 Unknown
```
