% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as_gt.R
\name{as_gt.fixed_design}
\alias{as_gt.fixed_design}
\title{This is the function to format the bounds summary table of fixed design into gt style.}
\usage{
\method{as_gt}{fixed_design}(x, title = NULL, footnote = NULL, ...)
}
\arguments{
\item{x}{a summary object of group sequential design}

\item{title}{title to be displayed}

\item{footnote}{footnotes to be displayed}

\item{...}{additional arguments}
}
\value{
a gt table
}
\description{
This is the function to format the bounds summary table of fixed design into gt style.
}
\examples{
library(dplyr)
library(tibble)

# Enrollment rate
enrollRates <- tibble(
  Stratum = "All", 
  duration = 18, 
  rate = 20)

# Failure rates
failRates <- tibble(
  Stratum = "All", 
  duration = c(4, 100), 
  failRate = log(2) / 12,
  hr = c(1, .6), 
  dropoutRate = .001)

# Study duration in months
studyDuration <- 36

# Experimental / Control randomization ratio
ratio <- 1 

# 1-sided Type I error
alpha <- 0.025 

# Type II error (1 - power)
beta <- 0.1 

# ------------------------- #
#        AHR                #
# ------------------------- #
# under fixed power 
fixed_design(
  x = "AHR", 
  alpha = alpha, power = 1 - beta, 
  enrollRates = enrollRates, failRates = failRates, 
  studyDuration = studyDuration, ratio = ratio
  ) \%>\% 
  summary() \%>\% 
  as_gt()
  
# ------------------------- #
#        FH                 #
# ------------------------- #
# under fixed power
fixed_design(
  x = "FH", 
  alpha = alpha, power = 1 - beta, 
  enrollRates = enrollRates, failRates = failRates, 
  studyDuration = studyDuration, ratio = ratio
  ) \%>\% 
  summary() \%>\% 
  as_gt()
  
}
