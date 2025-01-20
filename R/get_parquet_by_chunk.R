#' Convert file to Parquet format by chunks
#'
#' Process large file by reading it in chunks and writing each chunk as
#' separate Parquet files.
#'
#' @param input_path A string path to the file to be converted.
#' @param output_folder A string path to the folder where the Parquet files will be saved.
#' @param chunk_no A numeric vector specifying the chunks to process,
#'      with 0 for the first chunk, 1 for the second, and so on.
#' @param nrows_to_read A numeric value indicating how many rows to read for each chunk.
#' @param column_names A character vector of column names.
#' @param max_rows_per_file Maximum number of rows per output Parquet file.
#'      Default is `1e7` (10 million rows).
#'
#' @details
#' The `chunk_no` parameter specifies which chunks to process,
#' with 0 for the first chunk, 1 for the second, and so on.
#' The converted Parquet files will be named according to the pattern
#' `part{chunk_number}-{i}.parquet`.
#'
#' @returns Converted Parquet files.
#'
#' @seealso [data.table::fread()], [arrow::write_dataset()]
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' # Assuming a large CSV file located at "path/to/input.csv",
#' # convert it to Parquet format by processing it in chunks.
#' # The output will be saved in "path/to/output_folder".
#'
#' get_parquet_by_chunk(
#'   input_path = "path/to/input.csv",
#'   output_folder = "path/to/output_folder",
#'   chunk_no = 0:19,
#'   nrows_to_read = 100000,
#'   column_names = c("col1", "col2", "col3", "col4"),
#'   max_rows_per_file = 5000000
#' )
#' }
#'

get_parquet_by_chunk <- function(input_path,
                                 output_folder,
                                 chunk_no,
                                 nrows_to_read,
                                 column_names,
                                 max_rows_per_file = 1e7){

        chunk <- vector("list", length(chunk_no))
        for (a in seq_along(chunk_no)) {

                chunk[[a]] <- data.table::fread(
                        input_path,
                        skip = nrows_to_read*chunk_no[[a]]+1,
                        nrows = nrows_to_read,
                        header = FALSE) %>%
                        dplyr::rename_with(~column_names)

                arrow::write_dataset(
                        dataset = chunk[[a]],
                        format = "parquet",
                        path = output_folder,
                        max_rows_per_file = max_rows_per_file,
                        basename_template = paste0("part", chunk_no[[a]], "-{i}.parquet"))
        }
}
