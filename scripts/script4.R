library(tidyverse)

smoking_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/ntu-doctoral-rrstudio/main/data/smoking.csv")

smoking_df %>% count(cigs) %>% print(n = Inf)
smoking_df %>% count(white)
smoking_df %>% count(restaurn)

smoking_df <- smoking_df %>% mutate(smoker = cigs > 0)

result_6 <- glm(smoker ~ educ + cigpric + white + age + income + restaurn, 
                family = binomial(link = 'logit'),
                data = smoking_df)

summary(result_6)
round(summary(result_6)$coefficients, 3)

smoking_df2 <- tibble(educ = c(6, 12, 18),
                      cigpric = 60,
                      white = 1,
                      age = 40,
                      income = 20000,
                      restaurn = 0)

# predict
# add_predictions
library(modelr)
add_predictions(smoking_df2, result_6, type = 'response')

exp(confint.default(result_6, parm = 'educ'))

# Poisson regression ------------------------------------------------------

result_7 <- glm(cigs ~ educ + cigpric + white + age + income + restaurn, 
                family = poisson(link = 'log'),
                data = smoking_df)

summary(result_7)
round(summary(result_7)$coefficients, 3)

add_predictions(smoking_df2, result_7, type = 'response')
exp(confint.default(result_7, parm = 'educ'))

# mixed effects -----------------------------------------------------------

library(lme4)

ggplot(sleepstudy, 
       aes(x = Days, y = Reaction, colour = Subject)) + 
  geom_point() +
  stat_smooth(method = 'lm', se = F) +
  facet_wrap(~Subject)
  
  
result_8 <- lmer(Reaction ~ Days + (Days|Subject), data = sleepstudy)

summary(result_8)
library(lmerTest)

logLik(result_8)

