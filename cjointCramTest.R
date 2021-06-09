cjointAssocMat <- function(data,dims,labels=NULL) {
    if(!require(rcompanion)) install.packages("rcompanion")
        
    cramtest <- invisible(sapply(dims,function(y){
        invisible(sapply(dims,function(x){
            as.matrix(rcompanion::cramerV(table(data[[x]],data[[y]]))) 
        }))
    }))
    if(!is.null(labels)){
        dimnames(cramtest) <- list(labels,labels)}
    cramtest[upper.tri(cramtest)] <- NA
    print(cramtest)
}
