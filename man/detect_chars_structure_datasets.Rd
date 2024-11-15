% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/detect_chars_structure_datasets.R
\name{detect_chars_structure_datasets}
\alias{detect_chars_structure_datasets}
\title{Detect character structure from datasets}
\usage{
detect_chars_structure_datasets(
  datasets_folderpath,
  considered_extensions,
  patterns,
  output_filepath = file.path(datasets_folderpath, paste0("detect_chars_structure_",
    basename(datasets_folderpath), ".rds")),
  get_output_in_session = TRUE
)
}
\arguments{
\item{datasets_folderpath}{Character 1L. Folder path of datasets to process. These datasets must be at the root of the path}

\item{considered_extensions}{Character. Datasets file extensions to consider. Extensions must be one supported by the rio:: package}

\item{patterns}{Character. Patterns to detect across the datasets variables. Regex is supported}

\item{output_filepath}{Character 1L. Output folder path.}

\item{get_output_in_session}{Logical 1L. If TRUE, the function return a list, such that each element element corresponds to pattern detection details for each considered dataset}
}
\description{
Detect character structure from datasets
}
\examples{
mydir <- system.file("detect_chars_structure_datasets", package = "industtry")

detect <- detect_chars_structure_datasets(
  datasets_folderpath = mydir, 
  considered_extensions = "xlsx", 
  patterns = "(?i)college", 
  output_filepath = file.path(mydir, "detect_college.rds"), 
  get_output_in_session = TRUE)

# head(lapply(detect, head))

file.exists(file.path(mydir, "detect_college.rds"))
}
