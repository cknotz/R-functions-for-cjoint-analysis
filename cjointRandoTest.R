cjointRandoTest <- function(data, resvars, dims,reslabs=NULL,dimlabs=NULL) {
    rand <- invisible(sapply(resvars, function(x) {
        invisible(sapply(dims, function(y) {
            as.matrix(round(chisq.test(table(data[[x]], data[[y]]))$p.value,3))
        }))
    }))
    if(!is.null(reslabs) & !is.null(dimlabs)){
        dimnames(rand) <- list(dimlabs,reslabs)}
    cat("\n P-values from chi-squared tests on bivariate cross-tabulations of \n respondent-variables and profile attributes.")
    print(rand)
}
