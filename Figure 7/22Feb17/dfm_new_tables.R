################################################
################################################
# Code to plot data, run unique summary functions
# Nov 2017 Experiment
# 66 flies 5% sucrose, 66 flies 20% sucrose diets; all wild-type
# K. Hoffman
################################################
################################################


library(dplyr)
library(tidyr)
library(reshape2)
library(ggplot2)
library(survival)
source("TidyPlotFunctions.R")
source("SummaryFunctions.R")

##########################
#### Upload/Tidy Files ###
##########################

# excel files from a full experiment
nov17_20p <- read.csv("Nov17_20p.csv",header = T)
nov17_5p <- read.csv("Nov17_5p.csv",header = T)

### Sourced from TidyPlotFunctions.R ###

tidy_nov17_20p <- removeDeadEscaped(nov17_20p, 20, NA, 0) # pathway=NA because all of these flies are wild type
tidy_nov17_5p <- removeDeadEscaped(nov17_5p, 5, NA, 0) #returns data in long format
nov17_all <- rbind(tidy_nov17_5p, tidy_nov17_20p) #entire experiment


##########################
## Make Summary Tables ###
##########################

### Sourced from SummaryFunctions.R ###
### These help find/quantify patterns in the feeding behavior
### More details available in source code comments

# Maxima Summary tables - find the peak mealtime for breakfast and lunch
maxes_64f <- findMaximas(makeDeadNA(all_64f, sucrose=20, pathway="Gr64f-GAL4/+"))
maxes_OR <- findMaximas(makeDeadNA(all_OR, sucrose=20, pathway="UAS-OGTRNAi/+"))
maxes_64fOR <- findMaximas(makeDeadNA(all_64fOR, sucrose=20, "Gr64f>OGTRNAi"))

# maxes_5p <- findMaximas(makeDeadNA(nov17_5p, 5))
# maxes_20p <- findMaximas(makeDeadNA(nov17_20p, 20))

setwd(".."); dir.create("Tables"); setwd("./Tables")

# Saving results to excel files so phd students can access/use
# write.csv(maxes_20p$BreakfastMaxTimes, "breakfast_20p_maxtimes.csv")
# write.csv(maxes_5p$BreakfastMaxTimes, "breakfast_5p_maxtimes.csv")
# write.csv(maxes_20p$DinnerMaxTimes, "dinner_20p_maxtimes.csv")
# write.csv(maxes_5p$DinnerMaxTimes, "dinner_5p_maxtimes.csv")

write.csv(maxes_64f$DinnerMaxTimes, "dinner_64f_maxtimes.csv")
write.csv(maxes_OR$DinnerMaxTimes, "dinner_OR_maxtimes.csv")
write.csv(maxes_64fOR$DinnerMaxTimes, "dinner_64fOR_maxtimes.csv")
write.csv(maxes_64f$BreakfastMaxTimes, "breakfast_64f_maxtimes.csv")
write.csv(maxes_OR$BreakfastMaxTimes, "breakfast_OR_maxtimes.csv")
write.csv(maxes_64fOR$BreakfastMaxTimes, "breakfast_64fOR_maxtimes.csv")


# Minima Summary tables - find the end of the mealtime after the peak mealtime
# end_breakfast_20p <- findMinimas(maxes_20p$BreakfastMaxIndices, maxes_20p$df1)
# end_dinner_20p <- findMinimas(maxes_20p$DinnerMaxIndices, maxes_20p$df1)
# end_breakfast_5p <- findMinimas(maxes_5p$BreakfastMaxIndices, maxes_5p$df1)
# end_dinner_5p <- findMinimas(maxes_5p$DinnerMaxIndices, maxes_5p$df1)

end_breakfast_64f <- findMinimas(maxes_64f$BreakfastMaxIndices, maxes_64f$df1)
end_breakfast_OR <- findMinimas(maxes_OR$BreakfastMaxIndices, maxes_OR$df1)
end_breakfast_64fOR <- findMinimas(maxes_64fOR$BreakfastMaxIndices, maxes_64fOR$df1)
end_dinner_64f <- findDinnerEnd(maxes_64f$DinnerMaxIndices, maxes_64f$df1)
end_dinner_OR <- findDinnerEnd(maxes_OR$DinnerMaxIndices, maxes_OR$df1)
end_dinner_64fOR <- findDinnerEnd(maxes_64fOR$DinnerMaxIndices, maxes_64fOR$df1)
#add 24 hours to any of the times that occur the next day (so 1:00am = "25:00")
#need to do this so we don't artificially pull down the mean dinner meal time end
# end_dinner_20p[!is.na(end_dinner_20p) & end_dinner_20p <= 12] <- end_dinner_20p[!is.na(end_dinner_20p) & end_dinner_20p <= 12] +24
# end_dinner_5p[!is.na(end_dinner_5p) & end_dinner_5p <= 12] <- end_dinner_5p[!is.na(end_dinner_5p) & end_dinner_5p <= 12] +24

# Saving so phd students can access/use
write.table(end_breakfast_64f, "breakfast_64f_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_64f))), col.names = paste("Fly",c(1:ncol(end_breakfast_64f))))
write.table(end_dinner_64f, "dinner_64f_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_64f))), col.names=paste("Fly",c(1:ncol(end_dinner_64f))))
write.table(end_breakfast_OR, "breakfast_OR_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_OR))), col.names=paste("Fly",c(1:ncol(end_breakfast_OR))))
write.table(end_dinner_OR, "dinner_OR_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_OR))), col.names=paste("Fly",c(1:ncol(end_dinner_OR))))
write.table(end_breakfast_64fOR, "breakfast_64fOR_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_64fOR))), col.names=paste("Fly",c(1:ncol(end_breakfast_64fOR))))
write.table(end_dinner_64fOR, "dinner_64fOR_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_64fOR))), col.names=paste("Fly",c(1:ncol(end_dinner_64fOR))))



# start_breakfast_20p <- findMinimasBefore(maxes_20p$BreakfastMaxIndices, maxes_20p$df1)
# start_dinner_20p <- findMinimasBefore(maxes_20p$DinnerMaxIndices, maxes_20p$df1)
# start_breakfast_5p <- findMinimasBefore(maxes_5p$BreakfastMaxIndices, maxes_5p$df1)
# start_dinner_5p <- findMinimasBefore(maxes_5p$DinnerMaxIndices, maxes_5p$df1)

start_breakfast_64f <- findBreakfastStart(maxes_64f$BreakfastMaxIndices, maxes_64f$df1)
start_breakfast_OR <- findBreakfastStart(maxes_OR$BreakfastMaxIndices, maxes_OR$df1)
start_breakfast_64fOR <- findBreakfastStart(maxes_64fOR$BreakfastMaxIndices, maxes_64fOR$df1)
start_dinner_64f <- findMinimasBefore(maxes_64f$DinnerMaxIndices, maxes_64f$df1)
start_dinner_OR <- findMinimasBefore(maxes_OR$DinnerMaxIndices, maxes_OR$df1)
start_dinner_64fOR <- findMinimasBefore(maxes_64fOR$DinnerMaxIndices, maxes_64fOR$df1)

#add 24 hours to any of the times that occur the next day (so 1:00am = "25:00")
#need to do this so we don't artificially pull down the mean dinner meal time end
# mins_breakfast_20p[!is.na(mins_breakfast_20p) & mins_breakfast_20p > 19] <- mins_breakfast_20p[!is.na(mins_breakfast_20p) & mins_breakfast_20p > 19] - 24
# mins_breakfast_5p[!is.na(mins_breakfast_5p) & mins_breakfast_5p > 19] <- mins_breakfast_5p[!is.na(mins_breakfast_5p) & mins_breakfast_5p > 19] - 24
# mins_dinner_20p[!is.na(mins_dinner_20p) & mins_dinner_20p <= 7] <- mins_dinner_20p[!is.na(mins_dinner_20p) & mins_dinner_20p <= 7] + 24
# mins_dinner_5p[!is.na(mins_dinner_5p) & mins_dinner_5p <= 7] <- mins_dinner_5p[!is.na(mins_dinner_5p) & mins_dinner_5p <= 7] + 24

# write.table(start_breakfast_20p, "breakfast_20p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_20p))), col.names = paste("Fly",c(1:66)))
# write.table(start_breakfast_5p, "breakfast_5p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_5p))), col.names=paste("Fly",c(1:66)))
# write.table(start_dinner_20p[,-1], "dinner_20p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_20p))), col.names=paste("Fly",c(1:66)))
# write.table(start_dinner_5p[,-1], "dinner_5p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_5p))), col.names=paste("Fly",c(1:66)))

write.table(start_breakfast_64f, "breakfast_64f_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_64f))), col.names = paste("Fly",c(1:ncol(start_breakfast_64f))))
write.table(start_dinner_64f, "dinner_64f_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_64f))), col.names=paste("Fly",c(1:ncol(start_dinner_64f))))
write.table(start_breakfast_OR, "breakfast_OR_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_OR))), col.names=paste("Fly",c(1:ncol(start_breakfast_OR))))
write.table(start_dinner_OR, "dinner_OR_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_OR))), col.names=paste("Fly",c(1:ncol(start_dinner_OR))))
write.table(start_breakfast_64fOR, "breakfast_64fOR_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_64fOR))), col.names=paste("Fly",c(1:ncol(start_breakfast_64fOR))))
write.table(start_dinner_64fOR, "dinner_64fOR_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_64fOR))), col.names=paste("Fly",c(1:ncol(start_dinner_64fOR))))

# dur_breakfast_20p <- end_breakfast_20p - end_dinner_20p


#BROKEN CODE--------------------------
dim(start_breakfast_20p)
dim(end_breakfast_20p)
dur_breakfast_20p <- data.frame(matrix(NA, nrow=10, ncol=66))

for (i in nrow(start_breakfast_20p)){
  for (j in ncol(start_breakfast_20p)){
    dur_breakfast_20p[i,j] <- ifelse((end_breakfast_20p[i,j] - start_breakfast_20p[i,j]) > 0, 
                                     end_breakfast_20p[i,j] - start_breakfast_20p[i,j],
                                     start_breakfast_20p[i,j] - 24 + end_breakfast_20p[i,j])
  }
}

dur_breakfast_20p <- ifelse((end_breakfast_20p - start_breakfast_20p) > 0, 
                            end_breakfast_20p - start_breakfast_20p,
                            start_breakfast_20p - 24 + end_breakfast_20p)
View(dur_breakfast_20p)



