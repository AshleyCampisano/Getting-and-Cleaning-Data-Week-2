##Getting and Cleaning Data Week 2 - Quiz

#2
install.packages("sqldf")
library(sqldf)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
file <- file.path(getwd(), "ss06pid.csv")
download.file(url,file)
acs <- data.table :: data.table(read.csv(file))

sqldf("select * from acs where AGEP < 50")
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select * from acs")


#3
unique(acs$AGEP)
# sqldf("select distinct AGEP from ACS")

#4
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)
head(htmlCode)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

#5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url, n=10)
head(lines)

col <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
              "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
              "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
df <- read.fwf(url, col, header=FALSE, skip = 4)
df <- df[, grep("^[^filler]", names(df))]
sum(df[, 4])

