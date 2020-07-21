# R-functions-for-cjoint-analysis

This repository provides two functions for R that run diagnostic checks on data from rating-based conjoint survey experiments. The functions complement the `cjoint`-package.

For more information on conjoint experiments and the `cjoint`-[package](https://rdrr.io/cran/cjoint/man/cjoint-package.html), see Hainmueller, Hopkins, and Yamamoto. 2014. 'Causal Inference in Conjoint Analysis: Understanding Multidimensional Choices via Stated Preference Experiments' *Political Analysis* 22:1-30.

## cjointWaldTest

This function checks the data for carryover effects (which can arise when respondents base their evaluation of one vignette on their evaluation of previous ones).

The function runs a linear regression (with standard errors clustered by respondents) including all vignette attributes interacted with an ID for the task number as predictors, and then estimates a Wald-test to test for the joint significance of the interaction terms. A rejected null indicates carryover effects are present.

It takes as arguments:
* `data`: A data.frame
* `attributes`: A character vector of vignette attributes
* `idvar`: The respondent ID variable, a string
* `task`: The task-ID. This should be a factor in the data, but is entered here as a string
* `outcome`: The outcome variable, entered as a string

### Example:
`cjointWaldTest(data=experimentdata, attributes=c("gender","age","income","education"),outcome="rating",task="taskID",idvar="resID")`

## cjointRandoTest

This function checks data from conjoint experiments for randomization problems. Specifically, it performs chi-squared tests on contingency tables of combinations of respondent-variables and vignette attributes. If randomization was successful, there should be no association between respondent characteristics and vignette attributes. A rejected null, on the other hand, indicates that some groups of respondents were more likely to be presented with some vignette attributes, which can result from problems with the randomization of attributes across profiles.

The function takes as arguments:
* `data`: A data.frame
* `resvars`: A character vector of respondent characteristics
* `dims`: A character vector of profile attributes/dimensions

### Example:
`cjointRandoTest(data=experimentdata,resvars("age_respondent","gender_respondent"),dims=c("age","gender","income"))`
