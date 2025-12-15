# Get full working datasets

Get full working datasets as a named list of
[Dataset](https://arrow.apache.org/docs/r/reference/Dataset.html) R6
objects. Each dataset is opened from files matching the given pattern,
and the names of the list elements correspond to the file names.

## Usage

``` r
get_dataset(folder_path, pattern)
```

## Arguments

- folder_path:

  A string path to the directory containing sub-directories of input
  Parquet files.

- pattern:

  A string to filter the sub-directories of input files by names.

## Value

A named list of datasets.

## Examples

``` r
if (FALSE) { # \dontrun{
datasets <- get_dataset(folder_path = "path/to/data_folder", pattern = "Facility")
} # }
```
