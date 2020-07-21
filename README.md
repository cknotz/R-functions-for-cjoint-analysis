# R-functions-for-cjoint-analysis

## cjointWaldTest

This function computes a Wald-test to test for carryover effects in data from conjoint survey experiments.

It runs a linear regression (with standard errors clustered by respondents) including all vignette attributes interacted with an ID for the task number and then uses a Wald-test to test for the joint significance of the interaction terms. A rejected null indicates carryover effects
(see Hainmueller, Hopkins, Yamamoto. 2014. 'Causal Inference in Conjoint Analysis: Understanding Multidimensional Choices via Stated Preference Experiments' *Political Analysis* 22:1-30 for details on conjoint analysis and carryover effects).

It takes as arguments:
* `data`: A data.frame
* `attributes`: A character vector of vignette attributes
* `idvar`: The respondent ID variable, a string
* `task`: The task-ID. This should be a factor in the data, but is entered here as a string
* `outcome`: The outcome variable, entered as a string

### Example:
`cjointWaldTest(data=experimentdata, attributes=c("gender","age","income","education"),outcome="rating",task="taskID",idvar="resID")`
