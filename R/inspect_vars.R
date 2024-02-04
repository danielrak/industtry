

# Inspect function --------------------------------------------------------

inspect <- function(dataframe, nrow = FALSE) {
  # observations
  rows <- nrow(dataframe)
  df <- dataframe %>%
    # Date-time class correction to make it compatible with class(.x)
    dplyr::mutate_if(lubridate::is.POSIXct, function (x)
      as.character(x) %>% structure(class = "Date-time")) %>%
    # Computing inspection infos
    purrr::map_df(~ {
      dplyr::tibble(
        type = class(.x),
        nb_dis = dplyr::n_distinct(.x),
        prop_dis = nb_dis / rows,
        nb_na = sum(is.na(.x)),
        prop_na = nb_na / rows,
        nb_vide = sum(.x == "", na.rm = TRUE),
        prop_vide = nb_vide / rows,
        modalite = paste(sort(unique(.x))[
          1:min(dplyr::n_distinct(.x), 10)],
          collapse =
            " / ")
      )
    }, .id = "colonne")
  if (nrow) {
    print(nrow(dataframe))
    df
  } else
    df
}

