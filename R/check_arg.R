#' A function to check the arguments \code{enrollRates} used in gsDesign2
#'
#' @param enrollRates 
#'
#' @return TURE or FALSE
#'
#' @examples
#' 
#' enrollRates <- tibble::tibble(Stratum = "All", duration = c(2, 2, 10), rate = c(3, 6, 9))
#' check_enrollRates(enrollRates)
#' 
check_enrollRates <- function(enrollRates){
  
  # --------------------------- #
  #   check the Stratum column  #
  # --------------------------- #
  # if("Stratum" %in% colnames(enrollRates)){
  #   stop("The enrollRates is a tibble which contains a column called `Stratum`!")
  # }
  
  # --------------------------- #
  #   check the duration column #
  # --------------------------- #
  if(!"duration" %in% colnames(enrollRates)){
    stop("The enrollRates is a tibble which contains a column called `duration`!")
  }
  # the duration is numerical values
  if(!is.numeric(enrollRates$duration)){
    stop("The `duration`column in enrollRates should be numeric!")
  }
  
  # the duration is positive numbers
  if(sum(!enrollRates$duration > 0) != 0){
    stop("The `duration` column in enrollRates should be positive numbers!")
  }
  
  # --------------------------- #
  #   check the rate column     #
  # --------------------------- #
  if(!"rate" %in% colnames(enrollRates)){
    stop("The enrollRates is a tibble which contains a column called `rate`!")
  }
  
  # the rate is numerical values
  if(!is.numeric(enrollRates$rate)){
    stop("The `rate`column in enrollRates should be numeric!")
  }
  
  # the rate is positive numbers
  if(sum(!enrollRates$rate >= 0) != 0){
    stop("The `rate` column in enrollRates should be positive numbers!")
  }
}



#' A function to check the arguments \code{failRates} used in gsDesign2
#'
#' @param enrollRates 
#'
#' @return TURE or FALSE
#'
#' @examples
#' 
#' failRates <- tibble::tibble(Stratum = "All", duration = c(3, 100), 
#'                             failRate = log(2) / c(9, 18), hr = c(.9, .6), 
#'                             dropoutRate = rep(.001, 2))
#' check_failRates(failRates)
#' 
check_failRates <- function(failRates){
  
  # --------------------------- #
  #   check the Stratum column  #
  # --------------------------- #
  # if(!"Stratum" %in% colnames(enrollRates)){
  #   stop("The enrollRates is a tibble which contains a column called `Stratum`!")
  # }
  
  # --------------------------- #
  #   check the duration column #
  # --------------------------- #
  if(!"duration" %in% colnames(failRates)){
    stop("The failRates is a tibble which contains a column called `duration`!")
  }
  # the duration is numerical values
  if(!is.numeric(failRates$duration)){
    stop("The `duration`column in failRates should be numeric!")
  }
  
  # the duration is positive numbers
  if(sum(!failRates$duration > 0) != 0){
    stop("The `duration` column in failRates should be positive numbers!")
  }
  
  # --------------------------- #
  #   check the failRate column #
  # --------------------------- #
  if(!"failRate" %in% colnames(failRates)){
    stop("The failRates is a tibble which contains a column called `failRate`!")
  }
  
  # the rate is failRates values
  if(!is.numeric(failRates$failRate)){
    stop("The `failRate`column in failRates should be numeric!")
  }
  
  # the rate is positive numbers
  if(sum(!failRates$failRate > 0) != 0){
    stop("The `failRate` column in failRates should be positive numbers!")
  }
  
  # --------------------------- #
  #   check the hr column       #
  # --------------------------- #
  if("hr" %in% colnames(failRates)){
    if(is.numeric(failRates$hr)){
      stop("The `hr`column in failRates should be numeric!")
    }
    
    if(sum(!failRates$hr > 0) != 0){
      stop("The `hr` column in failRates should be positive numbers!")
    }
  }
  
  # --------------------------- #
  # check the dropoutRate column#
  # --------------------------- #
  if(!"dropoutRate" %in% colnames(failRates)){
    stop("The failRates is a tibble which contains a column called `dropoutRate`!")
  }
  
  # the rate is numerical values
  if(!is.numeric(failRates$dropoutRate)){
    stop("The `dropoutRate`column in failRates should be numeric!")
  }
  
  # the rate is positive numbers
  if(sum(!failRates$dropoutRate >= 0) != 0){
    stop("The `dropoutRate` column in failRates should be positive numbers!")
  }
}



#' A function to check the arguments \code{enrollRates} and \code{failRates} used in gsDesign2
#'
#' @param enrollRates 
#'
#' @return TURE or FALSE
#'
#' @examples
#' 
#' enrollRates <- tibble::tibble(Stratum = "All", duration = c(2, 2, 10), rate = c(3, 6, 9))
#' failRates <- tibble::tibble(Stratum = "All", duration = c(3, 100), 
#'                             failRate = log(2) / c(9, 18), hr = c(.9, .6), 
#'                             dropoutRate = rep(.001, 2))
#' check_enrollRates(enrollRates, failRates)
#' 
check_enrollRates_failRates <- function(enrollRates, failRates){
  
  if("Stratum" %in% colnames(enrollRates) && "Stratum" %in% colnames(failRates)){
    strata_enroll <- unique(enrollRates$Stratum)
    strata_fail   <- unique(failRates$Stratum)
    strata_common <- dplyr::intersect(strata_enroll, strata_fail)
    
    if(strata_common != strata_enroll){
      stop("The `Strata` column in the input argument `enrollRates` and `failRates` must be the same!")
    }
  }
}


#' A function to check the arguments \code{analysisTimes} used in gsDesign2
#'
#' @param analysisTimes  
#'
#' @return TURE or FALSE
#'
#' @examples
#' analysisTimes <- 20
#' check_analysisTimes(analysisTimes)
#' 
#' analysisTimes <- c(20, 30)
#' check_analysisTimes(analysisTimes)
check_analysisTimes <- function(analysisTimes){
  cond1 <- !is.numeric(analysisTimes)
  cond2 <- !is.vector(analysisTimes)
  cond3 <- min(analysisTimes - dplyr::lag(analysisTimes, def=0))<=0
  if ( cond1 || cond2 || cond3 ){
    stop("The input argument `analysisTimes` must be NULL a numeric vector with positive increasing values!")
  }
}


#' A function to check the arguments \code{events} used in gsDesign2
#'
#' @param analysisTimes  
#'
#' @return TURE or FALSE
#'
#' @examples
#' events <- 20
#' check_events(events)
#' 
#' events <- c(20, 30)
#' check_events(events)
check_events <- function(events){
  cond1 <- !is.numeric(events)
  cond2 <- !is.vector(events)
  cond3 <- min(events - dplyr::lag(events, default=0))<=0
  if ( cond1 || cond2 || cond3 ){
    stop("The input argument `events` must be NULL or a numeric vector with positive increasing values!")
  }
}

#' A function to check the arguments \code{totalDuration} used in gsDesign2
#'
#' @param totalDuration  
#'
#' @return TURE or FALSE
#'
#' @examples
#' totalDuration <- 36
#' check_totalDuration(totalDuration)
#' 
#' totalDuration <- c(36, 48)
#' check_totalDuration(totalDuration)
check_totalDuration <- function(totalDuration){
  if(!is.numeric(totalDuration)){
    stop("The input argument `totalDuration` must be a non-empty vector of positive numbers!")
  }
  
  if(sum(!totalDuration > 0) != 0){
    stop("The input argument `totalDuration` must be a non-empty vector of positive numbers!")
  }
}

#' A function to check the arguments \code{ratio} used in gsDesign2
#'
#' @param ratio  
#'
#' @return TURE or FALSE
#'
#' @examples
#' ratio <- 1
#' check_ratio(ratio)
#' 
check_ratio <- function(ratio){
  if(!is.numeric(ratio)){
    stop("The input argument `ratio` must be a numerical number!")
  }
  
  if(ratio <= 0){
    stop("The input argument `ratio` must be a positive number!")
  }
}
