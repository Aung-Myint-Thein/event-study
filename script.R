#nstall.packages("XLConnect")
library (XLConnect)
source("functions.R")

all.return <- loadWorkbook("data/All Returns.xlsx")
fifa       <- loadWorkbook("data/FIFA outcomes.xlsx")


fifa.result   <- readWorksheet(fifa, sheet=1, region="B72:F87", header=F)
colnames(fifa.result) <- c("Winner", "Runner.Up", "Winner.score", "Runner.Up.score", "Date")

brazil.return <- get.returns(return.ws=all.return, 
                             country=fifa.result[14,"Winner"],
                             base.date=fifa.result[14,"Date"], 
                             boundry.days=10)

