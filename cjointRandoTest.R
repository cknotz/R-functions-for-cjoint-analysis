cjointRandoTest <- function(data,resvars,dims) {
  
# data: data.frame
  # resvars: character vector of respondent characteristics
  # dims: character vector of profile dimension
  
# Runs chi-squared test first over combinations of resp-vars and profile dimensions
invisible(sapply(resvars,function(x){
  invisible(sapply(dims, function(y){
    test <- chisq.test(data[[x]],data[[y]])
        print(paste0("Respondent variable = ",x,"; Profile variable = ",y,"; df = ",test$parameter, "; p-value = ",round(test$p.value,3)))
  }))
})) 
}