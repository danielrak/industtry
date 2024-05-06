
# Show duplicates ---------------------------------------------------------------


#' Show observations of all duplicated values of a variable or a combination of variables
#' @param data_frame Input data frame. Need to be in the Global Environment and has a data.frame class
#' @param vars A character vector of variable or combination of variables
#' from which duplicates are checked
#' @return The part inputted data frame with all observations of duplicated values of
#' indicated variable or combination of variables
#' @importFrom magrittr %>%
#' @export
#'
dupl_show <- function (data_frame, vars) {

  requireNamespace("magrittr")
  # Insert element-wise combination of vars input components within the data:
  # idvarsdupl
  data <- dplyr::mutate(data_frame,
                        idvarsdupl =
                          do.call(what = paste,
                                  purrr::map(vars, function (x)
                                    data_frame[[x]])))

  # Filter rows with values of idvarsdupl that appears
  # at least for the second time:
  data %>% dplyr::filter(duplicated(idvarsdupl)) %>%

    # extract idvarsdupl variable from the filtered data:
    dplyr::pull(idvarsdupl) %>%

    # extract all corresponding observations from data input:
    (function (p) dplyr::filter(data, idvarsdupl %in% p)) %>%

    # arrange values to visualize the duplicated cases:
    dplyr::arrange(!!dplyr::sym("idvarsdupl")) %>%

    # put vars input to first variable(s) location(s):
    dplyr::relocate(dplyr::all_of(vars)) %>%

    # remove idvarsdupl:
    dplyr::select(- !!dplyr::sym("idvarsdupl"))
}

# Illustrate sources of duplicates ---------------------------------------

#' Illustrate sources of all duplicated values of a variable or a combination of variables
#' @param data_frame Input data frame. Need to be in the Global Environment and has a data.frame class
#' @param vars A character vector of variable or combination of variables
#' from which duplicates are checked
#' @return For each duplicated row regarding to vars, different values of the same variable
#' are shown, separated by AND
#' @importFrom magrittr %>%
#' @export
#'
dupl_sources <- function (data_frame, vars) {

  requireNamespace("magrittr")
  # Insert element-wise combination of vars input components within the data:
  # idvarsdupl
  data <- dplyr::mutate(data_frame,
                        idvarsdupl =
                          do.call(what = paste,
                                  purrr::map(vars, function (x)
                                    data_frame[[x]])))

  # Filter rows with values of idvarsdupl that appears
  # at least for the second time:
  data %>% dplyr::filter(duplicated(idvarsdupl)) %>%

    # extract idvarsdupl variable from the filtered data:
    dplyr::pull(idvarsdupl) %>%

    # extract all corresponding observations from data input:
    (function (p) dplyr::filter(data, idvarsdupl %in% p)) %>%

    # arrange values to visualize the duplicated cases:
    dplyr::arrange(!!dplyr::sym("idvarsdupl")) %>%

    # put vars input to first variable(s) location(s):
    dplyr::relocate(dplyr::all_of(vars)) %>%

    (\(d) dplyr::group_by(d, !!dplyr::sym("idvarsdupl")) %>%
        dplyr::summarise_all(\(x) na.omit(unique(x)) %>%
                                paste0(collapse = " [AND] ")) %>%
        dplyr::ungroup() %>%
        apply(1, \(x) c(paste0(x[[1]], collapse = " "),
                        x[str_detect(x, " \\[AND\\] ")]))) %>%
    purrr::map(as.data.frame)
}
