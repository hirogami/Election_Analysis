# Refer to https://github.com/alex/nyt-2020-election-scraper
# Refer to https://github.com/jaytimm/American-political-data-and-R
# Data https://raw.githubusercontent.com/alex/nyt-2020-election-scraper/master/battleground-state-changes.csv
# Data https://raw.githubusercontent.com/alex/nyt-2020-election-scraper/master/all-state-changes.csv

library(tidyverse)
# read the data
df0 <- read_csv("https://raw.githubusercontent.com/alex/nyt-2020-election-scraper/master/battleground-state-changes.csv")
# select the columns and subset the rows of the state
# Alaska (EV: 3), Arizona (EV: 11), Georgia (EV: 16), Nevada (EV: 6), 	North Carolina (EV: 15)
select_state <- "Pennsylvania (EV: 20)"
df0 %>% 
  select(state, timestamp, 
         leading_candidate_name, 
         trailing_candidate_name, 
         leading_candidate_votes, 
         trailing_candidate_votes) %>% 
  filter(state == select_state) -> df0_selected

# get the names and votes irrelevant to whether they are leading or trailing
df0_selected %>%
  select(!trailing_candidate_votes) %>% 
  filter(leading_candidate_name == "Biden") %>% 
  rename(name = leading_candidate_name,
         votes = leading_candidate_votes) -> biden1
df0_selected %>%
  select(!leading_candidate_votes) %>% 
  filter(trailing_candidate_name == "Biden") %>% 
  rename(name = trailing_candidate_name,
         votes = trailing_candidate_votes) -> biden2
df0_selected %>%
  select(!trailing_candidate_votes) %>% 
  filter(leading_candidate_name == "Trump") %>% 
  rename(name = leading_candidate_name,
         votes = leading_candidate_votes) -> trump1
df0_selected %>%
  select(!leading_candidate_votes) %>% 
  filter(trailing_candidate_name == "Trump") %>% 
  rename(name = trailing_candidate_name,
         votes = trailing_candidate_votes)-> trump2

# binde the rows
all <- bind_rows(biden1, biden2, trump1, trump2)

# create a line chart
p <- ggplot(all, aes(x=timestamp, 
                     y=votes, 
                     group = name,
                     color=name)) +
  geom_line()
p + ggtitle(label = select_state,
            subtitle = "2020 Presidential Election Results changed over time")
