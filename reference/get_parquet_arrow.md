# Convert multiple files to Parquet format

Convert multiple files from a specified format (e.g., CSV) to Parquet
format. The converted Parquet files are saved in the original location
of the input files, allowing for efficient storage and retrieval of
large datasets.

## Usage

``` r
get_parquet_arrow(
  folder_path,
  pattern,
  input_format = "csv",
  max_rows_per_file = 1e+07
)
```

## Arguments

- folder_path:

  A string path to the directory containing sub-directories of input
  files.

- pattern:

  A string to filter the sub-directories of input files by names.

- input_format:

  A string indicating format of input files. Default is `"csv"`. Other
  supported formats are listed in
  [`arrow::open_dataset()`](https://arrow.apache.org/docs/r/reference/open_dataset.html).

- max_rows_per_file:

  Maximum number of rows per output Parquet file. Default is `1e7` (10
  million rows).

## Value

Converted Parquet files, saved in original location of input files.

## See also

[`arrow::open_dataset()`](https://arrow.apache.org/docs/r/reference/open_dataset.html),
[`arrow::write_dataset()`](https://arrow.apache.org/docs/r/reference/write_dataset.html)

## Examples

``` r
if (FALSE) { # \dontrun{

# Assuming 'folderX' containing 10 sub-folders
# (3 folders of city A, 3 folders of city B, and 4 folders of city C) with CSV files,
# convert all the data of city C to Parquet format:

get_parquet_arrow(folder_path = "path/to/folderX",
                  pattern = "city_C")
} # }
```
