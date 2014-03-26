## need to install these packages to read XLSX
#install.packages("XLConnect")
#install.packages("seqinr")
library (XLConnect)
library(seqinr)

## this line will call "data import.R" file and it will import the necessary data.
source("data import.R")

## this line will load necessary functions
source("functions.R")

############### first version of files

for(i in 1:nrow(fifa.result)){
  match <- fifa.result[i,]
  get.match.return.file(match[,"Winner"], match[,"Loser"], match[,"Date"], match[,"Stage"], 10)
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
