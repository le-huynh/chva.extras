#' Check unique values in a column
#'
#' `check_unique_value()` counts the unique values of a specified column.
#'
#' @param data A data frame (for `check_unique_value()`) or a list of outputs
#'      from `check_unique_value()` (for `check_unique_value_overview()`).
#' @param column_to_check A column to check for unique values,
#'      using `column_name` without quotes.
#'
#' @returns
#' - `check_unique_value()`: A tibble with the unique values in
#'      the specified column and their counts.
#'
#' @export
#'
#' @examples
#'
#' list_mtcars <- list(data1 = mtcars, data2 = mtcars, data3 = mtcars)
#'
#' res_list <- list_mtcars %>%
#'         purrr::map(check_unique_value, column_to_check = cyl)
#'
#' check_unique_value_overview(res_list, column_to_check = cyl)
#'

check_unique_value <- function(data,
                               column_to_check){
        res <- data %>%
                dplyr::select({{column_to_check}}) %>%
                dplyr::count({{column_to_check}}) %>%
                dplyr::arrange({{column_to_check}}) %>%
                dplyr::collect()

        return(res)

}

#' check_unique_value_overview()
#'
#' `check_unique_value_overview()` takes a list of outputs from `check_unique_value()`
#' and checks the consistency of unique values within a specified column across multiple datasets.
#'
#' @rdname check_unique_value
#'
#' @returns
#' - `check_unique_value_overview()`: A tibble summarizing the number of
#'      unique values in each element of the list and indicating whether
#'      the unique values are consistent across all list elements.
#'
#' @export
#'

check_unique_value_overview <- function(data,
                                        column_to_check){

   res <- tibble::tibble(name = names(data),
                         unique_val_number = purrr::map_dbl(data, nrow),
                         matched_unique_val =
                                 purrr::map_lgl(data,
                                         ~ identical(data[[1]] %>% dplyr::pull({{column_to_check}}),
                                                     .x %>% dplyr::pull({{column_to_check}}))))

   return(res)

}
