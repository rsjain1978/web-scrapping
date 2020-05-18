library(tidyverse)
library(htmltools)
library (rvest)
library(RSelenium)
library(magrittr)
library(XML)

# Start Selenium Server --------------------------------------------------------
rD <- rsDriver(chromever = '81.0.4044.138',verbose = FALSE,port=4444L)

#get remote driver
remDrv<- remoteDriver()

#open connection
remDrv$open()

#navigate the covidwarriors site. on the main screen scrap the summary of covid warriors at india level.
print ('navigating to main site')
remDrv$navigate('https://covidwarriors.gov.in/')

print ('selecting all india')
remDrv$findElement(using = "xpath", "//select[@name = 'ddlstate']/option[@value = '-1']")$clickElement()

print ('reading page content')
india_covidwarriors <- read_html(remDrv$getPageSource()[[1]])

#navigate the covidwarriors site, select state as UP and then scrap the summary of covid warriors at UP level.
print ('navigating to main site')
remDrv$navigate('https://covidwarriors.gov.in/')

#select state as UP
print ('selecting state')
remDrv$findElement(using = "xpath", "//select[@name = 'ddlstate']/option[@value = '9']")$clickElement()

print ('reading page content')
up_covidwarriors <- read_html(remDrv$getPageSource()[[1]])

extract_covid_warriors_summary <- function (pagecontent) {
  
  #read all tables
  warriors <- c()
  warriors_count <- c()
  
  for (i in (1:30)){
    label_xpath = sprintf("/html/body/form/div[3]/section/div/div[2]/div/div[3]/div[%s]/div/a/div/b", i)
    label_value_xpath = sprintf("/html/body/form/div[3]/section/div/div[2]/div/div[3]/div[%s]/div/div/div/a[2]", i)
    
    label     <- pagecontent %>% html_nodes(xpath=label_xpath) %>% html_text()
    label_value <- pagecontent %>% html_nodes(xpath=label_value_xpath) %>% html_text()
    
    label<-trimws(label)
    label_value<-trimws(label_value)
    
    warriors<-append(warriors, label)
    warriors_count<-append(warriors_count, label_value)
  }
  outputs <- list(warriors, warriors_count)
}

india_outputs <- extract_covid_warriors_summary(india_covidwarriors)
warriors <- india_outputs[[1]]
india_warriors_count <- india_outputs[[2]]

up_outputs <- extract_covid_warriors_summary(up_covidwarriors)
warriors <- up_outputs[[1]]
up_warriors_count <- up_outputs[[2]]

covid_warriors_df <- data.frame(warriors, india_warriors_count, up_warriors_count)
head(covid_warriors_df)

#write to file
print ('writing topic content to file')
write.csv(covid_warriors_df, 'CovidWarriorsSummary.csv')

remDrv$quit()
remDrv$closeServer()

# stop the selenium server
rD[["server"]]$stop()
