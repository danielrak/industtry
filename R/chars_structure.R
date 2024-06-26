# WARNING - Generated by {fusen} from dev/flat_chars_structure.Rmd: do not edit by hand

# Characters structure

#' Get :alpha: / :digit: patterns from each symbol of character vector
#' @param input_vector Character. Vector to process
#' @param unique Logical 1L. If TRUE, the result is reduced to unique values.
#' @param named_output Logical 1L. If TRUE, output vector is named after corresponding input values. 
#' @return Character. Vector describing structure of each elements of input_vector,
#' see example. 
#' @examples
#' library(magrittr)
#' input <- c("ABC123", "DE4F56", "789GHI", "ABC123")
#'
#' # Default values of unique and named_output: 
#' chars_structure(input_vector = input, unique = TRUE, named_output = TRUE)
#'
#' # unique is set to default value TRUE and named_output is set to FALSE: 
#' chars_structure(input_vector = input, unique = TRUE, named_output = FALSE)
#'
#' # unique is set to FALSE and named_output to FALSE: 
#' chars_structure(input_vector = input, unique = FALSE, named_output = FALSE)
#'
#' # unique is set to FALSE and named_output to defalut value TRUE: 
#' chars_structure(input_vector = input, unique = FALSE, named_output = TRUE)
#' @importFrom magrittr %>%
#' @export
#'
chars_structure <- function (input_vector, 
                             unique = TRUE, named_output = TRUE) {

  requireNamespace("magrittr")

  if (isFALSE(is.character(input_vector))) {
    
    stop("input_vector must be a character vector")
  }
  
  iunique <- unique(input_vector)
  
  result <- iunique %>%
    strsplit("") %>%
    purrr::map(\(x) stringr::str_replace(x, "^[:alpha:]$", "A") %>%
                 stringr::str_replace("^[:digit:]$", "D") %>%
                 stringr::str_replace(" ", "[space]")) %>%
    purrr::map(rle) %>%
    purrr::map(\(x) paste0(x$lengths, x$values) %>%
                 paste(collapse = ", ")) %>%
    unlist()
  
  result_d <- data.frame(
    "input_unique" = iunique, 
    "chars_structure" = result)
  
  if (isTRUE(unique)) {
    if (isTRUE(named_output)) return(stats::setNames(result, iunique)) 
    else return(result)
  } else {
    ljoin_result <- data.frame(
      "input_vector" = input_vector) %>% 
      dplyr::left_join(result_d, by = c("input_vector" = "input_unique"))
    if (isTRUE(named_output)) return(stats::setNames(ljoin_result$chars_structure, 
                                              ljoin_result$input_vector))
    else return(ljoin_result$chars_structure)
  }
}
