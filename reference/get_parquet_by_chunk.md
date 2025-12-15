# Convert file to Parquet format by chunks

Process large file by reading it in chunks and writing each chunk as
separate Parquet files.

## Usage

``` r
get_parquet_by_chunk(
  input_path,
  output_folder,
  chunk_no,
  nrows_to_read,
  column_names,
  max_rows_per_file = 1e+07
)
```

## Arguments

- input_path:

  A string path to the file to be converted.

- output_folder:

  A string path to the folder where the Parquet files will be saved.

- chunk_no:

  A numeric vector specifying the chunks to process, with 0 for the
  first chunk, 1 for the second, and so on.

- nrows_to_read:

  A numeric value indicating how many rows to read for each chunk.

- column_names:

  A character vector of column names.

- max_rows_per_file:

  Maximum number of rows per output Parquet file. Default is `1e7` (10
  million rows).

## Value

Converted Parquet files.

## Details

The `chunk_no` parameter specifies which chunks to process, with 0 for
the first chunk, 1 for the second, and so on. The converted Parquet
files will be named according to the pattern
`part{chunk_number}-{i}.parquet`.

## See also

[`data.table::fread()`](https://rdatatable.gitlab.io/data.table/reference/fread.html),
[`arrow::write_dataset()`](https://arrow.apache.org/docs/r/reference/write_dataset.html)

## Examples

``` r
if (FALSE) { # \dontrun{

# Assuming a large CSV file located at "path/to/input.csv",
# convert it to Parquet format by processing it in chunks.
# The output will be saved in "path/to/output_folder".

get_parquet_by_chunk(
  input_path = "path/to/input.csv",
  output_folder = "path/to/output_folder",
  chunk_no = 0:19,
  nrows_to_read = 100000,
  column_names = c("col1", "col2", "col3", "col4"),
  max_rows_per_file = 50000
)
} # }
```
