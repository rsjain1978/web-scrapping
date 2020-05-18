#load libraries
#install.packages('rvest')
#install.packages('htmltools')
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

#######################CPSE Hospitals#######################

#navigate the covidwarriors site - wait for 10 sec
print ('navigating to main site')
remDrv$navigate('https://covidwarriors.gov.in/')

#select state as UP - wait for 10 sec
print ('selecting state')
remDrv$findElement(using = "xpath", "//select[@name = 'ddlstate']/option[@value = '9']")$clickElement()

#select Hospitals link - wait for 10 sec
print ('clicking hospitals link')
remDrv$findElement(using = "link text", 'Hospitals')$clickElement()

#select topic link - wait for 10 sec
print ('clicking to topic link')
remDrv$findElement(using = "link text", 'CPSE Hospitals')$clickElement()

#read html and extract table
print ('reading page content')
hospital <- read_html(remDrv$getPageSource()[[1]])

#read all tables
tab <- html_nodes(hospital, "table")
hospital_table = html_table(tab[[3]], fill = TRUE)

#write to file
print ('writing topic content to file')
write.csv(hospital_table, 'UP_CPSE_Hospitals.csv')

#######################Railway Hospitals#######################

#open connection
#remDrv$open()

#navigate the covidwarriors site - wait for 10 sec
print ('navigating to main site')
remDrv$navigate('https://covidwarriors.gov.in/')

#select state as UP - wait for 10 sec
print ('selecting state')
remDrv$findElement(using = "xpath", "//select[@name = 'ddlstate']/option[@value = '9']")$clickElement()

#select Hospitals link - wait for 10 sec
print ('clicking hospitals link')
remDrv$findElement(using = "link text", 'Hospitals')$clickElement()

#select topic link - wait for 10 sec
print ('clicking to topic link')
remDrv$findElement(using = "link text", 'Railway Hospitals')$clickElement()

#read html and extract table
print ('reading page content')
hospital <- read_html(remDrv$getPageSource()[[1]])

#read all tables
tab <- html_nodes(hospital, "table")
hospital_table = html_table(tab[[3]], fill = TRUE)

#write to file
print ('writing topic content to file')
write.csv(hospital_table, 'UP_Railway_Hospitals.csv')

#######################ESI Hospitals#######################

#open connection
#remDrv$open()

#navigate the covidwarriors site - wait for 10 sec
print ('navigating to main site')
remDrv$navigate('https://covidwarriors.gov.in/')

#select state as UP - wait for 10 sec
print ('selecting state')
remDrv$findElement(using = "xpath", "//select[@name = 'ddlstate']/option[@value = '9']")$clickElement()

#select Hospitals link - wait for 10 sec
print ('clicking hospitals link')
remDrv$findElement(using = "link text", 'Hospitals')$clickElement()

#select topic link - wait for 10 sec
print ('clicking to topic link')
remDrv$findElement(using = "link text", 'ESI Hospitals')$clickElement()

#read html and extract table
print ('reading page content')
hospital <- read_html(remDrv$getPageSource()[[1]])

#read all tables
tab <- html_nodes(hospital, "table")
hospital_table = html_table(tab[[3]], fill = TRUE)

#write to file
print ('writing topic content to file')
write.csv(hospital_table, 'UP_ESI_Hospitals.csv')

#######################Defence Hospitals#######################

#open connection
#remDrv$open()

#navigate the covidwarriors site - wait for 10 sec
print ('navigating to main site')
remDrv$navigate('https://covidwarriors.gov.in/')

#select state as UP - wait for 10 sec
print ('selecting state')
remDrv$findElement(using = "xpath", "//select[@name = 'ddlstate']/option[@value = '9']")$clickElement()

#select Hospitals link - wait for 10 sec
print ('clicking hospitals link')
remDrv$findElement(using = "link text", 'Hospitals')$clickElement()

#select topic link - wait for 10 sec
print ('clicking to topic link')
remDrv$findElement(using = "link text", 'Defence Hospitals')$clickElement()

#read html and extract table
print ('reading page content')
hospital <- read_html(remDrv$getPageSource()[[1]])

#read all tables
tab <- html_nodes(hospital, "table")
hospital_table = html_table(tab[[3]], fill = TRUE)

#write to file
print ('writing topic content to file')
write.csv(hospital_table, 'UP_Defence_Hospitals.csv')

remDrv$quit()
remDrv$closeServer()

# stop the selenium server
rD[["server"]]$stop()
