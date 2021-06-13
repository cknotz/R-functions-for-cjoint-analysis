cjointRandoTest_I <- function(data, resvars, dims,reslabs=NULL,dimlabs=NULL) {
    rand <- invisible(sapply(resvars, function(x) {
        invisible(sapply(dims, function(y) {
            as.matrix(round(chisq.test(table(data[[x]], data[[y]]))$p.value,3))
        }))
    }))
    if(!is.null(reslabs) & !is.null(dimlabs)){
        dimnames(rand) <- list(dimlabs,reslabs)}
    return(rand)
}
