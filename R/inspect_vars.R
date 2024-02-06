

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

# Variable detection pattern function -------------------------------------

vars_detect <- function (data_frames) {

  require(magrittr)

  out_data <- data_frames %>%
    purrr::map(\(x) get(x) %>% names %>% as.data.frame %>%
                 setNames(x) %>% (\(x2) cbind(x2, x2) %>%
                                    (\(c) {
                                      colnames(c)[1] <- "union"
                                      c
                                    }))) %>%
    (\(l)
     plyr::join_all(list(as.data.frame(unique(unlist(l))),
                         l %>% purrr::map(as.data.frame)) %>%
                      purrr::flatten() %>%
                      (\(l2) {
                        l2[[1]] <- as.data.frame(l2[[1]]) %>%
                          setNames("union")
                        l2
                      }), type = "left")) %>%
    (\(d) {
      cbind(d[, 1],
            dplyr::mutate_all(d[, 2:ncol(d)],
                              \(x) ifelse(! is.na(x), "ok", "-"))) %>%
        (\(d2) {names(d2)[1] <- "vars_union" ; d2})
    })

  # Arranging lines to better visualize presence/absence patterns.
  # Critrias: rkfirst_ok, desc(nb_ok_conseq), desc(rkfirst_out),
  # desc(nb_out_conseq):

  rkfirst_ok <- out_data[, - 1] %>%
    apply(1, function (x) min(which(x == "ok")))

  nb_ok_conseq <- out_data %>%
    apply(1, function (x) rle(as.numeric(x == "ok"))$lengths[2])

  rkfirst_out <- out_data[, - 1] %>%
    apply(1, function (x) min(which(x == "-")))

  nb_out_conseq <- out_data %>%
    apply(1, function (x) rle(as.numeric(x == "-"))$lengths[2])

  out_data <- dplyr::mutate(out_data,
                            rkfirst_ok, nb_ok_conseq,
                            rkfirst_out, nb_out_conseq)

  dplyr::arrange(out_data,
                 rkfirst_ok, desc(nb_ok_conseq),
                 desc(rkfirst_out), desc(nb_out_conseq)) %>%
    dplyr::select(- rkfirst_ok, - nb_ok_conseq,
                  - rkfirst_out, - nb_out_conseq)

}
