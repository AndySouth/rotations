% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/raf_get.r
\name{raf_get}
\alias{raf_get}
\title{get selected Resistance Allele Frequencies from array}
\usage{
raf_get(
  RAF,
  insecticide = TRUE,
  sex = TRUE,
  site = TRUE,
  gen = TRUE,
  asdf = FALSE
)
}
\arguments{
\item{RAF}{array of resistance allele frequencies, either [insecticide, sex, site, gen] or without generationd dimension}

\item{insecticide}{which insecticide, by number, default to all (TRUE), vector e.g. c(1,2)}

\item{sex}{'m' or 'f', default to all (TRUE)}

\item{site}{'intervention' or 'refugia', default to all (TRUE)}

\item{gen}{which generation, single or vector e.g. c(1:10), default to all (TRUE)}

\item{asdf}{to return as dataframe instead of array default FALSE}
}
\value{
array or dataframe of resistance frequencies
}
\description{
get selected Resistance Allele Frequencies from array
}
\examples{
#frequencies different for each insecticide
RAF <- set_start_freqs(max_gen = 2, freqs=c(0.1,0.01,0.001))

raf_get(RAF, sex='f')
raf_get(RAF, site='intervention')
raf_get(RAF, gen=1, asdf=TRUE)


}
