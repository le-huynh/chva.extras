#' Convert multiple files to Parquet format
#'
#' Convert multiple files from a specified format (e.g., CSV) to Parquet format.
#' The converted Parquet files are saved in the original location of the input files,
#' allowing for efficient storage and retrieval of large datasets.
#'
#' @param folder_path A string path to the directory containing
#'      sub-directories of input files.
#' @param pattern A string to filter the sub-directories of input files by names.
#' @param input_format A string indicating format of input files.
#'      Default is `"csv"`. Other supported formats are listed in [arrow::open_dataset()].
#' @param max_rows_per_file Maximum number of rows per output Parquet file.
#'      Default is `1e7` (10 million rows).
#'
#' @returns Converted Parquet files, saved in original location of input files.
#'
#' @seealso [arrow::open_dataset()], [arrow::write_dataset()]
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' # Assuming 'folderX' containing 10 sub-folders
#' # (3 folders of city A, 3 folders of city B, and 4 folders of city C) with CSV files,
#' # convert all the data of city C to Parquet format:
#'
#' get_parquet_arrow(folder_path = "path/to/folderX",
#'                   pattern = "city_C")
#' }
#'
get_parquet_arrow <- function(folder_path,
                              pattern,
                              input_format = "csv",
                              max_rows_per_file = 1e7){

        # list all files in the specified directory and filter them by a pattern
        folder_list <- fs::dir_ls(path = folder_path) %>%
                tibble::as_tibble() %>%
                dplyr::filter(stringr::str_detect(value, pattern)) %>%
                dplyr::pull()

        for (i in seq_along(folder_list)) {

                # open the dataset from the current file
                dataset <- arrow::open_dataset(folder_list[[i]],
                                               format = input_format)

                # write the dataset to the original location with a specified format
                arrow::write_dataset(
                        dataset,
                        format = "parquet",
                        path = folder_list[[i]],
                        max_rows_per_file = max_rows_per_file
                )
        }
}
