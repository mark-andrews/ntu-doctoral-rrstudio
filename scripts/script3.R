library(tidyverse)

blp_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/ntu-doctoral-rrstudio/main/data/blp-trials-short.txt")

# dplyr verbs

# select *
# relocate
# rename
# slice
# filter *
# mutate * 
# arrange
# summarize

# the pipe: %>% |> 

# selecting with select ---------------------------------------------------


select(blp_df, participant, resp, lex, rt)

# if you want to save the resulting subsetting dataframe ...
blp_df2 <- select(blp_df, participant, resp, lex, rt)

select(blp_df, subject = participant, resp, lex, reaction_time = rt)

# select by index
select(blp_df, 1, 3, 5)

select(blp_df, participant:rt)
select(blp_df, 1:5)

select(blp_df, participant:spell, rt = rt.raw)
select(blp_df, 1:3, rt.raw)

select(blp_df, starts_with('r'))
select(blp_df, starts_with('rt'))
select(blp_df, ends_with('t'))
select(blp_df, ends_with('rt'))

select(blp_df, contains('rt'))

# with regexps, select cols that begin with or end with 'rt'
select(blp_df, matches('^rt|rt$'))

select(blp_df, matches('a.t$'))

select(blp_df, -participant)
select(blp_df, -(participant:resp))

select(blp_df, where(is.numeric))

select(blp_df, participant, resp, spell, lex)
select(blp_df, participant, resp, spell, lex, everything())


# reordering with relocate ----------------------------------------------------------------


