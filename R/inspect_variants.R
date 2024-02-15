# inspect_variants

#' Inspect a data frame and write the output in an excel file
#'
#' @param data_frame_name Character vector.
#' The data.frame to explore. Need to exist in the Global Environment
#' @param output_path Folder path where to write the excel output
#' @param output_label Optional 1-length character vector to label output file.
#' If NULL, data_frame_name will also used as label
#' @return Variable list of the dataset and systematic informations for each variable
#' @importFrom magrittr %>%
#' @export
#'

inspect_write <- function (data_frame_name, output_path, output_label = NULL) {

  requireNamespace("magrittr")

  if (is.null(output_label)) {

    name <- data_frame_name
  } else {

    name <- output_label
  }

  df <- get(data_frame_name)

  writexl::write_xlsx(
    inspect(df) %>%
      (\(i)
        rbind(
          c("Obs = ", nrow(df),
            rep("", ncol(i) - 1)),
          c("Nvars = ", nrow(i),
            rep("", ncol(i) - 1)),
          cbind(1:nrow(i), i)
        )),
    file.path(output_path, paste0("inspect_", name, ".xlsx")))
}
