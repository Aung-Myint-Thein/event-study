get.returns <- function(return.ws, country, base.date, boundry.days){
  
  if(country=="Brazil"){
    country.return <- readWorksheet(return.ws, sheet=3, region="A1:E5001", header=T)
  }
  
  upper.boundry <- base.date + (24*60*60)*boundry.days
  lower.boundry <- base.date - (24*60*60)*boundry.days
  
  result <- country.return[upper.boundry >= country.return$Date & country.return$Date >= lower.boundry ,]
  
  return(result)
}