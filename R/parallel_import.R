
# ext_tract ---------------------------------------------------------------

#' Isolate the last level of an absolute file path
#' @param path A valid R path
#' @param split Path levels delimiter
#' @return A character vector corresponding to the last level of the path
#'
ext_tract <- function (path, split = "/") {

  requireNamespace("magrittr")

  strsplit(path, split = split) %>%
    purrr::map(\(y) y[length(y)]) %>%
    unlist()
}


# parallel_import ---------------------------------------------------------

#' Import a collection of datasets into the Global Environment
#' @param file_paths A character vector of valid absolute file paths of
#' datasets to import
#' @return After jobs completion, see the datasets imported in the Global Environment
#' @importFrom magrittr %>%
#' @export
#'
parallel_import <- function (file_paths) {

  requireNamespace("magrittr")

  # For each absolute file path inputted, launch a background job that
  # imports the data set mentioned in the corresponding path;
  # the R object being the file name itself:
  purrr::map(file_paths,
             \(x) {job::job({

               library(magrittr)

               assign(ext_tract(x),
                      dplyr::as_tibble(rio::import(x)),
                      pos = - 1)
             })
             })
}
