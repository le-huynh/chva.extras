
#' Recode values based on grouping logic
#'
#' This function groups data by `var1` and recodes `var2` based on specific conditions.
#' If `var1` has only one unique `var2` value, the original value is retained.
#' If `var1` has two unique `var2` values, the known value is assigned if one matches `unknown_category`;
#' otherwise, `unknown_category` is assigned.
#' If `var1` has more than two unique `var2` values, `unknown_category` is assigned.
#'
#' @param data A data frame or an element of a list dataset
#'      (output from [chva.extras::get_dataset()]).
#' @param var1 A character string specifying the grouping variable.
#' @param var2 A character string specifying the variable to be recoded.
#' @param unknown_category A character string specifying the ambiguous or
#'      unknown values in `var2`.
#'
#' @returns A data frame with `var1` and recoded `var2`.
#' @export
#'
#' @examples
#' df <- data.frame(ID = c(1, 1, 2, 2, 3, 3, 3),
#'                  Gender = c("Male", "Unknown", "Female", "Female", "Male", "Female", "Unknown"))
#' df
#'
#' recode_values(df, var1 = "ID", var2 = "Gender", unknown_category = "Unknown")
#'

recode_values<- function(data,
                         var1,
                         var2,
                         unknown_category){

        df1 <- data %>%
                dplyr::select({{var1}}, {{var2}}) %>%
                dplyr::distinct() %>%
                dplyr::collect()

        df2 <- df1 %>%
                dplyr::rename(col2 = {{var2}}) %>%
                tidyr::nest(.by = {{var1}}) %>%
                dplyr::mutate(nval = purrr::map_dbl(data, nrow))

        # nval == 1
        df_n1 <- df2 %>%
                dplyr::filter(nval == 1) %>%
                dplyr::mutate("{var2}" := purrr::map_chr(data, dplyr::pull)) %>%
                dplyr::select({{var1}}, {{var2}})

        # nval == 2
        df_n2 <- df2 %>%
                dplyr::filter(nval == 2) %>%
                dplyr::mutate(
                  "{var2}" :=
                    purrr::map_chr(data,
                                   ~dplyr::case_when(
                                       length(lubridate::setdiff(unique(.x$col2),
                                                                 unknown_category)) == 1 ~ lubridate::setdiff(unique(.x$col2),
                                                                                                              unknown_category),
                                       length(lubridate::setdiff(unique(.x$col2),
                                                                 unknown_category)) > 1 ~ unknown_category,
                                               TRUE ~ NA_character_ )[[1]])) %>%
                dplyr::select({{var1}}, {{var2}})

        # nval > 2
        df_n3 <- df2 %>%
                dplyr::filter(nval > 2) %>%
                dplyr::mutate("{var2}" := unknown_category) %>%
                dplyr::select({{var1}}, {{var2}})

        res <- df_n1 %>%
                dplyr::full_join(df_n2) %>%
                dplyr::full_join(df_n3)

        return(res)
}

