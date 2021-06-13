cjointCarryTest <- function(data, outcome, attributes, task, resID) {
    if(!require(clubSandwich)){
        install.packages("clubSandwich")}
    cat("\n")
    message("Running tests, this might take a while...")
    waldres <- invisible(sapply(attributes,function(x){

        # Constructs model equation
        equation <- as.formula(paste(outcome,
                                     paste(
                                         paste(x, task, sep = "*"), collapse = " + "
                                     ),
                                     sep = " ~ "))

        # Runs model
        mod <- lm(formula = equation, data = noquote(data))

        # Identifies interaction terms
        terms <- grep(pattern = ":", colnames(vcov(mod)), value = F)

        #Adjusts VCOV
        mod_V <- vcovCR(mod,
                        cluster = data[[resID]],
                        type = "CR2")

        #Runs Wald-test on model results
        Wald_test(mod,
                  vcov = mod_V,
                  constraints = constrain_zero(terms))
    }))
    return(waldres)
}
