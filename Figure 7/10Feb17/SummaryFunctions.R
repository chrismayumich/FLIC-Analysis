################################################
################################################
# SummaryFunctions.R
# Source to obtain max/min/24 hr summary functions
# K. Hoffman
# Last update 20 Dec 2017
################################################
################################################


##########################
## Finding the maximas ###
##########################

# This function finds the index of the max feeding between midnight and noon (breakfast)
# and noon and midnight (dinner). It assigns the feeding time (a row index) to a vector with a time for each fly
# These vectors are called Seq1 for the first 12 hours, Seq2 for the second 12 hours, etc.
# Each Seq vector is then matched to the actual time that the max occured
# If there are any data breaks (NA) in the 12 hour window, NA is returned
# Every other vector is "breakfast" and "dinner"
# Returns a list of data frames with all the breakfast and dinner max times and their row indices

findMaximas <- function(df) {
  #create sequences to store each maxima in
  seq <- rep(seq(1, 19), each = 24)
  df1 <- as.data.frame(cbind(seq[1:nrow(df)], df))
  colnames(df1)[1] <- "seq"
  temp <- df1[, -match(c("Day", "Time", "Sucrose"), colnames(df1))]
  for (i in 1:19) {
    assign(paste0("Seq", i), apply(subset(temp, seq == i), 2,
                                   function(x) {
                                     #if there are any data breaks return NA
                                     if (anyNA(x)) {
                                       return(NA)
                                     }
                                     else{
                                       index <- which.max(x)
                                       #match the row index with the max value
                                       row <-
                                         as.numeric(names(x)[index])
                                       if (length(row) == 0) {
                                         row = NA
                                       }
                                       #return the index so that we can use to locate mealtime end
                                       return(row)
                                     }
                                   }))
  }
  #these Seq's return the row indices of the max times
  breakfast_seq <- rbind(Seq1, Seq3,
                         Seq5, Seq7, Seq9, Seq11,
                         Seq13, Seq15, Seq17, Seq19)[,-1]
  #make a new matrix to convert to time
  breakfast_times <- matrix(nrow=nrow(breakfast_seq),ncol=(length(Seq1)-1))
  #match the row indices with the actual times they are
  for(j in 1:ncol(breakfast_times)){
    breakfast_times[,j] <- df1$Time[breakfast_seq[,j]]
  }
  rownames(breakfast_times) <- paste("Day",c(1:nrow(breakfast_times)), sep="")
  colnames(breakfast_times) <- paste("Fly",c(1:ncol(breakfast_times)), sep="")
  # do the same thing for dinner
  dinner_seq <- rbind(Seq2, Seq4,
                      Seq6, Seq8, Seq10, Seq12,
                      Seq14, Seq16, Seq18)
  dinner_times <- matrix(nrow=nrow(dinner_seq),ncol=(length(Seq1)-1))
  for(j in 1:ncol(dinner_times)){
    dinner_times[,j] <- df1$Time[dinner_seq[,j]]
  }
  rownames(dinner_times) <- paste("Day",c(1:nrow(dinner_times)),sep="")
  colnames(dinner_times) <- paste("Fly",c(1:ncol(dinner_times)), sep="")
  #save all the time indices so we can find the mins
  alltimes_seq <- rbind(Seq1,Seq2, Seq3,Seq4,
                        Seq5,Seq6, Seq7,Seq8, Seq9,Seq10, Seq11,Seq12,
                        Seq13,Seq14, Seq15,Seq16,Seq17,Seq18,Seq19)[,-1] #get rid of first column "seq"
  return(list("BreakfastMaxIndices" = breakfast_seq, "DinnerMaxIndices" = dinner_seq, "BreakfastMaxTimes" = breakfast_times, "DinnerMaxTimes" = dinner_times, "TimeIndices" = alltimes_seq, "df1" = df1))
}



###############################
#### Finding the start meal minimas ######
###############################

findMinimasBefore <- function(Seq, df1) {
  # Now we want to look at all the max time indices again
  #transposing because by default the apply() function cbinds and I want it to rbind
  temp <- df1[, -match(c("Day", "Time", "Sucrose"), colnames(df1))]
  as.data.frame(t(apply(Seq,1,function(x){
    next0 <- c()
    for(i in 1:length(x)){
      # if no max for that time frame and that fly, return NA 
      if(is.na(x[i])) {next0 <- c(next0,NA)}
      # otherwise, go get that fly's column and the time column
      else{
        temp <- df1[,match(c("Time",names(x[i])),colnames(df1))]
        # get the next 12 hours after each maximum index
        temp <- temp[(ifelse((x[i]-24) > 0, x[i]-24, 0)):x[i],]
        # find zeros after the maxima
        # if there are more than one zero within the next 12 hours, take the first one
        if(length(which(temp[,2] == 0)) != 0) {
          next0 <- c(next0,temp$Time[which(temp[,2]==0)[length(which(temp[,2] == 0))]])
        }
        # otherwise, find the minimum value's index
        else{
          next0 <- c(next0,temp$Time[which.min(temp[,2])])
        }
      }
    }
    return(next0)
  })))
}

findBreakfastStart <- function(Seq, df1) {
  # Now we want to look at all the max time indices again
  #transposing because by default the apply() function cbinds and I want it to rbind
  temp <- df1[, -match(c("Day", "Time", "Sucrose"), colnames(df1))]
  as.data.frame(t(apply(Seq,1,function(x){
    next0 <- c()
    for(i in 1:length(x)){
      # if no max for that time frame and that fly, return NA 
      if(is.na(x[i])) {next0 <- c(next0,NA)}
      # otherwise, go get that fly's column and the time column
      else{
        temp <- df1[,match(c("Time",names(x[i])),colnames(df1))]
        # get the next 12 hours after each maximum index
        temp <- temp[(ifelse((x[i]-24) > 0, x[i]-24, 0)):x[i],]
        # find zeros after the maxima
        # if there are more than one zero within the next 12 hours, take the first one
        if(length(which(temp[,2] == 0)) != 0) {
          new <- temp$Time[which(temp[,2]==0)[length(which(temp[,2] == 0))]]
          if(new>12 && new<=24) { new<-new-24 }
          next0 <- c(next0,new)
        }
        # otherwise, find the minimum value's index
        else{
          new <- temp$Time[which.min(temp[,2])]
          if(new>12 && new<=24) { new<-new-24 }
          next0 <- c(next0,new)
        }
      }
    }
    return(next0)
  })))
}

###############################
#### Finding the final minimas ######
###############################

# This function uses the index of the max feeding time and tries to find when that fly's mealtime ends
# This is defined by the lab as the first zero value after peak feeding
# This function returns the time of the first zero after max feeding using the max feeding indices
# If there is no zero in the 12 hours after max feeding, it returns the minima in the 12 hours after feeding

findMinimas <- function(Seq, df1) {
  # Now we want to look at all the max time indices again
  #transposing because by default the apply() function cbinds and I want it to rbind
  temp <- df1[, -match(c("Day", "Time", "Sucrose"), colnames(df1))]
  as.data.frame(t(apply(Seq,1,function(x){
    next0 <- c()
    for(i in 1:length(x)){
      # if no max for that time frame and that fly, return NA 
      if(is.na(x[i])){next0 <- c(next0,NA)}
      # otherwise, go get that fly's column and the time column
      else{
        temp <- df1[,match(c("Time",names(x[i])),colnames(df1))]
        # get the next 12 hours after each maximum index
        temp <- temp[x[i]:(x[i]+24),]
        # find zeros after the maxima
        # if there are more than one zero within the next 12 hours, take the first one
        if(length(which(temp[,2] == 0)) != 0) {
          next0 <- c(next0,temp$Time[which(temp[,2]==0)[1]])
        }
        # otherwise, find the minimum value's index
        else{
          next0 <- c(next0,temp$Time[which.min(temp[,2])])
        }
      }
    }
    return(next0)
  })))
}

findDinnerEnd <- function(Seq,df1) {
  # Now we want to look at all the max time indices again
  #transposing because by default the apply() function cbinds and I want it to rbind
  temp <- df1[, -match(c("Day", "Time", "Sucrose"), colnames(df1))]
  as.data.frame(t(apply(Seq,1,function(x){
    next0 <- c()
    for(i in 1:length(x)){
      # if no max for that time frame and that fly, return NA 
      if(is.na(x[i])){next0 <- c(next0,NA)}
      # otherwise, go get that fly's column and the time column
      else{
        temp <- df1[,match(c("Time",names(x[i])),colnames(df1))]
        # get the next 12 hours after each maximum index
        temp <- temp[x[i]:(x[i]+24),]
        # find zeros after the maxima
        # if there are more than one zero within the next 12 hours, take the first one
        if(length(which(temp[,2] == 0)) != 0) {
          new <- temp$Time[which(temp[,2]==0)[1]]
          if(new<12){new<-new+24}
          next0 <- c(next0,new)
        }
        # otherwise, find the minimum value's index
        else{
          new <- temp$Time[which.min(temp[,2])]
          if(new<12){new<-new+24}
          next0 <- c(next0,new)
        }
      }
    }
    return(next0)
  })))
}


###############################
###### Sum over 24 hours ######
###############################

# returns the max feeding value every 12 hours for each fly
Maxes_12hrs <- function(df){
  apply(df,2,function(x){
    sequence <- seq(from = 1, to = nrow(df),by = 24)
    maxes <- c()
    for(i in 1:(length(sequence)-1)){
      maxes <- c(maxes,max(x[sequence[i]:sequence[i+1]], na.rm=T))
    }
    return(maxes)
  })
}

# once a fly is "dead" (zero feeding for the rest of the experiment)
  # sum its feeding for the 24 hours before time of death
  # if a fly never dies, consider it "censored" and sum final 24 hours of feeding of experiment
SumOver24hrs <- function(df) {
  deadSum_24hr_all <- NULL
  deathTime <- NULL
  cenTime <- NULL
  deadFlyList <- NULL
  cenFlyList<-NULL
  cenSum_24hr_all <- NULL
  #removes flies that are 0 value from start-finish (escapees)
  df <- df[colSums(df, na.rm = T) != 0]
  colnames(df) <- c(1:ncol(df))
  #makes flies NA as soon as they have all 0 values
  for (j in 1:ncol(df)) {
    for (i in 1:nrow(df)) {
      #24*2 for half hour intervals = 48 for 1 day
      if ((sum(df[i:nrow(df), j], na.rm = T) == 0) & (length(df[i:nrow(df), j]) >= 48)) {
        #df[i:nrow(df), j] <- NA
        deadSum_24hr <- sum(df[(i-49):(i-1),j], na.rm=T)
        deadSum_24hr_all <- c(deadSum_24hr_all, deadSum_24hr)
        deadFlyList <- c(deadFlyList, j)
        deathTime <- c(deathTime, i)
        break
      }
    }
  }
  cenFlyList <- as.numeric(colnames(df)[!(1:ncol(df) %in% deadFlyList)])
  for (f in unique(cenFlyList)){
    cenSum <- sum(df[(nrow(df)-48):nrow(df),f])
    cenSum_24hr_all <- c(cenSum_24hr_all, cenSum)
    cenTime <- c(cenTime, nrow(df))
  }
  cenFlyTbl <- as.data.frame(cbind(cenFlyList, cenSum_24hr_all, cenTime))
  deadFlyTbl <- as.data.frame(cbind(deadFlyList, deadSum_24hr_all, deathTime))
  max12 <- Maxes_12hrs(df)
  max12_breakfast <- max12[seq(1,nrow(max12),2),]
  max12_dinner <- max12[seq(2,nrow(max12),2),]
  return(list("CensoredFlies" = cenFlyTbl,
              "DeadFlies" = deadFlyTbl, "Max_Breakfast" = max12_breakfast, "Max_Dinner" = max12_dinner))
}

