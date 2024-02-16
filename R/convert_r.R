# Compatible mask ---------------------------------------------------------

#' Create an excel mask compatible with the convert_r() function
#' @param output_path Folder path where the mask will be created
#' @param output_filename File name (with extension) of the mask
#' @export
#'
mask_convert_r <- function (output_path,
                            output_filename = "mask_convert_r.xlsx") {

  mask <- data.frame(folder_path = NA,
                     file = NA,
                     converted_file = NA,
                     to_convert = NA)

  writexl::write_xlsx(mask,
                      path = file.path(output_path,
                                       output_filename))
}


# convert_r() -------------------------------------------------------------

#' Industrialized dataset formats conversion
#' @param mask_filepath Entire file path of the excel mask
#' @param output_path Folder path where the converted datasets will be placed
#' @importFrom magrittr %>%
#' @export
#'
convert_r <- function (mask_filepath, output_path) {

  requireNamespace("magrittr")

  # import mask:
  prm <- rio::import(mask_filepath)

  # filter only datasets to convert:
  prm <- dplyr::filter(prm, to_convert == 1)

  # indicate row number (technically useful):
  prm <- dplyr::mutate(prm, row_number = 1:nrow(prm))

  # transform imported mask of r rows into a list of r elements:
  sp <- split(prm, prm$row_number) %>%
    magrittr::set_names(paste0(prm$folder_path, "/", prm$file))

  # for each element of the list, run a job that
  # (1) import indicated datasets,
  # (2) for imported datasets, replace void character values with real NAs,
  # (3) eliminate eventual spaces in character values corners,
  # (4) export resulting dataset in output_path as indicated in the mask
  sp %>% (\(l) {
    purrr::map(names(l), \(x) {
      l <- l
      output_path <- output_path
      job::job({

        library(magrittr)

        rio::import(file.path(l[[x]][["folder_path"]], l[[x]][["file"]])) %>%
          dplyr::mutate_all(\(y) {y[nchar(y) == 0] <- NA ; y}) %>%
          dplyr::mutate_if(is.character, stringr::str_trim()) %>%
          rio::export(file.path(output_path, l[[x]][["converted_file"]]))
        job::export("none")
      }, title = x %>% strsplit("/") %>%
        purrr::map(\(xx) xx[length(xx)]) %>% unlist)
    })
  })
}
