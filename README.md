# Lab 7 - OLS Regression

**ECON B2000 – MA Econometrics | Fall 2026**

## Introduction

For this lab, I used the ACS 2021 couples dataset to look at whether a woman's age and education are related to the age difference between her and her husband.

I chose a 6-year age difference instead of the 5 years used in the example. The dependent variable equals 1 if the husband is more than 6 years older and 0 otherwise.

## Data Preparation

I selected married couples with a female spouse and male householder. I used the woman's age and education first, and then added geographic region.

| Group | Couples |
|---|---:|
| Husband not more than 6 years older | 313,142 |
| Husband more than 6 years older | 53,561 |
| **Total** | **366,703** |

## OLS Model 1: Age and Education

I started with an OLS regression using the woman's education and current age.

### Regression Results

| Variable | Coefficient | P-value |
|---|---:|---:|
| Intercept | 0.3042 | <0.001 |
| High school | -0.0359 | <0.001 |
| Some college | -0.0487 | <0.001 |
| College | -0.0749 | <0.001 |
| Advanced degree | -0.0853 | <0.001 |
| Age | -0.0019 | <0.001 |

**R-squared:** 0.00985

### Interpretation

The results show that all education variables have negative coefficients and are statistically significant (p < 0.001).

Women with higher education levels have a lower predicted probability of having a husband more than 6 years older, compared with women with less than a high school education.

For example, women with advanced degrees have an 8.53 percentage-point lower predicted probability, holding age constant. Age also has a negative coefficient. Each additional year of age is associated with about a 0.19 percentage-point decrease in the predicted probability.

However, the R-squared is only 0.00985. This means age and education explain about 0.99% of the variation, which is very low.

### Figure 1: Education and Age Differences

<img width="1106" height="800" alt="image" src="https://github.com/user-attachments/assets/b134f1f3-a22c-46e6-b5ee-5850cef64df4" />


The graph shows that women with higher education levels have a lower predicted probability of having a husband more than 6 years older.

### Figure 2: Woman's Age and Age Differences

<img width="1106" height="800" alt="image" src="https://github.com/user-attachments/assets/d35890b2-52ed-4972-ac8c-32f1e892a889" />


The graph shows that as a woman's current age increases, the predicted probability of a larger age gap decreases slightly.

## OLS Model 2: Adding Geographic Region

Next, I added geographic region to see whether it helps explain age differences between couples.

Before running the model, I expected that couples in the South might have larger age gaps, while couples in the Northeast might have smaller age gaps.

### Regional Results

| Region | Coefficient | P-value |
|---|---:|---:|
| REGION12 | -0.0039 | 0.2134 |
| REGION21 | -0.0224 | <0.001 |
| REGION22 | -0.0251 | <0.001 |
| REGION31 | 0.0115 | <0.001 |
| REGION32 | -0.0070 | 0.0516 |
| REGION33 | 0.0002 | 0.9445 |
| REGION41 | 0.0030 | 0.3819 |
| REGION42 | 0.0140 | <0.001 |

### Interpretation

The results show that some geographic regions have statistically significant coefficients.

REGION21 and REGION22 have lower predicted probabilities by approximately 2.24 and 2.51 percentage points compared with the reference region. REGION31 and REGION42 have higher predicted probabilities by approximately 1.15 and 1.40 percentage points.

This suggests that geographic location is related to age differences, although not all regions are statistically significant.

## Hypothesis Testing

I used an ANOVA test to see whether all the region coefficients are jointly equal to zero.

- **H0:** All region coefficients equal zero.
- **H1:** At least one region coefficient is different from zero.

| F-statistic | P-value |
|---:|---:|
| 66.274 | <0.001 |

The F-statistic was 66.274, with a p-value below 0.001. Since the p-value is very small, I rejected the null hypothesis. This means the region variables are jointly statistically significant and provide additional information to the model.

## Comparing the Two Models

| Model | R-squared |
|---|---:|
| Original OLS | 0.00985 |
| OLS + Region | 0.01128 |

Adding region increased R-squared from 0.00985 to 0.01128. The model now explains about 1.13% of the variation instead of 0.99%. The improvement is small, even though region is statistically significant.

### Figure 3: R-Squared Comparison

<img width="1106" height="800" alt="image" src="https://github.com/user-attachments/assets/eecc9f0e-ce67-4ad7-b8d1-6edacdb7426f" />


The graph shows that including region improves the model slightly, but both models still explain a small percentage of the variation.

## Conclusion

Overall, I found that a woman's age and education are negatively related to the probability of having a husband more than 6 years older.

Adding geographic region improved the model a little, and the ANOVA test showed that region is jointly statistically significant.

However, both models have low R-squared values, so there are probably other factors that could help explain age differences between couples.

These results show relationships between variables, but they do not necessarily mean that one variable causes the age difference.

## Project Files

- `Lab7.R` – R analysis script
- `Lab7.Rmd` – R Markdown source report
- `Lab7.html` – HTML report (submitted separately on Brightspace)

The ACS 2021 data file is needed to run the analysis and is not included in this repository.
