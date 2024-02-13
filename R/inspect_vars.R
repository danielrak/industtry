
# Inspect function --------------------------------------------------------

#' Inspect a data frame
#'
#' @param data_frame The data.frame to explore. Need to exist in the Global Environment.
#' @param nrow Logical. If TRUE, the number of observations of the dataset is rendered in addition.
#' @return Variable list of the dataset and systematic informations for each variable.
#' @examples
#' inspect(CO2)

inspect <- function(data_frame, nrow = FALSE) {

  requireNamespace("magrittr")

  # Observations:
  rows <- nrow(data_frame)
  df <- data_frame %>%

    # Date-time class correction to make it compatible with class(.x):
    dplyr::mutate_if(lubridate::is.POSIXct, \(x)
                     as.character(x) %>% structure(class = "Date-time")) %>%

    # Compute inspection infos:
    purrr::map_df(~ {
      dplyr::tibble(
        class = class(.x),
        nb_distinct = dplyr::n_distinct(.x),
        prop_distinct = nb_distinct / rows,
        nb_na = sum(is.na(.x)),
        prop_na = nb_na / rows,
        nb_void = sum(.x == "", na.rm = TRUE),
        prop_void = nb_void / rows,
        nchars = paste(unique(sort(nchar(as.character(.x))))[
          1:min(dplyr::n_distinct(nchar(as.character(.x))), 10)],
          collapse = " / "),
        modalities = paste(sort(unique(.x))[
          1:min(dplyr::n_distinct(.x), 10)],
          collapse = " / ")
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

  requireNamespace("magrittr")

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

  # Arrange lines to better visualize presence/absence patterns.
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

  requireNamespace("magrittr")

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

  requireNamespace("magrittr")

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

  requireNamespace("magrittr")

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

  requireNamespace("magrittr")

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

  requireNamespace("magrittr")

  vars_compclasses_table %>% (\(d) {
    allsame <- apply(d, 1, function (x)
      length(unique(x[-1] %>%
                      (\(xx)
                        xx[xx != "-"]))) == 1) %>% unlist
    d[allsame,]
  })
}

# inspect_vars() - The main function ---------------------------------

#' Inspect a collection of datasets
#'
#' @param input_path Folder path of datasets to explore
#' @param output_path Folder path where the exploration output will be stored
#' @param output_label 1-length character vector describing concisely the collection to explore
#' @param considered_extensions Character vector of extensions of datasets retained for exploration
#' in the input folder. Do not type the "." (dot) in it. E.g ("parquet" but not ".parquet")
#' @return An excel file written on the computer containing exploration information
#' @examples
#' saveRDS(cars, "./cars1.rds")
#' saveRDS(mtcars, "./cars2.rds")
#'
#' # Code below illustrates how to use the function:
#' inspect_vars(input_path = ".", output_path = ".",
#'              output_label = "cardata", considered_extensions = "rds")
#'
#' purrr::map(1:10, \(x)
#'            rio::import("./inspect_vars_cardata.xlsx",
#'                        sheet = x)) %>%
#' setNames(c("dims", "inspect_tot", "inspect_cars1", "inspect_cars2",
#'            "vars_detect", "vars_detect_everywhere", "vars_detect_not_everywhere",
#'            "vars_compclasses", "vars_compclasses_allsame", "vars_compclasses_not_allsame"))
#'            # code above illustrates all 10 sheets of the output
#'
#' file.remove(c("./cars1.rds", "./cars2.rds", "./inspect_vars_cardata.xlsx"))
#'
inspect_vars <- function (input_path, output_path,
                          output_label, considered_extensions) {

  requireNamespace("magrittr")

  # Import datasets:
  # file extensions
  ext <- paste0("\\.", considered_extensions, "$") %>%
    paste0(collapse = "|")
  # files found in input folder
  lfiles <- list.files(input_path) %>%
    purrr::keep(stringr::str_detect(., ext))
  lfiles %>%
    # load each dataset
    purrr::map(\(x) {

      assign(x,
             rio::import(file.path(input_path, x),
                         encoding = "latin1"),
             pos = globalenv())
      invisible()
    })

  # Compute all datasets inspection as R objects:
  lfiles %>% purrr::map(\(x) {
    data <- get(x)
    inspect <- inspect(data)
    inspect <- inspect %>%
      (\(i) rbind(c("Obs = ", nrow(data),
                            rep("", ncol(i) - 1)),
                          c("Nvars = ", nrow(i),
                            rep("", ncol(i) - 1)),
                          cbind(1:nrow(i), i)))
    assign(paste0("inspect_", x), inspect, pos = globalenv())
    invisible()
  })

  # Datasets dimensions:
  dims <-
    paste0("inspect_", lfiles) %>%
    (\(l)
      purrr::map(l, get) %>%
       purrr::map(\(x) x[1:2, 2] %>% t %>%
                    as.numeric) %>% setNames(l) %>%
       do.call(what = rbind)) %>%
    magrittr::set_colnames(c("nobs", "nvar")) %>%
    as.data.frame() %>%
    tibble::rownames_to_column(var = "datasets") %>%
    dplyr::mutate(datasets = stringr::str_remove(datasets, "ˆinspect\\_") %>%
                    stringr::str_remove(paste0(".", considered_extensions) %>%
                                          paste(collapse = "|")))

  # Bind all inspection outputs:
  inspect_tot <-
    paste0("inspect_", lfiles) %>%
    (\(l)
      purrr::map(l, function (x) get(x)[- c(1:2), - 1] %>%
                   dplyr::mutate(datasets = x) %>% dplyr::relocate(datasets))) %>%
    do.call(what = rbind) %>%
    dplyr::mutate(datasets = stringr::str_remove(datasets, "ˆinspect\\_") %>%
                    stringr::str_remove(paste0(".", considered_extensions) %>%
                                          paste(collapse = "|"))) %>%
    dplyr::left_join(dims, by = "datasets") %>%
    dplyr::relocate(nvar, nobs, .after = datasets)


  # Compute outputs of variable detection and type comparison above:
  vars_detect_data <- vars_detect(lfiles)
  vars_detect_everywhere_data <-
    vars_detect_everywhere(vars_detect_data)
  vars_detect_not_everywhere_data <-
    vars_detect_not_everywhere(vars_detect_data)
  vars_compclasses_data <- vars_compclasses(lfiles)
  # Same order as vars_detect:
  # (source :
  # https://stackoverflow.com/questions/27362718/reordering-rows-in-a-dataframe-
  # according-to-the-order-of-rows-in-another-datafra)
  vars_compclasses_data <- vars_compclasses_data %>%
    (\(d) d[order(match(vars_compclasses_data$vars_union,
                                vars_detect_data$vars_union)), ])
  vars_compclasses_allsame_data <-
    vars_compclasses_allsame(vars_compclasses_data)
  vars_compclasses_not_allsame_data <-
    vars_compclasses_not_allsame(vars_compclasses_data)

  # Write all outputs in an Excel file:
  writexl::write_xlsx(
    list(
      list("dims" = dims),
      list("inspect_tot" = inspect_tot),
      paste0("inspect_", lfiles) %>%
        (\(l) purrr::map(l, get) %>%
           setNames(l %>%
                    stringr::str_remove("ˆinspect\\_") %>%
                      (\(s)
                        stringr::str_remove(s, paste0("\\.",
                                                      tools::file_ext(s)))))),
      list("vars_detect" = vars_detect_data),
      list("vars_detect_everywhere" = vars_detect_everywhere_data),
      list("vars_detect_not_everywhere" = vars_detect_not_everywhere_data),
      list("vars_compclasses" = vars_compclasses_data),
      list("vars_compclasses_allsame" = vars_compclasses_allsame_data),
      list("vars_compclasses_not_allsame" = vars_compclasses_not_allsame_data)
    ) %>% purrr::flatten(),
    file.path(output_path, paste0("inspect_vars_", output_label, ".xlsx"))
  )

  # Remove intermediate outputs in Global Environment to lighten the user:
  rm(list = ls(envir = globalenv()) %>%
       (\(ls)
         ls[ls %in%
              c(lfiles, paste0("inspect_", lfiles))]),
     envir = globalenv())
}

