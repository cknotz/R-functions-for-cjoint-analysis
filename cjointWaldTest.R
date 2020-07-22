cjointWaldTest <- function(data,outcome,attributes,task){
  if (!require("aod")) install.packages("aod")

# Constructs model equation
equation <- as.formula(
  paste(outcome,
       paste(paste(attributes,task, sep = "*"),collapse = " + "),
        sep = " ~ "))

# Runs regression model and saves VarCov matrix
mod <- lm(formula = equation, data=data)
  mat <- vcov(mod)

# Identifies interaction terms
terms <- grep(pattern = ":",colnames(mat), value = F)

# Runs Wald-test on model results
aod::wald.test(b=coef(mod),Sigma = vcov(mod),Terms = terms)
}
