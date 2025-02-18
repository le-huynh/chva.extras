#' Get full working datasets
#'
#' Get full working datasets as a named list of
#' [Dataset](https://arrow.apache.org/docs/r/reference/Dataset.html) R6 objects.
#' Each dataset is opened from files matching the given pattern, and the names
#' of the list elements correspond to the file names.
#'
#' @param folder_path A string path to the directory containing sub-directories
#'      of input Parquet files.
#' @param pattern A string to filter the sub-directories of input files by names.
#'
#' @returns A named list of datasets.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' datasets <- get_dataset(folder_path = "path/to/data_folder", pattern = "Facility")
#' }
#'

get_dataset <- function(folder_path,
                        pattern){

        dataset <- fs::dir_ls(path = folder_path) %>%
                stringr::str_subset(pattern = pattern) %>%
                purrr::set_names(basename) %>%
                purrr::map(arrow::open_dataset)

        return(dataset)

}
