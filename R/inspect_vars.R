

# Inspect function --------------------------------------------------------


#' Inspect a data frame
#'
#' @param data_frame The data.frame to explore. Need to exist in the Global Environment.
#' @param nrow Logical. If TRUE, the number of observations of the dataset is rendered in addition.
#' @return Variable list of the dataset and systematic informations for each variable.
#' @examples
#' inspect(diamonds)

inspect <- function(data_frame, nrow = FALSE) {

  require(magrittr)

  # Observations:
  rows <- nrow(data_frame)
  df <- data_frame %>%

    # Date-time class correction to make it compatible with class(.x):
    dplyr::mutate_if(lubridate::is.POSIXct, \(x)
                     as.character(x) %>% structure(class = "Date-time")) %>%

    # Computing inspection infos:
    purrr::map_df(~ {
      dplyr::tibble(
        class = class(.x),
        nb_distinct = dplyr::n_distinct(.x),
        prop_distinct = nb_distinct / rows,
        nb_na = sum(is.na(.x)),
        prop_na = nb_na / rows,
        nb_void = sum(.x == "", na.rm = TRUE),
        prop_void = nb_void / rows,
        modalities = paste(sort(unique(.x))[
          1:min(dplyr::n_distinct(.x), 10)],
          collapse =
            " / ")
      )
    }, .id = "variables")
  if (nrow) {
    print(nrow(data_frame))
    df
  } else
    df
}

