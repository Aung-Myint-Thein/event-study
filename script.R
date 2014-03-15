#nstall.packages("XLConnect")
library (XLConnect)

all.return <- loadWorkbook("data/All Returns.xlsx")


brazil.return <- readWorksheet(all.return, sheet=3, region="A1:E5001", header=T)



base.date <- brazil.return[6,1]
upper.boundry <- brazil.return[6,1] + (24*60*60)*6
lower.boundry <- brazil.return[6,1] - (24*60*60)*6

brazil.return[upper.boundry >= brazil.return$Date & brazil.return$Date >= lower.boundry ,]
