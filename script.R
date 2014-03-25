#nstall.packages("XLConnect")
library (XLConnect)
library(seqinr)

source("data import.R")
source("functions.R")

for(i in 1:nrow(fifa.result)){
#for(i in 1:16){  
  match <- fifa.result[i,]
  get.match.return(match[,"Winner"], match[,"Loser"], match[,"Date"], match[,"Stage"], 10)
}



############### second version start here

filename <- "Log returns by country.xlsx"

wb <- loadWorkbook(filename, create = TRUE)

for(i in 1:length(teams)){
  team <- teams[i]
  country.return <- get.country.return(team)
  
  if(nrow(country.return) > 0){
    country.return[, "Date"] <- as.character(format(country.return[, "Date"], "%d/%m/%Y"))
    
    sheetname <- team
    data.to.write <- country.return
    
    
    createSheet(wb, name = sheetname)
    writeWorksheet(wb, data.to.write, sheet = sheetname)
  }
}

saveWorkbook(wb)

################ end here

















###################################### testng scripts 

all.return <- loadWorkbook("data/All Returns.xlsx")

fifa        <- loadWorkbook("data/FIFA outcomes.xlsx")
fifa.result <- readWorksheet(fifa, sheet="Data", region="A1:F133", header=T)

fifa.result[, 2:3] <- lapply(fifa.result[, 2:3], function(x) gsub(" ", ".", trimSpace(tolower(x))))

winning <- unique(fifa.result[, 2])
losing  <- unique(fifa.result[, 3])
teams <- unique(c(winning, losing))

sort(setdiff(teams, ls()))
sort(setdiff(ls(), teams))

years <- sort(unique(as.numeric(format(fifa.result[,"Date"], "%Y"))), decreasing=F)

## to format the data for saving csv file
format(min(germany[,1]), "%Y %m %d")

## to call the object from string
eval(parse(text=paste("df$", x, sep = "")))

brazil.return <- get.returns(return.ws=all.return, 
                             country=fifa.result[14,"Winner"],
                             base.date=fifa.result[14,"Date"], 
                             boundry.days=10)

brazil <- loadWorkbook("data/brazil.xlsx")
brazil <- readWorksheet(brazil, sheet=1, region="A1:E5001", header=T)

germany <- loadWorkbook("data/germany.xlsx")
germany <- readWorksheet(germany, sheet=1, header=T)


brazil.winning.dates <- fifa.result[fifa.result[,2] == "Brazil", "Date"]
brazil.losing.dates  <- fifa.result[fifa.result[,3] == "Brazil", "Date"]

brazil.playing.dates <- sort(c(brazil.winning.dates, brazil.losing.dates), decreasing=F)

brazil.return <- 0
boundry.days  <- 10
country.return <- brazil

for(i in 1:length(brazil.playing.dates)){
  base.date <- brazil.playing.dates[i]
  
  upper.boundry <- base.date + (24*60*60)*boundry.days
  lower.boundry <- base.date - (24*60*60)*boundry.days
  
  result <- country.return[upper.boundry >= country.return$Date & country.return$Date >= lower.boundry ,]
  
  if(i == 1){
    brazil.return <- result
  }else{
    brazil.return <- rbind(brazil.return, result)
  }
}

## order the brazil returns and remove the duplicates
brazil.return <- brazil.return[order(brazil.return$Date, decreasing=F),]
brazil.return <- brazil.return[!duplicated(brazil.return$Date),]

## writing csv file
write.csv(brazil.return, "brazil returns.csv", row.names=FALSE, na="")

## get only 2002 data for testing
brazil.2002 <- brazil.return[as.numeric(format(brazil.return[,"Date"], "%Y"))==2002, ]

## plot to test
plot(brazil.2002$Close, type="l", xaxt="n")
axis(1, at=1:nrow(brazil.2002), labels=brazil.2002[,"Date"])


## check this potion till write to csv

sample.final.date <- fifa.result[14,"Date"]

upper.boundry <- sample.final.date + (24*60*60)*boundry.days
lower.boundry <- sample.final.date - (24*60*60)*boundry.days

germany.result <- germany[upper.boundry >= germany$Date & germany$Date >= lower.boundry ,]
brazil.result  <- brazil[upper.boundry >= brazil$Date & brazil$Date >= lower.boundry ,]

final.2002 <- merge(brazil.result, germany.result, by="Date", all=TRUE, sort=TRUE)

## writing csv file
write.csv(final.2002, "2002 final returns.csv", row.names=FALSE, na="")

## plot to test


brazil <- loadWorkbook("data/All Returns copy 2.xlsx")
brazil <- readWorksheet(brazil, sheet=1, header=T)
class(brazil[,1])

match <- fifa.result[16,]
get.match.return(match[,2], match[,3], match[,6], match[,1], 10)


filename <- "myWorkbook.xlsx"
sheetname <- "data1"
data.to.write <- germany

wb <- loadWorkbook(filename, create = TRUE)
createSheet(wb, name = sheetname)
writeWorksheet(wb, data.to.write, sheet = sheetname)

createSheet(wb, name = "data2")
writeWorksheet(wb, romania, sheet = "data2")


saveWorkbook(wb)
