#' get selected Resistance Allele Frequencies from array
#' 
#' @param RAF array of resistance allele frequencies
#' @param insecticide which insecticide, by number, default to all (TRUE), vector e.g. c(1,2)
#' @param sex 'm' or 'f', default to all (TRUE)
#' @param site 'intervention' or 'refugia', default to all (TRUE)
#' @param gen which generation, single or vector e.g. c(1:10), default to all (TRUE)
#' @param asdf to return as dataframe instead of array default FALSE
#' 
#' @examples
#' #frequencies different for each insecticide
#' RAF <- set_start_freqs(max_generations = 2, freqs=c(0.1,0.01,0.001))
#' 
#' raf_get(sex='f')
#' raf_get(site='intervention')
#' raf_get(gen=1, asdf=TRUE)
#' 
#' 
#' @return array or dataframe of resistance frequencies
#' @export
#' 
raf_get <- function( RAF,
                     insecticide = TRUE,
                     sex = TRUE,
                     site = TRUE,
                     gen = TRUE,
                     asdf = FALSE )
{
  
  
  toreturn <- RAF[insecticide, sex, site, gen]
  
  if (asdf) toreturn <- as.data.frame(toreturn)
  
  return(toreturn)  
}