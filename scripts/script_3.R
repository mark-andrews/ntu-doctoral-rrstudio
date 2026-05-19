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

ggplot(weight_df, aes(x = height, y = weight))

