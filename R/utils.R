# utils - Unclassified (yet) tools that may be useful


# Collapse NAs----------------------------------------------------------------

# To be added.

# Left join + checks ------------------------------------------------------

#' Perform a classical dplyr::left_join() and add check information related to join
#'
#' @param ltable Left data frame in the join
#' @param rtable Right data frame in the join
#' @param ... Any other arguments of dplyr::left_join()
#' @return Output of dplyr::left_join() with messages on number of observations
#' in left, right and joined data frames and list of common variables between
#' ltable and rtable
#' @importFrom magrittr  %>%
#' @export
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

# Frequencies and proportions ----------------------------------------------


#' Frequencies and proportions in one output
#'
#' Combines base::table() and base::prop.table() outputs in a single one
#'
#' @param ... Arguments passed to base::table()
#' @param margin The same argument as in base::prop.table()
#' @aliases base::table() base::prop.table()
#' @param round Number of digits after decimal in base::prop.table() output
#' @param noquote Logical. If TRUE, return an object of class noquote that provides better view of the output
#' @return Frequencies with proportions in brackets
#' @export
#'
table_prop <- function (..., margin = NULL, round = 3, noquote = FALSE) {

  table <- table(...)
  ptable <- round(prop.table(table, margin), round)

  result <- matrix(paste0(table, " (", ptable, ")"), nrow = nrow(table))
  dimnames(result) <- dimnames(table)

  if (noquote) noquote(result) else result
}
