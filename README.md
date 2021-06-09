# R-functions-for-cjoint-analysis

This repository provides functions for R that run diagnostic checks on data from rating-based conjoint survey experiments.

For more information on conjoint experiments, see Hainmueller, Hopkins, and Yamamoto. 2014. 'Causal Inference in Conjoint Analysis: Understanding Multidimensional Choices via Stated Preference Experiments' *Political Analysis* 22:1-30.

All this is currently work in progress.

## cjointCarryTest()

This function checks the data for carryover effects (which can arise when respondents base their evaluation of one vignette on their evaluation of previous ones).

The function runs a linear regression including all vignette attributes interacted with an ID for the task number as predictors, and then estimates a Wald-test to test for the joint significance of the interaction terms. A rejected null indicates carryover effects are present.

It takes as arguments:
* `data`: A data.frame
* `attributes`: A character vector of vignette attributes' names in the dataset
* `task`: The task-ID. This should be a factor in the data, but is entered here as a string
* `outcome`: The outcome variable, entered as a string

### Example:
`cjointCarryTest(data=experimentdata, attributes=c("gender","age","income","education"),outcome="rating",task="taskID")`

## cjointRandoTest()

This function checks data from conjoint experiments for randomization problems. Specifically, it performs chi-squared tests on contingency tables of combinations of respondent-variables and vignette attributes. If randomization was successful, there should be no association between respondent characteristics and vignette attributes. A rejected null, on the other hand, indicates that some groups of respondents were more likely to be presented with some vignette attributes, which can result from problems with the randomization of attributes across profiles.

The function takes as arguments:
* `data`: A data.frame
* `resvars`: A character vector of respondent characteristics (the names of the corresponding variables in the dataset)
* `dims`: A character vector of profile attributes' names in the dataset

### Example:
`cjointRandoTest(data=experimentdata,resvars=c("age_respondent","gender_respondent"),dims=c("age","gender","income"))`

## cjointChiTest()

This function checks if any of the vignette dimensions are associated with each other. Such associations can occur by mere chance, even if the composition of vignettes is randomized. The function cross-tabulates all combinations of vignette attributes and computes chi-squared tests to test if there are any significant associations between attributes. It then saves the resulting p-values and arranges them into a matrix (similar to to a correlation matrix for metric variables). A rejected null (small p-value) indicates that there is some statistically significant association between vignette attributes. The matrix can optionally be labeled.

The function takes as arguments:
* `data`: A data.frame
* `dims`: A character vector of vignette attributes' names in the dataset
* `labels`: Optional. A character vector of labels for the vignette attributes (the order must correspond to the one in `dims`!)

## cjointCramTest()

This function complements the `cjointChiTest()` function. Whereas the `cjointChiTest()` function assesses the _statistical significance_ of any inter-attribute associations, the `cjointCramTest()` function assesses how strong this association is. The function cross-tabulates all combinations of vignette attributes and computes Cramer's V statistics. These are a measure of strongly two categorical variables are associated, where 0 indicates no association and 1 perfect association (similar to Pearson's correlation coefficient). The function computes these tests and arranges the test statistics into a matrix. The matrix can optionally be labeled.

The function takes as arguments:
* `data`: A data.frame
* `dims`: A character vector of vignette attributes' names in the dataset
* `labels`: Optional. A character vector of labels for the vignette attributes (the order must correspond to the one in `dims`!)
