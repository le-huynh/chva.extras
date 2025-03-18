#' Interpolate missing values in grouped data
#'
#' Perform linear interpolation to fill missing (`NA`) values in specified
#' columns (`vars2`), with grouping based on a unique row identifier (`var1`).
#' Interpolation is performed row-wise.
#' See **Examples** for the structure of input data.
#'
#' @param data A data frame containing the variables to be interpolated.
#' @param var1 A variable serving as the unique row identifier (group).
#'        Each value in `var1` must be unique.
#'        If duplicate values exist, the function will return an error.
#' @param vars2 A vector specifying the numeric columns to interpolate.
#' @param maxgap An integer defining the maximum number of consecutive `NA`
#'      values to interpolate. Defaults to `1`.
#'      If gaps exceed this limit, the values remain `NA`.
#' @param rule An integer (1 or 2) specifying the extrapolation rule.
#'      Defaults to `1`, meaning no extrapolation beyond available data range.
#'      Rule `2` uses the nearest observed value for out-of-range points.
#'      A vector (e.g., `rule = c(2,1)`) can specify different
#'      extrapolation rules for the left and right sides.
#'
#' @returns A data frame with missing values interpolated in `vars2`.
#' @export
#'
#' @examples
#' df <- data.frame(
#'   date = c("2022-03-01", "2022-08-13", "2023-02-09", "2024-09-22"),
#'   temp_1am = c(NA, 20, 5, 24),
#'   temp_6am = c(6, NA, 6, NA),
#'   temp_11am = c(13, 25, 8, NA),
#'   temp_4pm = c(18, 30, NA, 30)
#' )
#'
#' interpolate_na(df,
#'                var1 = "date",
#'                vars2 = c("temp_1am", "temp_6am", "temp_11am", "temp_4pm"))
#'
#' interpolate_na(df,
#'                var1 = "date",
#'                vars2 = c("temp_1am", "temp_6am", "temp_11am", "temp_4pm"),
#'                rule = 2)

interpolate_na <- function(data,
                           var1,
                           vars2,
                           maxgap = 1,
                           rule = 1){

        # Check for duplicate groups
        duplicate_groups <- data %>%
                dplyr::count(!!rlang::sym({{var1}})) %>%
                dplyr::filter(n > 1)

        if (nrow(duplicate_groups) > 0) {
                stop("Error: Duplicate values detected in '",
                     rlang::as_string(rlang::ensym(var1)),
                     "'. Each row must have a unique group identifier.")
        }

        # Perform interpolation
        res <- data %>%
                dplyr::select({{var1}}, {{vars2}}) %>%
                tidyr::nest(.by = {{var1}}) %>%
                dplyr::mutate(approx = purrr::map(data,
                                                  ~ {unlist(.) %>%
                                                      zoo::na.approx(na.rm = FALSE,
                                                                     maxgap = maxgap,
                                                                     rule = rule) %>%
                                                      t() %>%
                                                      tibble::as_tibble()}
                                    )) %>%
                tidyr::unnest(cols = c(approx)) %>%
                dplyr::select(-data)

        return(res)
}
