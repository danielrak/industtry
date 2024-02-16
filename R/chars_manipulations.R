# chars_manipulations

# Remove accents and special chars ----------------------------------------

# To be added.

# Characters structure ----------------------------------------------------

# Experimental version. To be developed substantially.

#' Get [:alpha:] / [:digit:] patterns from each symbol of character vector
#' @param input_vector Character vector to process
#' @return Character vector describing structure of each elements of input_vector,
#' see example
#' @examples
#' library(magrittr)
#' chars_structure(c("ABC123", "DE4F56", "789GHI"))
#' @importFrom magrittr %>%
#' @export
#'
chars_structure <- function (input_vector) {

  requireNamespace("magrittr")

  input_vector %>% unique %>%
    strsplit("") %>%
    purrr::map(\(x) stringr::str_replace(x, "^[:alpha:]$", "A") %>%
                  stringr::str_replace("^[:digit:]$", "D") %>%
                  stringr::str_replace(" ", "[space]")) %>%
    purrr::map(rle) %>%
    purrr::map(\(x) paste0(x$lengths, x$values) %>%
                  paste(collapse = ", ")) %>%
    unlist()
}
