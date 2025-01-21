#' Get full working datasets
#'
#' Get full working datasets as a named list of
#' [Dataset](https://arrow.apache.org/docs/r/reference/Dataset.html) R6 objects.
#' Each dataset is opened from files matching the given pattern, and the names
#' of the list elements correspond to the file names.
#'
#' @param folder_path A string path to the directory containing sub-directories
#'      of input Parquet files. The path should not end with a forward slash (`/`).
#' @param pattern A string to filter the sub-directories of input files by names.
#'
#' @returns A named list of datasets.
#'
#' @note
#' Ensure that `folder_path` does not end with a forward slash (`/`) to
#' avoid potential issues with file path concatenation.
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

        folder_list <- fs::dir_ls(path = folder_path) %>%
                tibble::as_tibble() %>%
                dplyr::filter(stringr::str_detect(value, pattern)) %>%
                dplyr::pull()

        dataset <- vector("list", length(folder_list))
        file_name_output <- vector("character", length(folder_list))

        for (i in seq_along(folder_list)) {

                dataset[[i]] <- arrow::open_dataset(folder_list[[i]])
                file_name_output[[i]] <- stringr::str_split(folder_list[[i]],
                                                            paste0(folder_path, "/"),
                                                            simplify = TRUE)[,2]
        }

        dataset <- purrr::set_names(dataset, file_name_output)
        return(dataset)

}
