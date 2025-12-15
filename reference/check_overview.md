# Check dataset overview

Provide an overview of datasets within a specified directory that match
a given pattern. Return a summary with the number of rows, columns, and
a flag indicating whether the column names across datasets are
consistent.

## Usage

``` r
check_overview(folder_path, pattern)
```

## Arguments

- folder_path:

  A string path to the directory containing sub-directories of input
  Parquet files.

- pattern:

  A string to filter the sub-directories of input files by names.

## Value

A tibble summarizing the datasets, with columns:

- name:

  The name of each dataset file.

- nrow:

  The number of rows in each dataset.

- ncol:

  The number of columns in each dataset.

- matched_column_names:

  A logical value indicating whether the column names match.

## Examples

``` r
if (FALSE) { # \dontrun{
overview <- check_overview(folder_path = "path/to/data_folder", pattern = "Facility")
} # }
```
