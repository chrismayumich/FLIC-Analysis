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
# nov17_20p <- read.csv("Nov17_20p.csv",header = T)
# nov17_5p <- read.csv("Nov17_5p.csv",header = T)

W1118_5p<-read.csv("20Jun, 20Oct, 02Nov 5p.csv",header = T)
W1118_20p<-read.csv("20Jun, 20Oct, 02Nov 20p.csv",header = T) 

plin2_5p<-read.csv("plin2_5p.csv",header = T)
plin2_20p<-read.csv("plin2_20p.csv",header = T)
bmm_5p<-read.csv("bmm_5p.csv",header = T)
bmm_20p<-read.csv("bmm_20p.csv",header = T)

### Sourced from TidyPlotFunctions.R ###

# tidy_nov17_20p <- removeDeadEscaped(nov17_20p, 20, NA, 0) # pathway=NA because all of these flies are wild type
# tidy_nov17_5p <- removeDeadEscaped(nov17_5p, 5, NA, 0) #returns data in long format
# nov17_all <- rbind(tidy_nov17_5p, tidy_nov17_20p) #entire experiment

tidy_bmm_5p <- removeDeadEscaped(bmm_5p, 5, "brummer-/-", 2)
tidy_bmm_20p <- removeDeadEscaped(bmm_20p, 20, "brummer-/-", 2)
tidy_plin2_5p <- removeDeadEscaped(plin2_5p, 5, "perilipin2-/-", 2)
tidy_plin2_20p <- removeDeadEscaped(plin2_20p, 20, "perilipin2-/-", 2)
tidy_all <- rbind(tidy_bmm_5p,tidy_bmm_20p,tidy_plin2_5p,tidy_plin2_20p)

##########################
## Make Summary Tables ###
##########################

### Sourced from SummaryFunctions.R ###
### These help find/quantify patterns in the feeding behavior
### More details available in source code comments

# Maxima Summary tables - find the peak mealtime for breakfast and lunch
# maxes_20p <- findMaximas(makeDeadNA(nov17_20p, 20))
# maxes_5p <- findMaximas(makeDeadNA(nov17_5p, 5))

maxes_W1118_5p <- findMaximas(makeDeadNA(W1118_5p, 5))
maxes_W1118_20p <- findMaximas(makeDeadNA(W1118_20p, 20))

maxes_bmm_5p <- findMaximas(makeDeadNA(bmm_5p, 5))
maxes_bmm_20p <- findMaximas(makeDeadNA(bmm_20p, 20))
maxes_plin2_5p <- findMaximas(makeDeadNA(plin2_5p, 5))
maxes_plin2_20p <- findMaximas(makeDeadNA(plin2_20p, 20))

setwd(".."); dir.create("20Jun, 20Oct, 02Nov 5v20"); setwd("./20Jun, 20Oct, 02Nov 5v20")

# Saving results to excel files so phd students can access/use
# write.csv(maxes_20p$BreakfastMaxTimes, "breakfast_20p_maxtimes.csv")
# write.csv(maxes_5p$BreakfastMaxTimes, "breakfast_5p_maxtimes.csv")
# write.csv(maxes_20p$DinnerMaxTimes, "dinner_20p_maxtimes.csv")
# write.csv(maxes_5p$DinnerMaxTimes, "dinner_5p_maxtimes.csv")

write.csv(maxes_W1118_5p$BreakfastMaxTimes, "breakfast_W1118_5p_maxes.csv")
write.csv(maxes_W1118_20p$BreakfastMaxTimes, "breakfast_W1118_20p_maxes.csv")
write.csv(maxes_W1118_5p$DinnerMaxTimes, "dinner_W1118_5p_maxes.csv")
write.csv(maxes_W1118_20p$DinnerMaxTimes, "dinner_W1118_20p_maxes.csv")

write.csv(maxes_bmm_5p$BreakfastMaxTimes, "breakfast_bmm_5p_maxes.csv")
write.csv(maxes_bmm_20p$BreakfastMaxTimes, "breakfast_bmm_20p_maxes.csv")
write.csv(maxes_plin2_5p$BreakfastMaxTimes, "breakfast_plin2_5p_maxes.csv")
write.csv(maxes_plin2_20p$BreakfastMaxTimes, "breakfast_plin2_20p_maxes.csv")
write.csv(maxes_bmm_5p$DinnerMaxTimes, "dinner_bmm_5p_maxes.csv")
write.csv(maxes_bmm_20p$DinnerMaxTimes, "dinner_bmm_20p_maxes.csv")
write.csv(maxes_plin2_5p$DinnerMaxTimes, "dinner_plin2_5p_maxes.csv")
write.csv(maxes_plin2_20p$DinnerMaxTimes, "dinner_plin2_20p_maxes.csv")

# Minima Summary tables - find the end of the mealtime after the peak mealtime
# end_breakfast_20p <- findMinimas(maxes_20p$BreakfastMaxIndices, maxes_20p$df1)
# end_dinner_20p <- findMinimas(maxes_20p$DinnerMaxIndices, maxes_20p$df1)
# end_breakfast_5p <- findMinimas(maxes_5p$BreakfastMaxIndices, maxes_5p$df1)
# end_dinner_5p <- findMinimas(maxes_5p$DinnerMaxIndices, maxes_5p$df1)

end_breakfast_W1118_5p <- findMinimas(maxes_W1118_5p$BreakfastMaxIndices, maxes_W1118_5p$df1)
end_breakfast_W1118_20p <- findMinimas(maxes_W1118_20p$BreakfastMaxIndices, maxes_W1118_20p$df1)

end_breakfast_bmm_5p <- findMinimas(maxes_bmm_5p$BreakfastMaxIndices, maxes_bmm_5p$df1)
end_breakfast_bmm_20p <- findMinimas(maxes_bmm_20p$BreakfastMaxIndices, maxes_bmm_20p$df1)
end_breakfast_plin2_5p <- findMinimas(maxes_plin2_5p$BreakfastMaxIndices, maxes_plin2_5p$df1)
end_breakfast_plin2_20p <- findMinimas(maxes_plin2_20p$BreakfastMaxIndices, maxes_plin2_20p$df1)

end_dinner_W1118_5p <- findMinimas(maxes_W1118_5p$DinnerMaxIndices, maxes_W1118_5p$df1)
end_dinner_W1118_20p <- findMinimas(maxes_W1118_20p$DinnerMaxIndices, maxes_W1118_20p$df1)

end_dinner_bmm_5p <- findMinimas(maxes_bmm_5p$DinnerMaxIndices, maxes_bmm_5p$df1)
end_dinner_bmm_20p <- findMinimas(maxes_bmm_20p$DinnerMaxIndices, maxes_bmm_20p$df1)
end_dinner_plin2_5p <- findMinimas(maxes_plin2_5p$DinnerMaxIndices, maxes_plin2_5p$df1)
end_dinner_plin2_20p <- findMinimas(maxes_plin2_20p$DinnerMaxIndices, maxes_plin2_20p$df1)

#add 24 hours to any of the times that occur the next day (so 1:00am = "25:00")
#need to do this so we don't artificially pull down the mean dinner meal time end
# end_dinner_20p[!is.na(end_dinner_20p) & end_dinner_20p <= 12] <- end_dinner_20p[!is.na(end_dinner_20p) & end_dinner_20p <= 12] +24
# end_dinner_5p[!is.na(end_dinner_5p) & end_dinner_5p <= 12] <- end_dinner_5p[!is.na(end_dinner_5p) & end_dinner_5p <= 12] +24

# Saving so phd students can access/use
# write.table(end_breakfast_20p, "breakfast_20p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_20p))), col.names = paste("Fly",c(1:ncol(end_breakfast_20p))))
# write.table(end_breakfast_5p, "breakfast_5p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_5p))), col.names=paste("Fly",c(1:ncol(end_breakfast_5p))))
# write.table(end_dinner_20p, "dinner_20p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_20p))), col.names=paste("Fly",c(1:ncol(end_dinner_20p))))
# write.table(end_dinner_5p, "dinner_5p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_5p))), col.names=paste("Fly",c(1:ncol(end_dinner_5p))))

write.table(end_breakfast_W1118_5p, "breakfast_W1118_5p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_W1118_5p))), col.names=paste("Fly",c(1:ncol(end_breakfast_W1118_5p))))
write.table(end_breakfast_W1118_20p, "breakfast_W1118_20p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_W1118_20p))), col.names=paste("Fly",c(1:ncol(end_breakfast_W1118_20p))))

write.table(end_dinner_W1118_5p, "dinner_W1118_5p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_W1118_5p))), col.names=paste("Fly",c(1:ncol(end_dinner_W1118_5p))))
write.table(end_dinner_W1118_20p, "dinner_W1118_20p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_W1118_20p))), col.names=paste("Fly",c(1:ncol(end_dinner_W1118_20p))))

write.table(end_breakfast_bmm_5p, "breakfast_bmm_5p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_bmm_5p))), col.names=paste("Fly",c(1:ncol(end_breakfast_bmm_5p))))
write.table(end_breakfast_bmm_20p, "breakfast_bmm_20p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_bmm_20p))), col.names=paste("Fly",c(1:ncol(end_breakfast_bmm_20p))))
write.table(end_breakfast_plin2_5p, "breakfast_plin2_5p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_plin2_5p))), col.names=paste("Fly",c(1:ncol(end_breakfast_plin2_5p))))
write.table(end_breakfast_plin2_20p, "breakfast_plin2_20p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_breakfast_plin2_20p))), col.names=paste("Fly",c(1:ncol(end_breakfast_plin2_20p))))
write.table(end_dinner_bmm_5p, "dinner_bmm_5p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_bmm_5p))), col.names=paste("Fly",c(1:ncol(end_dinner_bmm_5p))))
write.table(end_dinner_bmm_20p, "dinner_bmm_20p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_bmm_20p))), col.names=paste("Fly",c(1:ncol(end_dinner_bmm_20p))))
write.table(end_dinner_plin2_5p, "dinner_plin2_5p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_plin2_5p))), col.names=paste("Fly",c(1:ncol(end_dinner_plin2_5p))))
write.table(end_dinner_plin2_20p, "dinner_plin2_20p_end.csv", sep=",", row.names = paste("Day", c(1:nrow(end_dinner_plin2_20p))), col.names=paste("Fly",c(1:ncol(end_dinner_plin2_20p))))

# start_breakfast_20p <- findMinimasBefore(maxes_20p$BreakfastMaxIndices, maxes_20p$df1)
# start_dinner_20p <- findMinimasBefore(maxes_20p$DinnerMaxIndices, maxes_20p$df1)
# start_breakfast_5p <- findMinimasBefore(maxes_5p$BreakfastMaxIndices, maxes_5p$df1)
# start_dinner_5p <- findMinimasBefore(maxes_5p$DinnerMaxIndices, maxes_5p$df1)

start_breakfast_W1118_5p <- findMinimasBefore(maxes_W1118_5p$BreakfastMaxIndices, maxes_W1118_5p$df1)
start_breakfast_W1118_20p <- findMinimasBefore(maxes_W1118_20p$BreakfastMaxIndices, maxes_W1118_20p$df1)

start_breakfast_bmm_5p <- findMinimasBefore(maxes_bmm_5p$BreakfastMaxIndices, maxes_bmm_5p$df1)
start_breakfast_bmm_20p <- findMinimasBefore(maxes_bmm_20p$BreakfastMaxIndices, maxes_bmm_20p$df1)
start_breakfast_plin2_5p <- findMinimasBefore(maxes_plin2_5p$BreakfastMaxIndices, maxes_plin2_5p$df1)
start_breakfast_plin2_20p <- findMinimasBefore(maxes_plin2_20p$BreakfastMaxIndices, maxes_plin2_20p$df1)

start_dinner_W1118_5p <- findMinimasBefore(maxes_W1118_5p$DinnerMaxIndices, maxes_W1118_5p$df1)
start_dinner_W1118_20p <- findMinimasBefore(maxes_W1118_20p$DinnerMaxIndices, maxes_W1118_20p$df1)

start_dinner_bmm_5p <- findMinimasBefore(maxes_bmm_5p$DinnerMaxIndices, maxes_bmm_5p$df1)
start_dinner_bmm_20p <- findMinimasBefore(maxes_bmm_20p$DinnerMaxIndices, maxes_bmm_20p$df1)
start_dinner_plin2_5p <- findMinimasBefore(maxes_plin2_5p$DinnerMaxIndices, maxes_plin2_5p$df1)
start_dinner_plin2_20p <- findMinimasBefore(maxes_plin2_20p$DinnerMaxIndices, maxes_plin2_20p$df1)

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

write.table(start_breakfast_W1118_5p, "breakfast_W1118_5p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_W1118_5p))), col.names=paste("Fly",c(1:ncol(start_breakfast_W1118_5p))))
write.table(start_breakfast_W1118_20p, "breakfast_W1118_20p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_W1118_20p))), col.names=paste("Fly",c(1:ncol(start_breakfast_W1118_20p))))

write.table(start_dinner_W1118_5p, "dinner_W1118_5p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_W1118_5p))), col.names=paste("Fly",c(1:ncol(start_dinner_W1118_5p))))
write.table(start_dinner_W1118_20p, "dinner_W1118_20p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_W1118_20p))), col.names=paste("Fly",c(1:ncol(start_dinner_W1118_20p))))

write.table(start_breakfast_bmm_5p, "breakfast_bmm_5p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_bmm_5p))), col.names=paste("Fly",c(1:ncol(start_breakfast_bmm_5p))))
write.table(start_breakfast_bmm_20p, "breakfast_bmm_20p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_bmm_20p))), col.names=paste("Fly",c(1:ncol(start_breakfast_bmm_20p))))
write.table(start_breakfast_plin2_5p, "breakfast_plin2_5p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_plin2_5p))), col.names=paste("Fly",c(1:ncol(start_breakfast_plin2_5p))))
write.table(start_breakfast_plin2_20p, "breakfast_plin2_20p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_breakfast_plin2_20p))), col.names=paste("Fly",c(1:ncol(start_breakfast_plin2_20p))))
write.table(start_dinner_bmm_5p, "dinner_bmm_5p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_bmm_5p))), col.names=paste("Fly",c(1:ncol(start_dinner_bmm_5p))))
write.table(start_dinner_bmm_20p, "dinner_bmm_20p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_bmm_20p))), col.names=paste("Fly",c(1:ncol(start_dinner_bmm_20p))))
write.table(start_dinner_plin2_5p, "dinner_plin2_5p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_plin2_5p))), col.names=paste("Fly",c(1:ncol(start_dinner_plin2_5p))))
write.table(start_dinner_plin2_20p, "dinner_plin2_20p_start.csv", sep=",", row.names = paste("Day", c(1:nrow(start_dinner_plin2_20p))), col.names=paste("Fly",c(1:ncol(start_dinner_plin2_20p))))

# dur_breakfast_20p <- end_breakfast_20p - end_dinner_20p

breakfast_W1118_5p <- FindMealSizes(maxes_W1118_5p$BreakfastMaxTimes,maxes_W1118_5p$df1)
breakfast_W1118_20p <- FindMealSizes(maxes_W1118_20p$BreakfastMaxTimes,maxes_W1118_20p$df1)
dinner_W1118_5p <- FindMealSizes(maxes_W1118_5p$DinnerMaxTimes,maxes_W1118_5p$df1)
dinner_W1118_20p <- FindMealSizes(maxes_W1118_20p$DinnerMaxTimes,maxes_W1118_20p$df1)

breakfast_bmm_5p <- FindMealSizes(maxes_bmm_5p$BreakfastMaxTimes,maxes_bmm_5p$df1)
breakfast_bmm_20p <- FindMealSizes(maxes_bmm_20p$BreakfastMaxTimes,maxes_bmm_20p$df1)
dinner_bmm_5p <- FindMealSizes(maxes_bmm_5p$DinnerMaxTimes,maxes_bmm_5p$df1)
dinner_bmm_20p <- FindMealSizes(maxes_bmm_20p$DinnerMaxTimes,maxes_bmm_20p$df1)

breakfast_plin2_5p <- FindMealSizes(maxes_plin2_5p$BreakfastMaxTimes,maxes_plin2_5p$df1)
breakfast_plin2_20p <- FindMealSizes(maxes_plin2_20p$BreakfastMaxTimes,maxes_plin2_20p$df1)
dinner_plin2_5p <- FindMealSizes(maxes_plin2_5p$DinnerMaxTimes,maxes_plin2_5p$df1)
dinner_plin2_20p <- FindMealSizes(maxes_plin2_20p$DinnerMaxTimes,maxes_plin2_20p$df1)

dir.create("meal size tables"); setwd("./meal size tables")

write.csv(breakfast_W1118_5p, "breakfast_W1118_5p_sizes.csv")
write.csv(breakfast_W1118_20p, "breakfast_W1118_20p_sizes.csv")
write.csv(dinner_W1118_5p, "dinner_W1118_5p_sizes.csv")
write.csv(dinner_W1118_20p, "dinner_W1118_20p_sizes.csv")

write.csv(breakfast_bmm_5p, "breakfast_bmm_5p_sizes.csv")
write.csv(breakfast_bmm_20p, "breakfast_bmm_20p_sizes.csv")
write.csv(dinner_bmm_5p, "dinner_bmm_5p_sizes.csv")
write.csv(dinner_bmm_20p, "dinner_bmm_20p_sizes.csv")

write.csv(breakfast_plin2_5p, "breakfast_plin2_5p_sizes.csv")
write.csv(breakfast_plin2_20p, "breakfast_plin2_20p_sizes.csv")
write.csv(dinner_plin2_5p, "dinner_plin2_5p_sizes.csv")
write.csv(dinner_plin2_20p, "dinner_plin2_20p_sizes.csv")

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



