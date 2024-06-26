% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chars_structure.R
\name{chars_structure}
\alias{chars_structure}
\title{Get :alpha: / :digit: patterns from each symbol of character vector}
\usage{
chars_structure(input_vector, unique = TRUE, named_output = TRUE)
}
\arguments{
\item{input_vector}{Character. Vector to process}

\item{unique}{Logical 1L. If TRUE, the result is reduced to unique values.}

\item{named_output}{Logical 1L. If TRUE, output vector is named after corresponding input values.}
}
\value{
Character. Vector describing structure of each elements of input_vector,
see example.
}
\description{
Get :alpha: / :digit: patterns from each symbol of character vector
}
\examples{
library(magrittr)
input <- c("ABC123", "DE4F56", "789GHI", "ABC123")

# Default values of unique and named_output: 
chars_structure(input_vector = input, unique = TRUE, named_output = TRUE)

# unique is set to default value TRUE and named_output is set to FALSE: 
chars_structure(input_vector = input, unique = TRUE, named_output = FALSE)

# unique is set to FALSE and named_output to FALSE: 
chars_structure(input_vector = input, unique = FALSE, named_output = FALSE)

# unique is set to FALSE and named_output to defalut value TRUE: 
chars_structure(input_vector = input, unique = FALSE, named_output = TRUE)
}
