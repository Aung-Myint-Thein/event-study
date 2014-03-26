## function to get the match return with winner and loser with boundry days range
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
  
  return(match.return)
}


## function to get the match return with winner and loser with boundry days range
## but this function will write to csv file
## you just need to adjust the boundry.days variable in script.R
get.match.return.file <- function(winner, loser, date, stage, boundry.days){
  
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

## function to get given country's results in 10 days range with all the match days
## to adjust days, change line 85.
get.country.return <- function(team){
  sheet <- fifa.result[0,]
  
  for(i in 1:nrow(fifa.result)){ 
    match <- fifa.result[i,]
    
    return.from.match <- fifa.result[0,]
    result <- fifa.result[0,]
    
    if(team == match[, "Winner"] || team == match[,"Loser"])
      return.from.match <- get.match.return(match[,"Winner"], match[,"Loser"], match[,"Date"], match[,"Stage"], 10)
    
    if(nrow(return.from.match) > 0){
      if(team == match[, "Winner"]){
        
        result <- return.from.match[, c(1, 2)]
        result[, "Win"] <- 1
        
      }else if(team == match[,"Loser"]){
        
        result <- return.from.match[, c(1, 3)]
        result[, "Win"] <- 0
        
      }
    }
    
    result <- result[complete.cases(result),]
    
    if(nrow(result) > 0){
      
      colnames(result)[2] <- "Closing.price"
      
      for(j in 2:nrow(result)){
        if(!is.na(result[j,2]) & !is.na(result[j-1,2])){
          result[j, "Log.return"] <- log(result[j,2]/result[j-1,2])
        }
      } 
      
      result[, "Goal.diff"] <- as.numeric(match[, "Winner.Score"]) - as.numeric(match[, "Loser.Score"])
      result[, "Game.type"] <- match[, "Stage"]
      result[, "No.of.days.away"] <- as.numeric(difftime(result[,"Date"], match[, "Date"], units="days"))
      
      result <- result[, c(4,3,5:7,1)]
      
      if(nrow(sheet) == 0){
        sheet <- result
      }else{
        datediff <- setdiff(result$Date, sheet$Date)
        result <- result[result$Date >= min(datediff),]
        sheet <- rbind(sheet, result)
      }
    }
      
    rm(result, return.from.match)
  }
  
  sheet <- sheet[order(sheet$Date),]
  return(sheet)
}





