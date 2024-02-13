# chars_manipulations

# Remove accents and special chars ----------------------------------------

unaccent <- function(text) {

  text <- gsub("['`^~\"]", " ", text)
  text <- iconv(text, to="ASCII//TRANSLIT//IGNORE")
  text <- gsub("['`^~\"]", "", text)
  return(text)
}


# Characters structure ----------------------------------------------------

# Experimental version. To be developed substantially.
chars_structure <- function (input_vector) {

  require(magrittr)

  input_vector %>% unique %>%
    strsplit("") %>%
    purrr::map(\(x) stringr::str_replace(x, "^[:alpha:]$", "A") %>%
                  stringr::str_replace("^[:digit:]$", "D")) %>%
    purrr::map(rle) %>%
    purrr::map(\(x) paste0(x$lengths, x$values) %>%
                  paste(collapse = ", ")) %>%
    unlist()
}
