library (XLConnect)
library(seqinr)
rm(list=ls())

ws1       <- loadWorkbook("data/Returns/All Returns copy 2.xlsx")
brazil    <- readWorksheet(ws1, sheet=1, header=T)
germany   <- readWorksheet(ws1, sheet=2, header=T)
argentine <- readWorksheet(ws1, sheet=3, header=T)
mexico    <- readWorksheet(ws1, sheet=4, header=T)
england   <- readWorksheet(ws1, sheet=5, header=T)

brazil    <- brazil[, c(1,5)]
germany   <- germany[, c(1,5)]
argentine <- argentine[, c(1,5)]
mexico    <- mexico[, c(1,5)]
england   <- england[, c(1,5)]

gc()

ws1       <- loadWorkbook("data/Returns/All Returns copy 3.xlsx")
france    <- readWorksheet(ws1, sheet=1, header=T)
spain     <- readWorksheet(ws1, sheet=2, header=T)
belgium   <- readWorksheet(ws1, sheet=3, header=T)
sweden    <- readWorksheet(ws1, sheet=4, header=T)
netherlands<- readWorksheet(ws1, sheet=5, header=T)

france    <- france[, c(1,5)]
spain     <- spain[, c(1,5)]
belgium   <- belgium[, c(1,5)]
sweden    <- sweden[, c(1,5)]
netherlands<- netherlands[, c(1,5)]

gc()

ws1        <- loadWorkbook("data/Returns/All Returns copy 4.xlsx")
switzerland <- readWorksheet(ws1, sheet=1, header=T)
chile       <- readWorksheet(ws1, sheet=2, header=T)
hungary     <- readWorksheet(ws1, sheet=3, header=T)
south.korea <- readWorksheet(ws1, sheet=4, header=T)
austria     <- readWorksheet(ws1, sheet=5, header=T)

switzerland <- switzerland[, c(1,5)]
chile       <- chile[, c(1,5)]
hungary     <- hungary[, c(1,5)]
south.korea <- south.korea[, c(1,5)]
austria     <- austria[, c(1,5)]

gc()

ws1         <- loadWorkbook("data/Returns/All Returns copy 5.xlsx")
bulgaria    <- readWorksheet(ws1, sheet=1, header=T)
poland      <- readWorksheet(ws1, sheet=2, header=T)
romania     <- readWorksheet(ws1, sheet=3, header=T)
portugal    <- readWorksheet(ws1, sheet=4, header=T)

bulgaria    <- bulgaria[, c(1,5)]
poland      <- poland[, c(1,5)]
romania     <- romania[, c(1,5)]
portugal    <- portugal[, c(1,5)]

gc()

ws1        <- loadWorkbook("data/Returns/March 12 returns copy.xlsx")
japan      <- readWorksheet(ws1, sheet=1, header=T)
nigeria    <- readWorksheet(ws1, sheet=2, header=T)
australia  <- readWorksheet(ws1, sheet=3, header=T)
croatia    <- readWorksheet(ws1, sheet=4, header=T)
costa.rica <- readWorksheet(ws1, sheet=5, header=T)

japan      <- japan[, c(1,2)]
nigeria    <- nigeria[, c(1,2)]
australia  <- australia[, c(1,2)]
croatia    <- croatia[, c(1,2)]
costa.rica <- costa.rica[, c(1,2)]

gc()

ws1       <- loadWorkbook("data/Returns/March 12 returns copy 2.xlsx")
denmark   <- readWorksheet(ws1, sheet=1, header=T)
morocco   <- readWorksheet(ws1, sheet=2, header=T)
peru      <- readWorksheet(ws1, sheet=3, header=T)
saudi.arabia <- readWorksheet(ws1, sheet=4, header=T)
tunisia   <- readWorksheet(ws1, sheet=5, header=T)

denmark   <- denmark[, c(1,2)]
morocco   <- morocco[, c(1,2)]
peru      <- peru[, c(1,2)]
saudi.arabia <- saudi.arabia[, c(1,2)]
tunisia   <- tunisia[, c(1,2)]

gc()

ws1       <- loadWorkbook("data/Returns/March 12 returns copy 3.xlsx")
ghana     <- readWorksheet(ws1, sheet=1, header=T)
greece    <- readWorksheet(ws1, sheet=2, header=T)
republic.of.ireland   <- readWorksheet(ws1, sheet=3, header=T)
norway    <- readWorksheet(ws1, sheet=4, header=T)
south.africa <- readWorksheet(ws1, sheet=5, header=T)

ghana    <- ghana[, c(1,2)]
greece   <- greece[, c(1,2)]
republic.of.ireland  <- republic.of.ireland[, c(1,2)]
norway   <- norway[, c(1,2)]
south.africa <- south.africa[, c(1,2)]

gc()

ws1         <- loadWorkbook("data/Returns/March 12 returns copy 4.xlsx")
new.zealand <- readWorksheet(ws1, sheet=1, header=T)
turkey      <- readWorksheet(ws1, sheet=2, header=T)
israel      <- readWorksheet(ws1, sheet=3, header=T)
kuwait      <- readWorksheet(ws1, sheet=4, header=T)
slovakia    <- readWorksheet(ws1, sheet=5, header=T)

new.zealand <- new.zealand[, c(1,2)]
turkey      <- turkey[, c(1,2)]
israel      <- israel[, c(1,2)]
kuwait      <- kuwait[, c(1,2)]
slovakia    <- slovakia[, c(1,2)]


gc()

ws1           <- loadWorkbook("data/Returns/March 12 returns copy 5.xlsx")
ukraine       <- readWorksheet(ws1, sheet=1, header=T)
czech.repulic <- readWorksheet(ws1, sheet=2, header=T)
united.states <- readWorksheet(ws1, sheet=3, header=T)
soviet.union  <- readWorksheet(ws1, sheet=4, header=T)

ukraine       <- ukraine[, c(1,2)]
czech.repulic <- czech.repulic[, c(1,2)]
united.states <- united.states[, c(1,2)]
soviet.union  <- soviet.union[, c(1,2)]

fifa          <- loadWorkbook("data/FIFA outcomes.xlsx")
fifa.result   <- readWorksheet(fifa, sheet="Data", region="A1:F133", header=T)

fifa.result[, 2:3] <- lapply(fifa.result[, 2:3], function(x) gsub(" ", ".", trimSpace(tolower(x))))

winning <- unique(fifa.result[, 2])
losing  <- unique(fifa.result[, 3])
teams <- unique(c(winning, losing))

rm(ws1)
rm(fifa)
