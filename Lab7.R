library(ggplot2)
library(tidyverse)
library(haven)
dim(acs2021_couples)
acs2021_couples$RACE <- fct_recode(
  as.factor(acs2021_couples$RACE),
  "White" = "1",
  "Black" = "2",
  "American Indian or Alaska Native" = "3",
  "Chinese" = "4",
  "Japanese" = "5",
  "Other Asian or Pacific Islander" = "6",
  "Other race" = "7",
  "two races" = "8",
  "three races" = "9"
)
acs2021_couples$h_race <- fct_recode(
  as.factor(acs2021_couples$h_race),
  "White" = "1",
  "Black" = "2",
  "American Indian or Alaska Native" = "3",
  "Chinese" = "4",
  "Japanese" = "5",
  "Other Asian or Pacific Islander" = "6",
  "Other race" = "7",
  "two races" = "8",
  "three races" = "9"
)
acs2021_couples$HISPAN <- fct_recode(
  as.factor(acs2021_couples$HISPAN),
  "Not Hispanic" = "0",
  "Mexican" = "1",
  "Puerto Rican" = "2",
  "Cuban" = "3",
  "Other" = "4"
)
acs2021_couples$h_hispan <- fct_recode(
  as.factor(acs2021_couples$h_hispan),
  "Not Hispanic" = "0",
  "Mexican" = "1",
  "Puerto Rican" = "2",
  "Cuban" = "3",
  "Other" = "4"
)
dim(acs2021_couples)
trad_data <- acs2021_couples %>%
  filter(SEX == "Female" & h_sex == 1 & RELATE == 2)
trad_data$age_diff <- trad_data$AGE - trad_data$h_age
trad_data$he_older_6 <- as.numeric(
  trad_data$age_diff < -6
)
nrow(trad_data)
table(trad_data$he_older_6)
trad_data <- acs2021_couples %>%
  filter(SEX == "Female" & h_sex == 1 & RELATE == 2)
trad_data$age_diff <- trad_data$AGE - trad_data$h_age
trad_data$he_older_6 <- as.numeric(
  trad_data$age_diff < -6
)
nrow(trad_data)
table(trad_data$he_older_6)
trad_data$educ_hs <- as.numeric(
  as.character(trad_data$EDUC) == "Grade 12"
)
trad_data$educ_somecoll <- as.numeric(
  as.character(trad_data$EDUC) %in%
    c("1 year of college",
      "2 years of college",
      "3 years of college")
)
trad_data$educ_college <- as.numeric(
  as.character(trad_data$EDUC) == "4 years of college"
)
trad_data$educ_advdeg <- as.numeric(
  as.character(trad_data$EDUC) == "5+ years of college"
)
ols_out1 <- lm(
  he_older_6 ~ educ_hs + educ_somecoll +
    educ_college + educ_advdeg + AGE,
  data = trad_data
)
summary(ols_out1)
library(ggplot2)
graph_data <- data.frame(
  educ_hs = c(0, 1, 0, 0, 0),
  educ_somecoll = c(0, 0, 1, 0, 0),
  educ_college = c(0, 0, 0, 1, 0),
  educ_advdeg = c(0, 0, 0, 0, 1),
  AGE = rep(mean(trad_data$AGE, na.rm = TRUE), 5)
)
graph_data$Probability <- predict(
  ols_out1, newdata = graph_data
) * 100
graph_data$Education <- factor(
  c("Below High School", "High School",
    "Some College", "College", "Advanced Degree"),
  levels = c("Below High School", "High School",
             "Some College", "College",
             "Advanced Degree")
)
plot1 <- ggplot(
  graph_data,
  aes(x = Education, y = Probability)
) +
  geom_col(fill = "steelblue", width = 0.65) +
  geom_text(
    aes(label = paste0(round(Probability, 1), "%")),
    vjust = -0.5, size = 4
  ) +
  labs(
    title = "Education and Spousal Age Differences",
    subtitle = "OLS Model 1: Predictions at Mean Woman's Age",
    x = "Woman's Education",
    y = "Predicted Probability (%)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x = element_text(angle = 20, hjust = 1)
  ) +
  coord_cartesian(
    ylim = c(0, max(graph_data$Probability) * 1.15)
  )
print(plot1)
age_data <- data.frame(
  AGE = seq(20, 80, by = 1),
  educ_hs = 1,
  educ_somecoll = 0,
  educ_college = 0,
  educ_advdeg = 0
)
age_data$Probability <- predict(
  ols_out1, newdata = age_data
) * 100
plot2 <- ggplot(
  age_data,
  aes(x = AGE, y = Probability)
) +
  geom_line(
    color = "steelblue",
    linewidth = 1.2
  ) +
  labs(
    title = "Woman's Age and Spousal Age Differences",
    subtitle = "OLS Model 1: High School Education",
    x = "Woman's Age",
    y = "Predicted Probability (%)"
  ) +
  theme_minimal(base_size = 12)
print(plot2)
ggsave("Lab7_Education_Plot.png",
       plot = plot1, width = 9, height = 6, dpi = 300)

ggsave("Lab7_Age_Plot.png",
       plot = plot2, width = 9, height = 6, dpi = 300)
table(trad_data$REGION)
trad_data$REGION <- as.factor(trad_data$REGION)
ols_out2 <- lm(
  he_older_6 ~ educ_hs + educ_somecoll +
    educ_college + educ_advdeg + AGE + REGION,
  data = trad_data
)
summary(ols_out2)
data.frame(
  Model = c("OLS Model 1", "OLS Model 2 + Region"),
  R_Squared = c(
    summary(ols_out1)$r.squared,
    summary(ols_out2)$r.squared
  )
)
anova(ols_out1, ols_out2)
summary(ols_out2)
levels(trad_data$REGION)
data.frame(
  Model = c("Original OLS", "OLS + Region"),
  R_Squared = c(
    summary(ols_out1)$r.squared,
    summary(ols_out2)$r.squared
  )
)
coef(summary(ols_out2))[grep("REGION",
                             rownames(coef(summary(ols_out2)))), ]
library(ggplot2)
comparison <- data.frame(
  Model = c("Original OLS", "OLS + Region"),
  R_Squared = c(
    summary(ols_out1)$r.squared,
    summary(ols_out2)$r.squared
  )
)
comparison$Percentage <- comparison$R_Squared * 100
plot_region <- ggplot(
  comparison,
  aes(x = Model, y = Percentage, fill = Model)
) +
  geom_col(width = 0.6) +
  geom_text(
    aes(label = paste0(round(Percentage, 3), "%")),
    vjust = -0.5,
    size = 5
  ) +
  scale_y_continuous(
    breaks = seq(0, 1.4, by = 0.2),
    limits = c(0, 1.4),
    labels = function(x) paste0(x, "%")
  ) +
  scale_fill_manual(
    values = c("Original OLS" = "steelblue",
               "OLS + Region" = "darkorange")
  ) +
  labs(
    title = "Explanatory Power Before and After Adding Region",
    subtitle = "OLS Models: Spousal Age Difference",
    x = NULL,
    y = "Variation Explained (R-squared)"
  ) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "none")
print(plot_region)
ggsave("Lab7_Region_Comparison.png",
       plot = plot_region,
       width = 8, height = 5, dpi = 300)
