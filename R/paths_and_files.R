# paths_and_files

# Current script location -------------------------------------------------

#'Get exact path of the currently opened script
#' @return A character vector indicating exact path of currently opened script
#' @importFrom magrittr %>%
#' @export
#'
current_script_location <- function () {

  requireNamespace("magrittr")

  rstudioapi::getSourceEditorContext()$path %>%
    strsplit("\\/") %>% unlist %>%
    (\(u) u[- length(u)]) %>%
    paste(collapse = "/")
}

#' A wrapper of current_script_location()
#' @aliases current_script_location()
#' @importFrom magrittr %>%
#' @export
#'
csloc <- current_script_location

# Filename extraction given a filepath ------------------------------------

#' Extract filename given a filepath
#' @param file_path A 1L character vector. The file path from which file name will be extracted
#' @param split Indicates the path separator symbol
#' @return Last level of filepath
#' @examples
#' library(magrittr)
#' file_extract(file_path = "level_1/level_2/file.ext",
#'                        split = "/")
#' @importFrom magrittr %>%
#' @export
#'
file_extract <- function (file_path, split = "/") {

  requireNamespace("magrittr")

  strsplit(file_path, split = split) %>%
    purrr::map(\(x) x[length(x)]) %>%
    unlist()
}

# Replicate folder structure ----------------------------------------------

#' Replicate the folder structure of a given directory
#' @param dir Path of directory which structure will be replicated
#' @param to Path of an output directory in which replicated structured will be placed
#' @importFrom magrittr %>%
#' @export
#'
folder_structure_replicate <- function (dir, to) {

  requireNamespace("magrittr")

  list.dirs(dir, full.names = FALSE) %>%
    (\(l) for (i in l)
      dir.create(file.path(to, i), recursive = TRUE))
}


#' A wrapper of folder_structure_replicate()
#' @param dir Path of directory which structure will be replicated
#' @param to Path of an output directory in which replicated structured will be placed
#' @aliases folder_structure_replicate()
#' @importFrom magrittr %>%
#' @export
#'
fsrepl <- folder_structure_replicate


# Path level --------------------------------------------------------------

# Needs revision.

#' Extract a part of file path with levels
#' @param path Path to process
#' @param level Positive or negative integer. Level of the path, see example.
#' @examples
#' library(magrittr)
#' path_level("level_1/level_2/file.ext", 1)
#' path_level("level_1/level_2/file.ext", - 1)
#' @importFrom magrittr %>%
#' @export
#'
path_level <- function (path, level) {

  requireNamespace("magrittr")

  strsplit(path, "/") %>%
    purrr::map(\(x) x[

      if(level > 0) {level} else
        if (level < 0) {1:(length(x) + level)} else
          stop("The level argument must be a strictly positive or strictly negative integer.")
      ] %>%
           paste(collapse = "/")) %>%
    unlist()
}


# Path move not included / need revision ----------------------------------

