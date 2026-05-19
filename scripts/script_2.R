library(readr)
library(tidyverse)

weight_df <- read_csv("weight.csv")

summarise(weight_df, mean(height), sd(height))

result <- lm(weight ~ height, data = weight_df)
summary(result)
