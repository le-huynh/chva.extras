#' Get counts by category in wide format
#'
#' Summarize the number of occurrences of each category (in `count_column`)
#' within each group (defined by `group_column`). The result is returned
#' in a wide format, where each unique category becomes a column.
#' Missing combinations are filled with 0.
#'
#' @param data A data frame.
#' @param group_column A column specifying the grouping variable.
#' @param count_column A column containing the categories to count within each group.
#' @param names_prefix A character string added as a prefix to each of the
#'      resulting column names.
#'
#' @returns A tibble in wide format with counts of each category per group.
#' @export
#'
#' @examples
#'
#' df <- data.frame(
#'   Incurred_Date = as.Date(c('2021-01-01', '2021-01-01', '2021-01-02')),
#'   Status = c("Open", "Closed", "Open")
#' )
#' get_counts_by_category(df,
#'                        group_column = Incurred_Date,
#'                        count_column = Status,
#'                        names_prefix = "Status_")
#'

get_counts_by_category <- function(data,
                                   group_column,
                                   count_column,
                                   names_prefix){

        res <- data %>%
                dplyr::count({{group_column}}, {{count_column}}) %>%
                tidyr::pivot_wider(names_from = {{count_column}},
                                   values_from = "n",
                                   names_prefix = names_prefix) %>%
                dplyr::mutate(dplyr::across(.cols = dplyr::contains(names_prefix),
                                            ~ dplyr::case_when(is.na(.x) ~ 0,
                                                               TRUE ~ .x))) %>%
                dplyr::arrange({{group_column}})

        return(res)
}
