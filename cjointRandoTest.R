cjointRandoTest <- function(data,resvars,dims) {

invisible(sapply(resvars,function(x){
  invisible(sapply(dims, function(y){
    test <- chisq.test(table(data[[x]],data[[y]]))
        cat(paste0("\nRespondent variable = ",x,"; Profile variable = ",y,";\n Chi-sq.:",round(test$statistic, digits = 3),"; df = ",test$parameter, "; p-value = ",round(test$p.value,3)))
  }))
}))
}
