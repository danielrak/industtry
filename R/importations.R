
# parallel_import ---------------------------------------------------------

#' Import a collection of datasets into the Global Environment (parallelized)
#' @param file_paths A character vector of valid absolute file paths of
#' datasets to import
#' @return After jobs completion, see the datasets imported in the Global Environment
#' @importFrom magrittr %>%
#' @export
#'
parallel_import <- function (file_paths) {

  # For each absolute file path inputted, launch a background job that
  # imports the data set mentioned in the corresponding path;
  # the R object being the file name itself:
  purrr::map(file_paths,
             \(x) {job::job({

               assign(file_extract(x),
                      rio::import(x),
                      pos = - 1)

               invisible()
             }, title = paste0("Importation of ",
                               file_extract(x)))
             })
}


# serial_import ---------------------------------------------------------

#' Import a collection of datasets into the Global Environment (serialized)
#' @param file_paths A character vector of valid absolute file paths of
#' datasets to import
#' @return After completion, see the datasets imported in the Global Environment
#' @importFrom magrittr %>%
#' @export
#'
serial_import <- function (file_paths) {

  # For each absolute file path inputted, launch a background job that
  # imports the data set mentioned in the corresponding path;
  # the R object being the file name itself:
  purrr::map(file_paths,
             \(x) {

               assign(file_extract(x),
                      rio::import(x),
                      pos = globalenv())

               invisible()
             })
}
