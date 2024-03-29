% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/view_in_excel.R
\name{view_in_excel}
\alias{view_in_excel}
\title{View in Excel}
\usage{
view_in_excel(.data)
}
\arguments{
\item{.data}{a data frame}
}
\value{
the `.data`, unchanged and invisibly
}
\description{
This function open in Excel a data frame, returning it invisibly to
be "pipe-able". The operation is done only in interactive session, so
that it has no effect on pipe-chains of code executed in batch.
}
\details{
This function is useful for intermediate inspection of
data, possibly in the middle of piped transformations.

This version: avoid unwanted execution (interactive session only),
embed the correct extension in the temporary file, add BOM for Excel
pleasure, and return the output invisibly, in case it is the last
element of the chain.
}
\note{
this function was originated during the conversation on Twitter
  started at
  https://twitter.com/brodriguesco/status/1447468259725434886?s=20
}
\examples{
\dontrun{
  four_cyl_cars <- mtcars \%>\%
    view_in_excel() \%>\%
    dplyr::filter(cyl == 4) \%>\%
    view_in_excel()

  four_cyl_cars
}
}
