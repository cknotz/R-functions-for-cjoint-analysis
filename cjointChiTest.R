cjointChiTest <- function(data,dims,labels=NULL) {
    chimat <- sapply(dims,function(x){
        sapply(dims,function(y){
            round(chisq.test(table(data[[x]],data[[y]]))$p.value,3)
        })
    })
    if(!is.null(labels)){
        dimnames(chimat) <- list(labels,labels)}
    chimat[upper.tri(chimat)] <- NA
    return(chimat)
}
