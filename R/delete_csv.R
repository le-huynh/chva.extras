#' Delete multiple CSV files
#'
#' This function is executed after converting CSV files to Parquet format using
#' [chva.extras::get_parquet_arrow()] or [chva.extras::get_parquet_by_chunk()].
#' It deletes the original CSV files from the sub-folders in the specified folder,
#' once they have been successfully converted to Parquet. The function filters
#' sub-folders by the provided pattern and deletes the corresponding CSV files.
#'
#' @param folder_path A string path to the directory containing sub-directories
#'      of the files to be deleted.
#' @param pattern A string to filter the sub-directories of csv files by names.
#'
#' @returns The deleted paths (invisibly).
#' @export
#'
#' @examples
#' \dontrun{
#' delete_csv(folder_path = "path/to/data_folder", pattern = "Facility")
#' }
#'

delete_csv <- function(folder_path,
                       pattern){

        fs::dir_ls(path = folder_path) %>%
                stringr::str_subset(pattern = pattern) %>%
                fs::dir_ls(lob = "*.csv") %>%
                purrr::map(fs::file_delete)

}
