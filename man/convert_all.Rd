% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convert_all.R
\name{convert_all}
\alias{convert_all}
\title{Convert all datasets within a folder to a given file format}
\usage{
convert_all(
  input_folderpath,
  considered_extensions,
  to,
  output_folderpath = input_folderpath
)
}
\arguments{
\item{input_folderpath}{Character 1L. Folder path containing datasets to convert.
Datasets must be at the root of the folder}

\item{considered_extensions}{Character. File extensions to consider for conversion within the folder.
Must be supported by the rio:: package}

\item{to}{Character 1L. The destination output format.
Must be supported by the rio:: package}

\item{output_folderpath}{Character 1L. Folder path where converted file should be placed}
}
\value{
This function, for RStudio only, launches one background job for each file to convert
}
\description{
Convert all datasets within a folder to a given file format
}
\examples{
mydir <- system.file("permadir_examples_and_tests/convert_all", package = "industtry") 

list.files(mydir)

if (rstudioapi::isAvailable()) {
convert_all(input_folderpath = mydir, considered_extensions = c("rds", "csv"), 
            to = "parquet", output_folderpath = mydir)

list.files(mydir)

unlink(file.path(mydir, c("original_cars.parquet", "original_mtcars.parquet")))
}
}
