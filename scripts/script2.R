library(tidyverse)
library(skimr)

weight_df <- read_csv("weight.csv")

glimpse(weight_df)
skim(weight_df)

weight_df1 <- select(weight_df, gender, age, height, weight)

select(weight_df, 1:3)
select(weight_df, height:weight)
select(weight_df, contains('eight'))
select(weight_df, age, contains('eight'))

filter(weight_df, height > 160)
filter(weight_df, gender == 'Male', height > 180)
filter(weight_df, gender > 'Male')

# t tests -----------------------------------------------------------------


result_1 <- t.test(height ~ gender, data = weight_df)

result_1$conf.int
result_1$statistic
result_1$p.value
result_1$stderr
result_1$parameter


result_2 <- t.test(height ~ gender, data = weight_df, var.equal = TRUE)

# Linear models -----------------------------------------------------------

result_2 <- lm(weight ~ height, data = weight_df)
summary(result_2)

confint(result_2)

result_3 <- lm(weight ~ height + age, data = weight_df)

summary(result_3)
confint(result_3)


result_4 <- lm(weight ~ height + age + gender, data = weight_df)

summary(result_4)


# One way ANOVA -----------------------------------------------------------

result_5 <- aov(weight ~ group, data = PlantGrowth)
summary(result_5)

result_6 <- lm(weight ~ group, data = PlantGrowth)
summary(result_6)

tooth_growth <- mutate(ToothGrowth, dose = factor(dose))

result_7 <- aov(len ~ supp * dose, data = tooth_growth)
result_8 <- aov(len ~ supp + dose + supp:dose, data = tooth_growth)

summary(result_7)


# Scatterplot -------------------------------------------------------------


ggplot(weight_df, aes(x = height, y = weight)) + 
  geom_point(size = 0.5, alpha = 0.5, colour = 'red')

ggplot(weight_df, aes(x = height, y = weight, colour = gender)) + 
  geom_point(size = 0.5, alpha = 0.5) +
  geom_smooth(method = 'lm')


# Post-hoc pairwise comparisons -------------------------------------------

library(emmeans)
emmeans(result_5, specs = ~ group)
emmeans(result_5, specs = pairwise ~ group, adjust = 'bonf')
