# Get counts by category in wide format

Summarize the number of occurrences of each category (in `count_column`)
within each group (defined by `group_column`). The result is returned in
a wide format, where each unique category becomes a column. Missing
combinations are filled with 0.

## Usage

``` r
get_counts_by_category(data, group_column, count_column, names_prefix)
```

## Arguments

- data:

  A data frame.

- group_column:

  A column specifying the grouping variable.

- count_column:

  A column containing the categories to count within each group.

- names_prefix:

  A character string added as a prefix to each of the resulting column
  names.

## Value

A tibble in wide format with counts of each category per group.

## Examples

``` r
df <- data.frame(
  Incurred_Date = as.Date(c('2021-01-01', '2021-01-01', '2021-01-02')),
  Status = c("Open", "Closed", "Open")
)
get_counts_by_category(df,
                       group_column = Incurred_Date,
                       count_column = Status,
                       names_prefix = "Status_")
#> # A tibble: 2 × 3
#>   Incurred_Date Status_Closed Status_Open
#>   <date>                <dbl>       <dbl>
#> 1 2021-01-01                1           1
#> 2 2021-01-02                0           1
```
