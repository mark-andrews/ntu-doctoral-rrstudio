library(tidyverse)
library(skimr)

weight_df <- read_csv("data/weight.csv") # note: it is read_csv not read.csv


# Descriptives with skimr::skim -------------------------------------------

skim(weight_df)

# summary statistics with summarize/summarise

summarise(weight_df, mad_height = mad(height), mad_weight = mad(weight))
summarise(weight_df, 
          mad_height = mad(height), 
          mad_weight = mad(weight),
          n = n(),
          .by = gender)



# Easy inferential statistics ---------------------------------------------

result_1 <- t.test(height ~ gender, data = weight_df)

result_2 <- cor.test(~ height + weight, data = weight_df)
result_3 <- cor.test(~ height + weight, data = weight_df, 
                     method = 'spearman', exact = FALSE)



# Data visualization ------------------------------------------------------

ggplot(weight_df, aes(x = height, y = weight)) +
  geom_point(size = 0.66, alpha = 0.66)

ggplot(weight_df, aes(x = height, y = weight, colour = gender)) +
  geom_point(size = 0.66) +
  scale_colour_brewer(palette = 'Set1') +
  theme_classic() +
  labs(x = 'Height (cm)',
       y = 'Weight (kg)',
       colour = 'Gender',
       title = 'A scatterplot of height and weight, by gender.')


# show lines/curves of best fit
ggplot(weight_df, aes(x = height, y = weight, colour = gender)) +
  geom_point(size = 0.66, alpha = 0.66) +
  geom_smooth(method = 'lm', fullrange = TRUE) +
  theme_minimal()

ggplot(weight_df, aes(x = height, y = weight, colour = gender)) +
  geom_point(size = 0.66, alpha = 0.66) +
  geom_smooth(method = 'lm', fullrange = TRUE) +
  theme_minimal() +
  facet_wrap(~race, ncol = 1)

ggplot(weight_df, aes(x = height, y = weight, colour = gender, shape = race)) +
  geom_point(size = 0.66, alpha = 0.66) +
  geom_smooth(method = 'lm', fullrange = TRUE) +
  theme_minimal()

# histograms
ggplot(weight_df, aes(x=height, fill=gender)) + 
  geom_histogram(colour = 'white')

ggplot(weight_df, aes(x=height, fill=gender)) + 
  geom_histogram(colour = 'white', position = 'dodge')

ggplot(weight_df, aes(x=height, fill=gender)) + 
  geom_histogram(colour = 'white', position = 'identity', alpha = 0.66)


ggplot(weight_df, aes(x=height)) + 
  geom_histogram(colour = 'white') +
  facet_wrap(~gender, scales = 'free_x')


# General linear models ---------------------------------------------------

result_4 <- lm(weight ~ height + gender + age + race, data = weight_df)

summary(result_4)



