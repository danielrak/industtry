% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ljoin_checks.R
\name{ljoin_checks}
\alias{ljoin_checks}
\title{Perform a classical dplyr::left_join() and add check information related to join}
\usage{
ljoin_checks(ltable, rtable, ...)
}
\arguments{
\item{ltable}{Data.frame. Left data frame in the join}

\item{rtable}{Data.frame. Right data frame in the join}

\item{...}{Params. Any other arguments of dplyr::left_join()}
}
\value{
Data.frame. Output of dplyr::left_join() with messages on number of observations
in left, right and joined data frames and list of common variables between
ltable and rtable
}
\description{
Perform a classical dplyr::left_join() and add check information related to join
}
\examples{
left_table <- data.frame("person_id" = c(1, 1, 2, 3,
                                 2, 4, 5, 5 ,1),
                 "person_age" = c(25, 25, 21, 32,
                                  21, 48, 50, 50, 52),
                 "survey_month" = c("jan", "feb", "mar", "apr",
                                    "apr", "may", "jun", "jul", "jan"),
                 "survey_answer" = c("no", "yes", "no", "yes",
                                     "yes", "yes", "no", "yes", NA))

right_table <- data.frame("person_id" = c(2, 5, 4, 3, 1), 
                          "person_name" = c("John", "Marie", "Pierre", "Marc", "Jimmy"))

list("left_table" = left_table, 
     "right_table" = right_table)

ljoin_checks(left_table, right_table, by = "person_id")
}
