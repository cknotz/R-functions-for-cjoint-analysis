cjointWaldTest <- function(data,outcome,attributes,task,idvar){
  if (!require("aod")) install.packages("aod")
  if (!require("miceadds")) install.packages("miceadds")
  
# Constructs model equation
equation <- as.formula(
  paste(outcome,
       paste(paste(attributes,task, sep = "*"),collapse = " + "),
        sep = " ~ "))  
  
# Runs cluster-robust interactive model
mod <- miceadds::lm.cluster(formula = equation, data=data, cluster = idvar)
  
# Identifies interaction terms
terms <- grep(pattern = ":",colnames(mod$vcov), value = F)  
  
# Runs Wald-test on model results
aod::wald.test(b=coef(mod),Sigma = vcov(mod),Terms = terms)
}