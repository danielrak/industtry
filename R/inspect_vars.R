

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

#' Variable detection patterns
#'
#' @param data_frames The datasets to explore. Need to exist in the Global Environment
#' @return Variable list and indicators of presences/absences across all inputted datasets.
#' @examples
#' vars_detect(c("cars", "mtcars"))

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
    apply(1, \(x) min(which(x == "ok")))

  nb_ok_conseq <- out_data %>%
    apply(1, \(x) rle(as.numeric(x == "ok"))$lengths[2])

  rkfirst_out <- out_data[, - 1] %>%
    apply(1, \(x) min(which(x == "-")))

  nb_out_conseq <- out_data %>%
    apply(1, \(x) rle(as.numeric(x == "-"))$lengths[2])

  out_data <- dplyr::mutate(out_data,
                            rkfirst_ok, nb_ok_conseq,
                            rkfirst_out, nb_out_conseq)

  dplyr::arrange(out_data,
                 rkfirst_ok, desc(nb_ok_conseq),
                 desc(rkfirst_out), desc(nb_out_conseq)) %>%
    dplyr::select(- rkfirst_ok, - nb_ok_conseq,
                  - rkfirst_out, - nb_out_conseq)

}

# Complement: extract presence/absence inconsistency:

#' Variable detection - inconsistent patterns
#'
#' @param vars_detect_table Output of the vars_detect() function in this package.
#' This object must exists into the Global Environment.
#' @return From vars_detect_table, extract variables that are not always present through all the datasets.
#' @examples
#' vdetect_table <- vars_detect(c("cars", "mtcars"))
#' vars_detect_not_everywhere(vdetect_table)

vars_detect_not_everywhere <- function (vars_detect_table) {

  vars_detect_table %>% (\(d) {

    not_everywhere <-
      apply(d, 1, \(x) !
              identical(unique(x[-1]), "ok")) %>% unlist
    d[not_everywhere, ]

  })

}

# Complement: extract variables that are presents across all datasets:

#' Variable detection - presence across all the datasets
#'
#' @param vars_detect_table Output of the vars_detect() function in this package.
#' This object must exists into the Global Environment.
#' @return From vars_detect_table, extract variables that are always present through all the datasets.
#' @examples
#' vdetect_table <- vars_detect(c("cars", "mtcars"))
#' vars_detect_everywhere(vdetect_table)

vars_detect_everywhere <- function (vars_detect_table) {

  vars_detect_table %>% (function (d) {

    everywhere <-
      apply(d, 1,
            \(x) identical(unique(x[-1]), "ok")) %>% unlist
    d[everywhere, ]

  })

}

# Variable class comparison -----------------------------------------------

#' Collection-level variables types comparison
#'
#'@param data_frames The datasets to explore. Need to exist in the Global Environment
#'@return Variable list and their respective types across all inputted datasets.
#'@examples vars_compclasses(c("cars", "mtcars"))

vars_compclasses <- function (data_frames) {

  vars_union <- purrr::map(data_frames, get) %>%
    purrr::map(names) %>% unlist %>% unique
  data_frames %>% (\(ll) purrr::map(ll, \(x) {
    g <- get(x)
    purrr::map(vars_union,
               \(y)
               ifelse(ncol(g) > 0, class(g[[y]]) %>%
                        # avoid problems with 2L class variables:
                        paste(collapse = "/"), NULL) %>%
                 stringr::str_replace("ˆNULL$", "-")) %>%
      do.call(what = rbind)}) %>%
      do.call(what = cbind) %>%
      magrittr::set_rownames(vars_union) %>%
      magrittr::set_colnames(ll)) %>%
    as.data.frame %>%
    tibble::rownames_to_column() %>%
    (\(d) {
      names(d)[1] <- "vars_union"
      d
    })
}


#' Variable class comparison - not all of same type across all datasets
#'
#' @param vars_compclasses_table Output of the vars_compclasses() function in this package.
#' @return From vars_compclasses_table, extract type-inconsistent variables through all the datasets.
#' @examples
#' vcompclasses_table <- vars_compclasses(c("cars", "mtcars"))
#' vars_compclasses_not_allsame(vcompclasses_table)
#'
vars_compclasses_not_allsame <- function (vars_compclasses_table) {
  vars_compclasses_table %>% (function (d) {
    not_allsame <- apply(d, 1, function (x)
      length(unique(x[-1] %>%
                    (function (xx)
                      xx[xx != "-"]))) != 1) %>% unlist
    d[not_allsame,]
  })
}


#' Variable class comparison - all of same type across all datasets
#'
#' @param vars_compclasses_table Output of the vars_compclasses() function in this package.
#' @return From vars_compclasses_table, extract type-consistent variables through all the datasets.
#' @examples
#' vcompclasses_table <- vars_compclasses(c("cars", "mtcars"))
#' vars_compclasses_allsame(vcompclasses_table)
#'
vars_compclasses_allsame <- function (vars_compclasses_table) {
  vars_compclasses_table %>% (\(d) {
    allsame <- apply(d, 1, function (x)
      length(unique(x[-1] %>%
                      (\(xx)
                        xx[xx != "-"]))) == 1) %>% unlist
    d[allsame,]
  })
}
