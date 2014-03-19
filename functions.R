get.returns <- function(return.ws, country, base.date, boundry.days){
  
  if(country=="Brazil"){
    country.return <- readWorksheet(return.ws, sheet=3, region="A1:E5001", header=T)
  }
  
  upper.boundry <- base.date + (24*60*60)*boundry.days
  lower.boundry <- base.date - (24*60*60)*boundry.days
  
  result <- country.return[upper.boundry >= country.return$Date & country.return$Date >= lower.boundry ,]
  
  return(result)
}


get.match.return <- function(winner, loser, date, stage, boundry.days){
  
  upper.boundry <- date + (24*60*60)*boundry.days
  lower.boundry <- date - (24*60*60)*boundry.days
  
  ## to format the data for saving csv file
  format(min(germany[,1]), "%Y %m %d")
  
  if(exists(winner)){
    eval(parse(text=paste("winner.returns <- ", winner, sep = "")))
    winner.match.return <- winner.returns[upper.boundry >= winner.returns$Date & winner.returns$Date >= lower.boundry ,]
  }else{
    winner.match.return <- brazil[0,]
  }
  
  colnames(winner.match.return)[2] <- "winner.closing.price"
  
  if(exists(loser)){
    eval(parse(text=paste("loser.returns <- ", loser, sep = "")))
    loser.match.return <- loser.returns[upper.boundry >= loser.returns$Date & loser.returns$Date >= lower.boundry ,]
  }else{
    loser.match.return <- brazil[0,]
  }
  
  colnames(loser.match.return)[2] <- "loser.closing.price"
  
  match.return <- merge(winner.match.return, loser.match.return, by="Date", all=TRUE, sort=TRUE)
  
  if(nrow(match.return) > 0){
    write.csv(match.return, 
              paste("export/", format(min(date), "%Y %m %d")," ", winner, " vs ", loser, " ", stage, ".csv", sep=""), 
              row.names=FALSE, 
              na="")  
  }
}







