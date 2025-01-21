#' Check dataset overview
#'
#' Provide an overview of datasets within a specified directory that match a given pattern.
#' Return a summary with the number of rows, columns, and a flag indicating
#' whether the column names across datasets are consistent.
#'
#' @param folder_path A string path to the directory containing sub-directories
#'      of input Parquet files. The path should not end with a forward slash (`/`).
#' @param pattern A string to filter the sub-directories of input files by names.
#'
#' @returns A tibble summarizing the datasets, with columns:
#'   \item{name}{The name of each dataset file.}
#'   \item{nrow}{The number of rows in each dataset.}
#'   \item{ncol}{The number of columns in each dataset.}
#'   \item{matched_column_names}{A logical value indicating whether
#'      the column names match.}
#'
#' @note
#' Ensure that `folder_path` does not end with a forward slash (`/`) to
#' avoid potential issues with file path concatenation.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' overview <- check_overview(folder_path = "path/to/data_folder", pattern = "Facility")
#' }
#'

check_overview <- function(folder_path,
                           pattern){

        dataset <- chva.extras::get_dataset(folder_path = folder_path,
                                            pattern = pattern)

        df_overview <- tibble::tibble(name = names(dataset),
                                      nrow = purrr::map_dbl(dataset, nrow),
                                      ncol = purrr::map_dbl(dataset, ncol),
                                      matched_column_names = purrr::map_lgl(dataset,
                                                      ~ identical(names(dataset[[1]]),
                                                                  names(.x))))
        return(df_overview)

}
