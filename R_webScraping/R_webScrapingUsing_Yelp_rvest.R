
################################################################################
############################ Web scraping HTML (Yelp)###########################
################################################################################

library(rvest)
library(dplyr)
library(stringr)
library(tidyverse)

############################### url object #####################################
url = 'https://www.yelp.com/biz/chipotle-mexican-grill-san-diego-17'

# Convert the ulr to html object
page=read_html(url)

################################################################################
##### EXTRACTING DATA FROM SINGLE PAGE : Dates, Ratings and Review Texts #######
################################################################################

############################## Extracting Dates  ###############################

review_dates= page %>%
  html_nodes('.css-chan6m') %>%
  html_text2()%>%  str_extract('(^\\d+)[/](\\d+)[/](\\d{4}$)')%>% na.omit()
review_dates 

### Another way to extract dates
review_dates= page %>%
  html_elements ('.css-chan6m') %>%
  html_text2()%>%  
  .[str_detect(., "^\\d+[/]\\d+[/]\\d{4}$")] # dot(.) means all the previous text 
review_dates


### Also, another way to extract dates
review_dates= page %>%
  html_elements (xpath = "//*[@class=' css-chan6m']") %>%
  html_text2()%>%  
  .[str_detect(., "^\\d+[/]\\d+[/]\\d{4}$")] 
review_dates


############################# Extracting Ratings  ##############################
review_ratings = page %>%
  html_elements(xpath = "//div[starts-with(@class, ' review')]") %>%
  html_elements(xpath=".//div[contains(@aria-label, 'rating')]")%>%
  html_attr('aria-label')
review_ratings = review_ratings %>% str_remove_all(' star rating') %>%
  as.numeric()


  
########################### Extracting Review Texts ############################
review_texts = page %>%
  html_elements(xpath = "//p[starts-with(@class, 'comment')]") %>%
  html_text2()
review_texts 
  
### Another way to extract dates
review_texts = page %>%
  html_elements('p .raw__09f24__T4Ezm') %>%
  html_text2()
review_texts 
  
  
################################################################################
#### EXTRACTING DATA FROM THE WHOLE PAGES : Dates, Ratings and Review Texts ####
################################################################################

############################## Extracting Dates  ###############################
  
### Analyse the pattern of pages

# page 1 ends with 0
# page 2 ends with 10
# page 3 ends with 20 ...


#### Convert the ulr to html object
page=read_html(url)

# go to "..." on the left and click right button of mouse and click "copy" then choose "Copy Xpath"
pageNums = page %>%
  html_node(xpath='//*[@id="main-content"]/div[2]/section[2]/div[2]/div/div[4]/div[2]/span')%>%
  html_text()
pageNums = pageNums%>%str_remove('1 of ')%>%as.numeric()
pageNums

### Create a sequence variable for the pageNums
pageSeq = seq(from=0, to=(pageNums*10)-10, by=10)



### Store items in vectors
review_dates_all = c()
review_ratings_all = c()
review_texts_all = c()


### loop over the pages

for (i in pageSeq[1:3]){
  
  if (i==0){
    page=read_html(url)        # the first webpage is out of the pattern, we need to use the url which is copied and pasted
  } else{
    page=read_html(paste0(url, '?start=', i))
  }
  
  ############################# Extracting Dates  ##############################
  review_dates= page %>%
    html_elements ('.css-chan6m') %>%
    html_text2()%>%  
    .[str_detect(., "^\\d+[/]\\d+[/]\\d{4}$")] # dot(.) means all the previous text 
  review_dates
  
  
  ############################ Extracting Ratings  #############################
  review_ratings = page %>%
    html_elements(xpath = "//div[starts-with(@class, ' review')]") %>%
    html_elements(xpath=".//div[contains(@aria-label, 'rating')]")%>%
    html_attr('aria-label')
  review_ratings = review_ratings %>% str_remove_all(' star rating') %>%
    as.numeric()
  
  
  ########################## Extracting Review Texts ###########################
  review_texts = page %>%
    html_elements('p .raw__09f24__T4Ezm') %>%
    html_text2()
  review_texts 
  
  
  ##################### Appending data to their variables ######################
  
  review_dates_all = append(review_dates_all, review_dates)
  review_ratings_all = append(review_ratings_all, review_ratings)
  review_texts_all = append(review_texts_all, review_texts)
  
}

### There is an error because the length of each vector is different
df = data.frame('Date'= review_dates_all,
                'Rating'=review_ratings_all,
                'Text'=review_texts_all)

length(review_dates_all)
length(review_ratings_all)
length(review_texts_all)

### Make the length of the vectors  the same
length(review_dates_all) =  length(review_texts_all)
length(review_ratings_all) =  length(review_texts_all)


length(review_dates_all)
length(review_ratings_all)
length(review_texts_all)

df = data.frame('Date'= review_dates_all,
                'Rating'=review_ratings_all,
                'Text'=review_texts_all)

View(df)

### Change the data type of Date to 'Date'

df$Date=as.Date(df$Date, '%m/%d/%Y')

class(df$Date)

