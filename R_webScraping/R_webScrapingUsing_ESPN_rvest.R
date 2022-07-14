
################################################################################
############################ Web scraping HTML (ESPN)###########################
################################################################################


library(rvest)
library(dplyr)
library(stringr)


schedule_url=read_html('https://www.espn.com/nba/team/schedule/_/name/lal/los-angeles-lakers')
lakers_schedule=schedule_url %>%
                html_node('table') %>%
                html_table(fill=TRUE)

View(lakers_schedule)


game_ids=schedule_url %>% 
         str_extract_all ('(?<=gameId/)(.*?)(?=")') # regex (?<=) means positive look behind (?=) postivie look ahead


# In the table, the game results (gameIds) are links so we extract all the gameIds

game_ids = game_ids %>% 
           unlist() %>% 
           unique() # unlist() converts a lit to vector
game_ids


# We can go any data using the gameIds
# Extact team_stats

team_states_url=read_html('https://www.espn.com/nba/matchup/_/gameId/401360213')
lakers_stats=team_states_url %>% 
             html_nodes('table') %>% 
             html_table(fill=T) # Use plural html_nodes()
lakers_stats

lakers_stats = lakers_stats[[2]]
lakers_stats

