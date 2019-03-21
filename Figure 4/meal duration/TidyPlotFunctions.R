################################################
################################################
# TidyPlotFunctions.R
# Source to tidy DFM experiment data and make comparison plots
# K. Hoffman
# Last update 20 Dec 2017
################################################
################################################


########################
# TIDYING FUNCTIONS
# Use on DFM excel files to prepare for plotting
########################


#Simplest function - just tidies up your data for ggplot
#Does not remove any flies
#Returns data in long format
tidyFlies <- function(df, sucrose, pathway, rowStart) {
  df <- df[rowStart:nrow(df), ]
  colnames(df) <- c(1:ncol(df))
  df$Time <- rep(seq(0, 23.5, by = 0.5), len = nrow(df))
  df$Day <- rep(1:15, each = 48, len = nrow(df))
  df$Sucrose <- rep(sucrose, nrow(df))
  df$Pathway <- rep(paste(pathway))
  df_melt <- melt(df, id = c("Time", "Day", "Sucrose", "Pathway"))
  return(df_melt)
}



# Get rid of any flies that have 0 values from the start of the experiment
# assume they were flies that escaped
#Returns data in long format
removeEscapedFlies <- function(df, sucrose, pathway, rowStart) {
  df <- df[rowStart:nrow(df), ]
  df <- df[colSums(df, na.rm = T) != 0]
  colnames(df) <- c(1:ncol(df))
  df$Time <- rep(seq(0, 23.5, by = 0.5), len = nrow(df))  #30 minute intervals
  df$Day <- rep(1:15, each = 48, len = nrow(df))
  df$Sucrose <- rep(sucrose, nrow(df))
  df$Pathway <- rep(paste(pathway))
  df_melt <- melt(df, id = c("Time", "Day", "Sucrose", "Pathway"))
  return(df_melt)
}



# Removes all the escaped flies AND
# Make any flies that are die in the middle of the experiment (no more eating) NA values
#Returns data in long format
removeDeadEscaped <- function(df, sucrose, pathway, rowStart) {
  df <- df[rowStart:nrow(df), ]
  #removes flies that are 0 value from start-finish (escapees)
  df <- df[colSums(df, na.rm = T) != 0]
  colnames(df) <- c(1:ncol(df))
  #makes flies NA as soon as they have all 0 values
  for (j in 1:ncol(df)) {
    for (i in 1:nrow(df)) {
      #print(paste(i, j))
      #print(sum(df[i:nrow(df), j]))
      if (sum(df[i:nrow(df), j], na.rm = T) == 0) {
        df[i:nrow(df), j] <- NA
      }
    }
  }
  df$Day <- rep(1:15, each = 48, len = nrow(df))
  df$Time <- rep(seq(0, 23.5, by = 0.5), len = nrow(df))
  df$Sucrose <- rep(sucrose, nrow(df))
  df$Pathway <- rep(paste(pathway))
  df_melt <- melt(df, id = c("Time", "Day", "Sucrose", "Pathway"))
  return(df_melt)
}



# For use with SummaryFunctions.R
# Can't use TidyFunctions.R because we don't want to melt this data
# Returns data in *wide* format
makeDeadNA <- function(df, sucrose) {
  colnames(df) <- c(1:ncol(df))
  #makes flies NA as soon as they have all 0 values
  for (j in 1:ncol(df)) {
    for (i in 1:nrow(df)) {
      if (sum(df[i:nrow(df), j], na.rm = T) == 0) {
        df[i:nrow(df), j] <- NA
      }
    }
  }
  #Experiment length
  Day <- rep(1:15, each = 48, len = nrow(df))
  #Time reference since we have 30 minute intervals
  Time <- rep(seq(0, 23.5, by = 0.5), len = nrow(df))
  Sucrose <- rep(sucrose, nrow(df))
  df <- cbind(Day, Time, Sucrose, df)
  return(df)
}



########################
# PLOTTING FUNCTIONS
# Use after tidying up data
########################


# colors for rainbow gradient
grad <- c(
  "white", "#9A00B8", "#5C00BB", "#1B00BE", "#0026C1",
  "#006BC4", "#00B2C8", "#00CB9B", "#00D10F", "#85D800",
  "#F0FF0F", "#FFE147", "#FCC509", "#FCA909", "#F68C07",
  "#E43C03", "#DE2301", "#D60000", "#890000", "#5B0000", "black")

# breaks for corresponding colors in grad
breaks <-
  c(0, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.08, 0.1, 0.12,
    0.14, 0.16, 0.22, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1)

# Line graph to compare the mean feeding times for each day
# Colors lines by different diets (or genetic pathway) for flies in the experiment
ComparisonPlot <- function(tidy_df, title, sd=T) {
  tidy_df$Day <- as.factor(tidy_df$Day)
  levels(tidy_df$Day) <- c(paste("Day", levels(tidy_df$Day)))
  return(ggplot(tidy_df, aes(Time,value,col=factor(Sucrose)))+
           stat_summary(fun.y = mean,geom="line",size=0.5)+ #comment out to get rid of lines
           stat_summary(fun.y = mean,geom="point",size=0.5)+
           stat_summary(fun.data = mean_se, geom="errorbar", alpha= 0.5) + #replace mean_se with mean_sdl to get standard dev
           ggtitle(paste(title))+
           ylab("Mean Licks")+
           guides(col=guide_legend(title="Diet"),fill=F)+
           scale_color_manual(values=c("blue","red"))+ #change colors of lines here
           facet_wrap(~ factor(Day))+ # if you have a genetic pathway make this factor(Pathway~Day)
           theme_bw())
}


# Makes a raster (heat map) with every data point from the experiment
# Good for data exploration
# Each row on Y axis is a fly. Y-axis facets for fly diet. X-axis facets for day
# X-axis for time of day.
RasterPlot <- function(tidy_df, title) {
  tidy_df$variable <- as.numeric(as.character(tidy_df$variable))
  tidy_df$Day <- as.factor(tidy_df$Day)
  levels(tidy_df$Day) <- c(paste("Day", levels(tidy_df$Day)))
  return(
    ggplot(tidy_df, aes(Time, variable, fill = value)) +
      geom_tile() +
      facet_grid(Sucrose ~ Day, scales = "free", space = "free") +
      ylab("Fly") + ggtitle(paste(title)) +
      scale_x_continuous(expand = c(0, 0)) +
      scale_y_continuous(expand = c(0, 0)) +
      scale_fill_gradientn(
        colours = grad,
        values = breaks,
        limits = c(0, 2000),
        name = "Licks") +
      guides(fill = guide_colorbar(
        barwidth = 1,
        barheight = 10,
        nbin = 100)) +
      theme_bw()
    )
}


# Makes a raster plot (heat map) for each day, with facets for the various sucrose diets (or genetic pathways)
# Each fly has its own row in the heat map. X-axis is time
DailyRasters <- function(tidy_df, title) {
  tidy_df$variable <- as.numeric(as.character(tidy_df$variable))
  for (i in unique(tidy_df$Day)){
  print(
    ggplot(tidy_df[tidy_df$Day == i,], aes(Time, variable, fill = value)) +
      geom_tile() +
      facet_grid( ~ Sucrose, scales = "free", space = "free") +
      ylab("Fly") + xlab("Time of Day") + ggtitle(paste("Day", i, "-", title)) +
      scale_x_continuous(expand = c(0, 0)) +
      scale_y_continuous(expand = c(0, 0)) +
      scale_fill_gradientn(
        colours = grad,
        values = breaks,
        limits = c(0, 2000),
        name = "Licks") +
      guides(fill = guide_colorbar(
        barwidth = 1,
        barheight = 10,
        nbin = 100)) +
      theme_bw()
  )
  }
}

