# Lab 7 – OLS Regression Analysis

**ECON B2000 – MA Econometrics | Fall 2026**

## Overview

For this lab, I used the ACS 2021 couples dataset to examine whether a woman's age and education are related to the age difference between her and her husband.

I focused on couples where the husband is more than 6 years older than his wife.

## Analysis

I estimated two OLS regression models:

- Model 1: Woman's age and education.
- Model 2: Woman's age, education, and geographic region.

I also used an ANOVA test to check whether the region variables were jointly statistically significant and created graphs to show the results.

## Results

The results showed that higher education and age were associated with a lower predicted probability of having a husband more than 6 years older.

Adding geographic region increased R-squared from 0.00985 to 0.01128. The ANOVA test showed that region was jointly statistically significant (p < 0.001), although the improvement in explanatory power was small.

## Files

- `Lab7.R` – R code used for the analysis.
- `Lab7.Rmd` – R Markdown report with results and graphs.

The final HTML report was submitted separately through Brightspace.
