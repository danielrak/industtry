# paths_and_files

# Current script location -------------------------------------------------

#'Get exact path of the currently opened script
#' @examples current_script_location()
#'
current_script_location <- function (x) {

  require(magrittr)

  rstudioapi::getSourceEditorContext()$path %>%
    strsplit("\\/") %>% unlist %>%
    (\(u) u[- length(u)]) %>%
    paste(collapse = "/")
}

#' A wrapper of current_script_location()
#' @aliases current_script_location()
#' @examples csloc()
#'
csloc <- current_script_location

# Filename extraction given a filepath ------------------------------------

#' Extract filename given a filepath
#' @param filepath A 1L character vector. The file path from which file name will be extracted
#' @param split Indicates the path separator symbol
#' @return Last level of filepath
#' @examples file_extract(filepath = "level_1/level_2/file.ext",
#'                        split = "/")
#'
file_extract <- function (filepath, split = "/") {

  require(magrittr)

  strsplit(filepath, split = split) %>%
    purrr::map(\(x) x[length(x)]) %>%
    unlist
}
