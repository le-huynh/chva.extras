% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_parquet_by_chunk.R
\name{get_parquet_by_chunk}
\alias{get_parquet_by_chunk}
\title{Convert file to Parquet format by chunks}
\usage{
get_parquet_by_chunk(
  input_path,
  output_folder,
  chunk_no,
  nrows_to_read,
  column_names,
  max_rows_per_file = 1e+07
)
}
\arguments{
\item{input_path}{A string path to the file to be converted.}

\item{output_folder}{A string path to the folder where the Parquet files will be saved.}

\item{chunk_no}{A numeric vector specifying the chunks to process,
with 0 for the first chunk, 1 for the second, and so on.}

\item{nrows_to_read}{A numeric value indicating how many rows to read for each chunk.}

\item{column_names}{A character vector of column names.}

\item{max_rows_per_file}{Maximum number of rows per output Parquet file.
Default is \code{1e7} (10 million rows).}
}
\value{
Converted Parquet files.
}
\description{
Process large file by reading it in chunks and writing each chunk as
separate Parquet files.
}
\details{
The \code{chunk_no} parameter specifies which chunks to process,
with 0 for the first chunk, 1 for the second, and so on.
The converted Parquet files will be named according to the pattern
\verb{part\{chunk_number\}-\{i\}.parquet}.
}
\examples{
\dontrun{

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
}

}
\seealso{
\code{\link[data.table:fread]{data.table::fread()}}, \code{\link[arrow:write_dataset]{arrow::write_dataset()}}
}
