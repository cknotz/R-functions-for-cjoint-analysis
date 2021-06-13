# R-functions-for-cjoint-analysis

This repository provides functions for R that run diagnostic checks on data from rating-based conjoint survey experiments.

For more information on conjoint experiments, see Hainmueller, Hopkins, and Yamamoto. 2014. 'Causal Inference in Conjoint Analysis: Understanding Multidimensional Choices via Stated Preference Experiments' *Political Analysis* 22:1-30.

All this is currently work in progress.

## cjointCarryTest()

This function checks the data for carryover effects (which can arise when respondents base their evaluation of one vignette on their evaluation of previous ones).

The function runs linear regression models including one vignette attribute at a time interacted with an ID for the task number as predictors, applies cluster-robust standard errors, and then estimates a Wald-test to test for the joint significance of the interaction terms. A rejected null indicates carryover effects are present. For details, see Hainmueller et al. (2014, 22).

It takes as arguments:
* `data`: A data.frame
* `attributes`: A character vector of vignette attributes' names in the dataset
* `task`: The task-ID. This should be a factor in the data, but is entered here as a string
* `outcome`: The outcome variable, entered as a string
* `resID`: The respondent-ID variable. Entered here as a string, but it should be an integer in the data

### Example:
`cjointCarryTest(data=experimentdata, attributes=c("gender","age","income","education"),outcome="rating",task="taskID",resID="res_id")`

## cjointRandoTest_I()

This function checks data from conjoint experiments for randomization problems. Specifically, it computes chi-squared tests on contingency tables of respondent-level characteristics and profile attributes. If the randomization of profiles was successful, there should be no associations between any respondent-level characteristics and profile attributes. A rejected null, on the other hand, indicates that some groups of respondents were more likely to be presented with some profile attributes. This can indicate that there were problems with the randomization of attributes across profiles. The output (a matrix) can be labeled.

The function takes as arguments:
* `data`: A data.frame
* `resvars`: A character vector of respondent characteristics (the names of the corresponding variables in the dataset)
* `dims`: A character vector of profile attributes (again, the variables' names in the dataset)
* `dimlabs`: Optional. A character vector of labels for the profile attributes (Important: the order of the labels must correspond to the order of attributes in `dims`!)
* `reslabs`: Optional. A character vector of labels for the respondent characteristics (Important: the order of the labels must correspond to the order of attributes in `resvars`!)

### Example:
`cjointRandoTest_I(data=experimentdata,
  resvars=c("age_respondent","gender_respondent"),
  dims=c("age","gender","income"),
  reslabs=c("Age (respondent)","Gender (respondent)"),
  dimlabs=c("Age","Gender","Income"))`

## cjointRandoTest_II()

This function checks data from conjoint experiments for randomization problems by checking for associations between any pair of profile attributes. Similar to `cjointRandoTest_I`, it cross-tabulates all combinations of profile attributes and computes chi-squared tests to test if there are any significant associations between these attributes. A rejected null (small p-value) indicates that there is some statistically significant association between profile attributes. The output can be labeled.

The function takes as arguments:
* `data`: A data.frame
* `dims`: A character vector of vignette attributes' names in the dataset
* `labels`: Optional. A character vector of labels for the vignette attributes (Important: the order of the labels must correspond to the order of attributes in `dims`!)

### Example:
`cjointRandoTest_II(data=experimentdata,dims=("age","nationality","gender"))`

## cjointCramTest()

This function complements the `cjointRandoTest_II()` function. Whereas the `cjointRandoTest_II()` function assesses the _statistical significance_ of any inter-attribute associations, the `cjointCramTest()` function assesses how strong these associations are. The function cross-tabulates all combinations of vignette attributes and computes Cramer's V statistics, which are a measure of strongly two categorical variables are associated. 0 indicates no association and 1 perfect association (similar to Pearson's correlation coefficient). The function computes these tests and arranges the test statistics into a matrix. The output can be labeled.

The function takes as arguments:
* `data`: A data.frame
* `dims`: A character vector of vignette attributes' names in the dataset
* `labels`: Optional. A character vector of labels for the vignette attributes (the order must correspond to the one in `dims`!)

### Example:
`cjointCramtTest(data=experimentdata,dims=("age","nationality","gender"))`
