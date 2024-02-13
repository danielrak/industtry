# utils - Unclassified (yet) tools that may be useful


# Collapse NAs----------------------------------------------------------------

# To be added.

# Left join + checks ------------------------------------------------------

#' Perform a classical dplyr::left_join() and add check information related to join
#'
#' @param ltable Left data frame in the join
#' @param rtable Right data frame in the join
#' @return Output of dplyr::left_join() with messages on number of observations
#' in left, right and joined data frames and list of common variables between
#' ltable and rtable
#'
ljoin_checks <- function (ltable, rtable, ...) {

  requireNamespace("magrittr")

  result <- dplyr::left_join(x = ltable, y = rtable, ...)

  lrows <- nrow(ltable)
  rrows <- nrow(rtable)
  jrows <- nrow(result)

  lvars <- names(ltable)
  rvars <- names(rtable)
  ivars <- intersect(lvars, rvars)

  message("Checks : \n",
          paste0("ltable rows : ", lrows),
          "\n",
          paste0("rtable rows :", rrows),
          "\n",
          paste0("jtable rows : ", jrows),
          "\n",
          paste0(ivars, collapse = ", ") %>%
            paste0(" are common var names accross the two tables"))

  return(result)
}
