
################################################################################
############################ Web scraping HTML #################################
################################################################################

library(tidyverse)
library(rvest)

url='https://en.wikipedia.org/wiki/World_Happiness_Report'

happy=read_html(url)%>%
  html_element('table.wikitable') %>%
  html_table()


colnames(happy)
class(happy)

colnames(happy)= c('rank', 
                   'CountryOrRegion', 
                   'Score', 
                   'GDPPerCapita', 
                   'SocialSupport', 
                   'HealthyLifeExpectancy', 
                   'FreedomToMakeLifeChoces',
                   'Generosity', 
                   'PerceptionsOfCorruption')


colnames(happy)

ggplot(happy, 
       aes(x=GDPPerCapita, y=SocialSupport)) +
       geom_point() + 
       geom_smooth(method='lm')


#################### Web scraping HTML pages in three steps ####################

# 1. Selecting HTML elements
# 2. Selecting descendants (children, children’s children, etc.)
# 3. Extracting data from elements


url='https://raw.githack.com/ccs-amsterdam/r-course-material/master/miscellaneous/simple_html.html'

read_html(url)%>%
  html_element('#exampleTable') %>%  # access the table using #id_name
  html_table()


read_html(url)%>%
  html_element('#steve') %>%
  html_table()


read_html(url)%>%
  html_element('.someTable') %>%  # access the table using .class_name
  html_table()


read_html(url)%>%
  html_element('.someTable.blue') %>%  # space should be replaced with dot
  html_table()

read_html(url)%>%
  html_element('tr.headerRow') %>%  # space should be replaced with dot
  html_text()


'https://en.wikipedia.org/wiki/Hyperlink' %>%
  read_html() %>%
  html_elements('#content a') %>% # select #content within <a> tag
  length()

'https://en.wikipedia.org/wiki/Hyperlink' %>%
  read_html() %>%
  html_elements('a') %>% #  select all <a> tag
  length()



html='https://en.wikipedia.org/wiki/Hyperlink' %>%
  read_html() %>%
  html_elements('#content a') %>% 
  html_text()

li=list()

for (i in 1:length(html)){
  li = append(li, html[i])
}

print(li)



html = 'https://bit.ly/3lz6ZRe' %>% read_html

html %>%
  html_element('.leftColumn') %>%
  html_text()  # There are lots of '\n' and spaces


html %>%
  html_element('.leftColumn') %>%
  html_text2() # return texts as shown in web browser

html %>%
  html_element('.leftColumn') %>%
  html_text2() %>%
  cat()       # return resuls in the same format as seen in web browser

library(dplyr)
html %>%
  html_element('.rightColumn') %>%
  html_text2()%>%
  cat()

html%>%
  html_element('#steve') %>%
  html_table()


html%>%
  html_element('a') %>%  # return first href link
  html_attr('href')


html%>% 
  html_element('a') %>% # return all the href links
  html_attrs()


'https://en.wikipedia.org/wiki/Hyperlink' %>%
  read_html() %>%
  html_elements('#content a') 


'https://en.wikipedia.org/wiki/Hyperlink' %>%
  read_html() %>%
  html_elements('#content a') %>% 
  html_attr('href')


############## Scraping single pages: An actor profile from IMDB ###############

html = read_html('https://www.imdb.com/name/nm0000195/')

name_overview = html %>% 
  html_element('#name-overview-widget')

html_text2(name_overview)  

name = name_overview %>% 
  html_element('h1 .itemprop') %>% 
  html_text2()

name


job_categories = name_overview %>% 
  html_elements('#name-job-categories .itemprop') %>% # use plural html_elements because there are multiple '#name-job-catergories'
  html_text2()

job_categories


bio = name_overview %>% 
  html_element('#name-bio-text') %>% 
  html_text2()

bio


born_date = name_overview %>%
  html_element('#name-born-info time') %>% 
  html_attr('datetime')

born_date


born_location = name_overview %>%
  html_element('#name-born-info > a') %>% 
  html_text2()

born_location


### Put them all together ###
install.packages("tibble")
library(tibble)



html = read_html('https://www.imdb.com/name/nm0000195/')

name_overview = html %>% html_element('#name-overview-widget')
name = name_overview %>% html_element('h1 .itemprop') %>% html_text2()
job_categories = name_overview %>% html_elements('#name-job-categories .itemprop') %>% html_text2()
bio = name_overview %>% html_element('#name-bio-text') %>% html_text2()
born_date = name_overview %>% html_element('#name-born-info time') %>% html_attr('datetime')
born_location = name_overview %>% html_element('#name-born-info > a') %>% html_text2()


tibble(name, 
       born_date, 
       born_location, 
       bio,
       job_categories = paste(job_categories, collapse=' | '))



billMurray=data.frame(Name=name, 
                      Jobs=paste(job_categories, collapse=' | '), 
                      Biography=bio, 
                      Birthdate=born_date, 
                      Birthlocation=born_location)
billMurray

View(billMurray)


############# Scraping an archive: all actor profiles for a movie ##############

html = read_html('https://www.imdb.com/title/tt0362270/fullcredits?ref_=tt_cl_sm')
html %>% html_element('table.cast_list') %>% html_table()

# grab the url of each actor
bio_urls = html %>% html_elements('.cast_list .primary_photo a') %>% html_attr('href')
head(bio_urls, 5)  # show just first 5 

# But hey, these aren’t URLs yet. Since these are links within the imdb.com domain, they don’t contain the whole 
# https://imdb.com/ jingle. We can just paste this onto them though.
bio_urls = paste('https://imdb.com', bio_urls, sep='')
head(bio_urls, 5)  # show just first 5 

## looping over the URLs for putting them all together ##

# the URL for the cast page of a movie
movie_cast_url = 'https://www.imdb.com/title/tt0362270/fullcredits?ref_=tt_cl_sm'

## get URLs for every cast member
bio_urls = read_html(movie_cast_url) %>%
  html_elements('.cast_list .primary_photo a') %>% 
  html_attr('href')
bio_urls = paste('https://imdb.com', bio_urls, sep='')

## take just first 5 cast members for demo
top5_bio_urls = head(bio_urls, 5)

## loop over cast member bio_urls
results = list()
for (bio_url in top5_bio_urls) {
  message('Scraping URL: ', bio_url)
  
  ## read the html for the bio page
  bio_html = read_html(bio_url) 
  
  ## parse the bio page
  name_overview = bio_html %>% html_element('#name-overview-widget')
  name = name_overview %>% html_element('h1 .itemprop') %>% html_text2()
  job_categories = name_overview %>% html_elements('#name-job-categories .itemprop') %>% html_text2()
  bio = name_overview %>% html_element('#name-bio-text') %>% html_text2()
  born_date = name_overview %>% html_element('#name-born-info time') %>% html_attr('datetime')
  born_location = name_overview %>% html_element('#name-born-info > a') %>% html_text2()
  
  ## save results
  bio_tibble = tibble(name, born_date, born_location, bio,
                      job_categories = paste(job_categories, collapse=' | '))
  results[[bio_url]] = bio_tibble
}

View(results)

d = bind_rows(results, .id = 'url')
d


################# Using functions for scraping an archive ######################

# Function for parsing the bio page.
parse_bio_page <- function(bio_url) {
  message('Scraping URL: ', bio_url)
  
  html = read_html(bio_url) 
  name_overview = html %>% html_element('#name-overview-widget')
  name = name_overview %>% html_element('h1 .itemprop') %>% html_text2()
  job_categories = name_overview %>% html_elements('#name-job-categories .itemprop') %>% html_text2()
  bio = name_overview %>% html_element('#name-bio-text') %>% html_text2()
  born_date = name_overview %>% html_element('#name-born-info time') %>% html_attr('datetime')
  born_location = name_overview %>% html_element('#name-born-info > a') %>% html_text2()
  
  ## return tibble
  tibble(name, born_date, born_location, bio, job_categories = paste(job_categories, collapse=' | '))
}

# Function for getting the biography page urls.
get_bio_urls <- function(cast_url, max_urls=Inf) {
  bio_urls = read_html(cast_url) %>%
    html_elements('.cast_list .primary_photo a') %>% 
    html_attr('href') %>%
    head(max_urls)
  
  paste('https://imdb.com', bio_urls, sep='')
} 


movie_cast_url = 'https://www.imdb.com/title/tt0362270/fullcredits?ref_=tt_cl_sm'

bio_urls = get_bio_urls(movie_cast_url, max_urls=5)

results = list()
for (bio_url in bio_urls) {
  results[[bio_url]] = parse_bio_page(bio_url)
}

d=bind_rows(results, .id = 'url')

d

bio.data.actors=data.frame(d)
bio.data.actors

View(bio.data.actors)

# Store the data into a csv file
write.csv(d, 'Bio data for actors.csv', row.names=FALSE)


