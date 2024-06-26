% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dupl_sources.R
\name{dupl_sources}
\alias{dupl_sources}
\title{Illustrate sources of all duplicated values of a variable or a combination of variables}
\usage{
dupl_sources(data_frame, vars, output_as_df = FALSE)
}
\arguments{
\item{data_frame}{Data.frame. Input data frame. Must be in the Global Environment and has a data.frame class}

\item{vars}{Character. Vector of variable or combination of variables
from which duplicates are checked}

\item{output_as_df}{Logical 1L. If TRUE, output is rendered as a data.frame.}
}
\value{
List or data.frame. For each duplicated row regarding to vars, different values of the same variable
are shown, separated by AND
}
\description{
Illustrate sources of all duplicated values of a variable or a combination of variables
}
\examples{
# A fictional data with duplicated values:
df <- data.frame("person_id" = c(1, 1, 2, 3,
                                 2, 4, 5, 5 ,1),
                 "person_age" = c(25, 25, 21, 32,
                                  21, 48, 50, 50, 52),
                 "survey_month" = c("jan", "feb", "mar", "apr",
                                    "apr", "may", "jun", "jul", "jan"),
                 "survey_answer" = c("no", "yes", "no", "yes",
                                     "yes", "yes", "no", "yes", NA))

# Shuffling observations and columns to make duplicates difficult to see:
set.seed(1)
df <- df[sample(1:nrow(df)),
         sample(1:ncol(df))]
df

dupl_sources(data_frame = df, vars = "person_id")
dupl_sources(data_frame = df, vars = "person_id", output_as_df = TRUE)
}
