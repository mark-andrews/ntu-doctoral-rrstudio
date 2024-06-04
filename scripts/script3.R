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

relocate(blp_df, rt)
relocate(blp_df, starts_with('r'))

relocate(blp_df, starts_with('r'), .after = participant)
relocate(blp_df, starts_with('r'), .before = spell)

relocate(blp_df, where(is.numeric))

relocate(blp_df, participant, .after = rt.raw)
relocate(blp_df, participant, .after = last_col())


# renaming with rename ----------------------------------------------------

select(blp_df, subject = participant)
select(blp_df, subject = participant, everything())

rename(blp_df, subject = participant)

rename(blp_df, PARTICIPANT = participant, LEX = lex)

rename_with(blp_df, toupper)

rename_with(blp_df, toupper, .cols = starts_with('rt'))
rename_with(blp_df, toupper, .cols = where(is.numeric))


# slicing with slice ------------------------------------------------------

slice(blp_df, 5)
slice(blp_df, 5:12)
slice(blp_df, 1, 2, 5:8, 12)
slice(blp_df, -5)
slice(blp_df, -(1:10))

slice(blp_df, 995:1000)
slice(blp_df, 995:n())

# filtering with filter ---------------------------------------------------

filter(blp_df, rt < 600)
filter(blp_df, rt <= 600) 
filter(blp_df, rt >= 500, rt <= 600)
filter(blp_df, rt >= 500 & rt <= 600)
filter(blp_df, rt >= 500 | rt <= 600)

filter(blp_df, lex == 'N')
filter(blp_df, lex == 'W', rt > 500)
filter(blp_df, lex == 'W', rt > 250, rt < 1000)

filter(blp_df, if_any(everything(), is.na))
filter(blp_df, if_all(everything(), is.na))

filter(blp_df, rt <= 500, prev.rt <= 500, rt.raw <= 500)
# equiv to ...
filter(blp_df, if_all(matches('^rt|rt$'), ~ . <= 500))

# adding/changing variables with mutate -----------------------------------

mutate(blp_df, accuracy = lex == resp)
mutate(blp_df, accuracy = lex == resp, .before = rt)
mutate(blp_df, lex == resp)

mutate(blp_df,
       accuracy = lex == resp,
       fast_rt = rt < 500
)

mutate(blp_df, RT = rt / 1000, FAST_RT = RT < 0.5)

mutate(blp_df, 
       lex = as.factor(lex),
       spell = as.factor(spell),
       resp = as.factor(resp))

select(blp_df, where(is.character))

mutate(blp_df, across(where(is.character), as.factor))

