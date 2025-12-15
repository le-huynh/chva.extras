# Delete multiple CSV files

This function is executed after converting CSV files to Parquet format
using
[`get_parquet_arrow()`](https://le-huynh.github.io/chva.extras/reference/get_parquet_arrow.md)
or
[`get_parquet_by_chunk()`](https://le-huynh.github.io/chva.extras/reference/get_parquet_by_chunk.md).
It deletes the original CSV files from the sub-folders in the specified
folder, once they have been successfully converted to Parquet. The
function filters sub-folders by the provided pattern and deletes the
corresponding CSV files.

## Usage

``` r
delete_csv(folder_path, pattern)
```

## Arguments

- folder_path:

  A string path to the directory containing sub-directories of the files
  to be deleted.

- pattern:

  A string to filter the sub-directories of csv files by names.

## Value

The deleted paths (invisibly).

## Examples

``` r
if (FALSE) { # \dontrun{
delete_csv(folder_path = "path/to/data_folder", pattern = "Facility")
} # }
```
