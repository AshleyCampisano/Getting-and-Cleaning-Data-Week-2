#Getting and Cleaning Data Week 2 - Reading from MySQL
library("RMySQL")

ucscDb <- dbConnect(MySQL(), user = "genome",
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);

hg19 <- dbConnect(MySQL(), user="genome", db="hg19", 
                   host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)

#Get dimensions of a specific table
dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

#Read from the table

affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

#select a specific subset

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatch)

affyMisSmall <- fetch(query, n=10); dbClearResult(query);
dim(affyMisSmall)
dbDisconnect(hg19)


#Read from HDF5
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(BiocInstaller)

#create groups
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")

#write to groups
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")
B = array(seq(.1, 2.0, by =.1), dim=c(5,2,2))
attr()

#Reading from the web

con = url("http://scholar.google.com/citations?user=HI-I6CAAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

#Parsing with XML
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

#Get from the httr package

install.packages("httr")
library(httr)
html2 = GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

#Using handles
google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg2 = GET(handle=google, path="search")

#Reading from APIs

# API = application programming interface

#Accessing Twitter from R

myapp = oauth_app("twitter"
                  , key="yourConsumerKeyhere", secret = "yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = : "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twiter.com/1.1/statuses/home")

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]


#Reading from other sources




