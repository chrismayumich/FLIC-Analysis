##########################
# Sample script for binning raw DFM data and making comparison plots
# K. Hoffman
# Last update Dec 20 2017
##########################

### Step 0: set working directory and install/load required packages
#can install packages using install.packages("readxl"), etc.
setwd("/Users/khoffman/Downloads/SampleFlyCode/")
source("TidyFunctions.R")
library("readxl")
library("reshape")
library("ggplot2")
library(dplyr) #great library for easily changing data set

### Step 1: Use this binning code to create binned
# excel files of your raw data
source("SingleWellChamber.R")
source("SaveBinnedData.R")
p<-ParametersClass.SingleWell()
p<-SetParameter(p, Feeding.Threshold.Value = 40, Feeding.Interval.Minimum = 40,
                Feeding.Minevents=5, Tasting.Threshold.Interval=c(10,40))
binInterval = 30 #Set to desired interval in minutes. 
# Note: Anytime this interval changes, the 'Bin Data' section needs to be re-run 
#      before saving or plotting data.

#--------Bin Data-------------
#Change numeric values to correspond to data
dfm1 <- DFMClass(1,p)
dfm2 <- DFMClass(2,p)
dfm3 <- DFMClass(3,p)
dfm4 <- DFMClass(4,p)
dfm5 <- DFMClass(5,p)
dfm6 <- DFMClass(6,p)
dfm7 <- DFMClass(7,p)
dfm8 <- DFMClass(8,p)
dfm9 <- DFMClass(9,p)
dfm10 <- DFMClass(10,p)
dfm11 <- DFMClass(11,p)
dfm12 <- DFMClass(12,p)
dfm13 <- DFMClass(13,p)
dfm14 <- DFMClass(14,p)
dfm15 <- DFMClass(15,p)
dfm16 <- DFMClass(16,p)
dfm17 <- DFMClass(17,p)
dfm18 <- DFMClass(18,p)
dfm19 <- DFMClass(19,p)
dfm20 <- DFMClass(20,p)

# Bin by 30 min
bindfm1 <- BinFeedingData.Licks(dfm1, binInterval)
bindfm2 <- BinFeedingData.Licks(dfm2, binInterval)
bindfm3 <- BinFeedingData.Licks(dfm3, binInterval)
bindfm4 <- BinFeedingData.Licks(dfm4, binInterval)
bindfm5 <- BinFeedingData.Licks(dfm5, binInterval)
bindfm6 <- BinFeedingData.Licks(dfm6, binInterval)
bindfm7 <- BinFeedingData.Licks(dfm7, binInterval)
bindfm8 <- BinFeedingData.Licks(dfm8, binInterval)
bindfm9 <- BinFeedingData.Licks(dfm9, binInterval)
bindfm10 <- BinFeedingData.Licks(dfm10, binInterval)
bindfm11 <- BinFeedingData.Licks(dfm11, binInterval)
bindfm12 <- BinFeedingData.Licks(dfm12, binInterval)
bindfm13 <- BinFeedingData.Licks(dfm13, binInterval)
#--------Bin Data-------------

#------Save to Excel----------
# Change numeric values and file names below to correspond to data
BinFeedingData.Licks.SaveResults(dfm1, bindfm1, "1_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm2, bindfm2, "2_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm3, bindfm3, "3_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm4, bindfm4, "4_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm5, bindfm5, "5_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm6, bindfm6, "6_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm7, bindfm7, "7_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm8, bindfm8, "8_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm9, bindfm9, "9_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm10, bindfm10, "10_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm11, bindfm11, "11_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm12, bindfm12, "12_11Aug2017_30minbin.xlsx", binInterval)
BinFeedingData.Licks.SaveResults(dfm13, bindfm13, "13_11Aug2017_30minbin.xlsx", binInterval)
#-------Save to Excel----------

#------------Events------------
#calculate average event duration per bin
# binevents1<-BinFeedingData.Events(dfm1,binInterval)
# write.xlsx(binevents1,"EventExample1.xlsx")
# 
# binevents2<-BinFeedingData.Events(dfm2,binInterval)
# write.xlsx(binevents2,"EventExample2.xlsx")
# 
# binevents3<-BinFeedingData.Events(dfm3,binInterval)
# write.xlsx(binevents3,"EventExample3.xlsx")
#------------Events------------

### Step 2: Upload your files from excel
dfm2_sept_df <- as.data.frame(read_excel("DFM2.xlsx"))
dfm3_sept_df <- as.data.frame(read_excel("DFM3.xlsx"))
dfm11_sept_df <- as.data.frame(read_excel("DFM11.xlsx"))
dfm12_sept_df <- as.data.frame(read_excel("DFM12.xlsx"))
dfm13_sept_df <- as.data.frame(read_excel("DFM13.xlsx"))
dfm14_sept_df <- as.data.frame(read_excel("DFM14.xlsx"))
dfm15_sept_df <- as.data.frame(read_excel("DFM15.xlsx"))
dfm16_sept_df <- as.data.frame(read_excel("DFM16.xlsx"))
dfm17_sept_df <- as.data.frame(read_excel("DFM17.xlsx"))
dfm18_sept_df <- as.data.frame(read_excel("DFM18.xlsx"))
dfm19_sept_df <- as.data.frame(read_excel("DFM19.xlsx"))
dfm20_sept_df <- as.data.frame(read_excel("DFM20.xlsx"))

dfm11_nov_df <- as.data.frame(read_excel("DFM11.xlsx"))
dfm12_nov_df <- as.data.frame(read_excel("DFM12.xlsx"))
dfm13_nov_df <- as.data.frame(read_excel("DFM13.xlsx"))
dfm14_nov_df <- as.data.frame(read_excel("DFM14.xlsx"))
dfm15_nov_df <- as.data.frame(read_excel("DFM15.xlsx"))
dfm16_nov_df <- as.data.frame(read_excel("DFM16.xlsx"))
dfm17_nov_df <- as.data.frame(read_excel("DFM17.xlsx"))
dfm19_nov_df <- as.data.frame(read_excel("DFM19.xlsx"))

### Step 3: Extract the fly feeding columns from each DFM
# (there are a few extra columns of data in the excel file;
# we are only interested in the W1-W12 columns which are 4:15)
# Depending on how you've assigned your flies you may have to play with this a bit
# Christina usually has odds on one diet and even on another, so an example of
# doing it like this is shown. If all your flies from one DFM are on a certain
# diet, you'll simply extract columns 4:15 (that's the W1-W12 columns)

#these variables just help me extract the columns I want quickly and easily

odds<-c(4,6,8,10,12,14)
evens<-c(5,7,9,11,13,15)

all<-c(4:15)
some_for_12<-c(9,11:13)
dfm11_nov_wells <- dfm11_nov_df[all]
dfm12_nov_wells <- dfm12_nov_df[some_for_12]
# dfm12_nov_wells <- dfm12_nov_df[all]
dfm13_nov_wells <- dfm13_nov_df[all]
dfm14_nov_wells <- dfm14_nov_df[all]
dfm15_nov_wells <- dfm15_nov_df[all]
dfm16_nov_wells <- dfm16_nov_df[all]
dfm17_nov_wells <- dfm17_nov_df[all]
dfm19_nov_wells <- dfm19_nov_df[all]


#for this example we'll pretend dfm1's even flies were on a 5% diet and odds 20%

all<-c(3:14)
evens<-c(4,6,8,10,12,14)
some_for_2<-c(3,5,6,7,8,9)
some_for_18<-c(3,5,7,9,11,13,6,8,10,12)
some_for_17<-c(5:14)
# dfm2_sept_wells <- dfm2_sept_df[some_for_2]
dfm2_sept_wells <- dfm2_sept_df[all]
dfm3_sept_wells <- dfm3_sept_df[all]
dfm11_sept_wells <- dfm11_sept_df[all]
dfm12_sept_wells <- dfm12_sept_df[all]
dfm13_sept_wells <- dfm13_sept_df[all]
dfm14_sept_wells <- dfm14_sept_df[all]
dfm15_sept_wells <- dfm15_sept_df[all]
dfm16_sept_wells <- dfm16_sept_df[evens]
# dfm16_sept_wells <- dfm16_sept_df[all]
dfm17_sept_wells <- dfm17_sept_df[some_for_17]
# dfm17_sept_wells <- dfm17_sept_df[all]
dfm18_sept_wells <- dfm18_sept_df[some_for_18]
# dfm18_sept_wells <- dfm18_sept_df[all]
dfm19_sept_wells <- dfm19_sept_df[all]
dfm20_sept_wells <- dfm20_sept_df[all]



### Step 4: "glue" together your flies that are on the same diet and/or genetic path
#remember this is our 5% flies


#Sep09_2016_W1118 <- cbind(dfm15_wells, dfm20_wells)
#Sep09_2016_W1118 <- cbind(dfm15_wells)
#Sep09_2016_W1118 <- cbind(dfm20_wells)

# some_64f <- cbind(dfm16_sept_wells,dfm12_nov_wells)
all_64f <- cbind(dfm2_sept_wells, dfm11_sept_wells,dfm16_sept_wells,dfm12_nov_wells,dfm17_nov_wells)

# some_N <- cbind(dfm18_sept_wells)
all_N <- cbind(dfm12_sept_wells,dfm18_sept_wells,dfm16_nov_wells,dfm15_nov_wells,dfm14_nov_wells)

#Sep09_2016_64fN <- cbind(dfm17_sept_wells, dfm19_sept_wells)
# some_64fN <- cbind(dfm17_sept_wells)
all_64fN <- cbind(dfm13_sept_wells,dfm17_sept_wells,dfm19_sept_wells,dfm11_nov_wells,dfm13_nov_wells,dfm19_nov_wells)
#Sep09_2016_64fN <- cbind(dfm19_sept_wells)
#Nov15_2016_


### Step 4: MELT your data
# These functions all "melt" your data down into long format
# Check out melt() online if you haven't used it before, but basically
    # we want columns for ggplot to be able to easily see what it needs to plot
# So you'll have all of the values for dfm1, fly 1 in one column for all time points
    # Then followed by all of dfm1, fly 2 then dfm1, fly3...... and so on
# This will allow us to tell ggplot to put all the flies on the Y axis,
# Time on the X axis (another column), and then group by diet, day, etc
    # whatever the thing is should get its own column

###################
# IMPORTANT!!!
###################
# Make sure you go into your excel file and find the closest time to midnight of day 1
# and use it as your row start parameter. In this data you can see that row 17
# is time 23:54, so we want to run our data through this function starting
# at row 16 (this corresponds to row 17 in excel)

# 4A - calling this function will keep all of your flies and just prep your data for ggplot
# Unless you have a genetically modified fly just ignore the 3rd parameter
# oct_5p_melt <- tidyFlies(oct_5p, 5, NA, 16)
# oct_20p_melt <- tidyFlies(oct_20p, 20, NA, 16)
# 
# # 4B - use if you want to throw out flies that have value of 0 the entire experiment
# oct_5p_rm_melt <- tidyDeadFlies(oct_5p, 5, NA, 16)
# oct_20p_rm_melt <- tidyDeadFlies(oct_20p, 20, NA, 16)
# 
# # 4C - use if you want to throw out flies that have value of 0 the entire experiment
# # AND make flies that register 0 values for the rest of the experiement NA
# # This helps so that dead flies don't drag down your means
# oct_5p_rm2_melt <- removeDeadEscaped(oct_5p, 5, NA, 16)
# oct_20p_rm2_melt <- removeDeadEscaped(oct_20p, 20, NA, 16)

#Sep09_2016_W1118_melt <- removeDeadEscaped(Sep09_2016_W1118, "20%", "W1118", 15)
all_64f_melt <- removeDeadEscaped(all_64f, "20%", "Gr64f-GAL4/+", 16)
all_N_melt <- removeDeadEscaped(all_N, "20%", "UAS-NaChBac/+", 16)
all_64fN_melt <- removeDeadEscaped(all_64fN, "20%", "Gr64f>NaChBac", 16)

some_64f_melt <- removeDeadEscaped(some_64f, "20%", "Gr64f-GAL4/+", 16)
some_N_melt <- removeDeadEscaped(some_N, "20%", "UAS-NaChBac/+", 16)
some_64fN_melt <- removeDeadEscaped(some_64fN, "20%", "Gr64f>NaChBac", 16)
### Step 5: Combine your nice clean (long) data frames into one big (long) one that you
# can call easily for your various plots

#Using results from 4A
# oct_all <- rbind(oct_5p_melt, oct_20p_melt)
# #4B
# oct_rm_all <- rbind(oct_5p_rm_melt, oct_20p_rm_melt)
# #4C
# rm2_all <- rbind(oct_50mMG_rm2_melt, oct_400mMG_rm2_melt, oct_1MG_rm2_melt, oct_5p_sated_rm2_melt, 
#                      oct_5p_starved_rm2_melt)
# rm2_glucose <- rbind(oct_50mMG_rm2_melt, oct_400mMG_rm2_melt, oct_1MG_rm2_melt)

#rm2_all <- rbind(Sep09_2016_W1118_melt, Sep09_2016_64f_melt, Sep09_2016_N_melt, Sep09_2016_64fN_melt)
rm2_all <- rbind(all_64f_melt, all_N_melt, all_64fN_melt)
rm2_SOMEDAYS <- filter(rm2_all, Day != 3 & Day != 4 & Day !=6 & Day !=8 & Day != 9)

rm2_some <- rbind(some_64f_melt, some_N_melt, some_64fN_melt)
rm2_SOMEDAYS <- filter(rm2_some, Day != 3 & Day != 4 & Day !=6 & Day !=8 & Day != 9) 

#removes any observation where the Day column is equal to 5 and 4

#you have to add this to make your time continuous (ultimately makes plots nicer)

#rm2_all$variable<-as.numeric(as.character(rm2_all$variable))

rm2_SOMEDAYS$variable<-as.numeric(as.character(rm2_SOMEDAYS$variable))

### Step 6: Make your plots!
# You've got a few different options here as far as filtering out dead/escaped flies goes
# Try switching out your oct_all data frame for oct_rm2_all and oct_rm_all to see differences

# Set a new directory where you want the plots to go

# dir.create("./Plots")
setwd("./Plots")

# To look at all your data for all your days:
##Monica doesn't like this one
# pdf("09-19Sep2016.pdf",width=7,height=7)
# ggplot(rm2_SOMEDAYS, aes(Time,value,col=factor(Diet)))+
#   stat_summary(fun.y = mean,geom="line",size=0.5)+
#   stat_summary(fun.y = mean,geom="point",size=0.5)+
#   #change fun.data = mean_se to fun.data=mean_sdl to get standard dev
#   stat_summary(fun.data = mean_se, geom="errorbar", alpha= 0.5)+
#   ggtitle("August Feeding +/- SEM")+
#   ylab("Mean Licks")+
#   guides(col=guide_legend(title="Diet"),fill=F)+
#   facet_wrap(~ factor(Day),scales="free")+
#   theme_bw()
# dev.off()

#To get individual graphs:
# for (i in unique(oct_rm2_all$Day)) {
#   ggsave(filename=paste("Day",i,"AugustFeeding_SEM.pdf"), plot=ggplot(data=oct_rm2_all[oct_rm2_all$Day == i,], mapping = aes(Time,value,col=factor(Diet)))+
#     stat_summary(fun.y = mean,geom="line",size=0.5)+
#     stat_summary(fun.y = mean,geom="point",size=0.5)+
#     #change fun.data = mean_se to fun.data=mean_sdl to get standard dev
#     stat_summary(fun.data = mean_se, geom="errorbar", alpha= 0.5)+
#     ggtitle("August Feeding +/- SEM")+
#     ylab("Mean Licks")+
#     #Changes the legend
#     guides(col=guide_legend(title="Diet"),fill=F)+
#     theme_bw(),
#     #change your size of your saved graphs
#     units="in", width=5, height=4)
# }

### Comparison plot code ####
# pdf("Half-Hour Averages - test", height=3,width=10) # height/weight in inches
# #Using CD_full_samp2 because that contains all the flies, just specific days
# ggplot(rm2_SOMEDAYS, aes(Time,value,col=factor(Pathway)))+
#   # if you want the lines connecting the points, uncomment this
#   stat_summary(fun.y = mean,geom="line",size=0.5)+
#   #stat_summary(fun.y = mean,geom="point",size=0.5)+ #can change the size of the points
#   #scale_color_manual(values=c("#E4ABFA","#8A08BE","#aad3f9","#174c7c","#7c1636","#382229",
#   #"#97e5ad","#468758","#2a00ff","#36258c"))+ 
#   #light purple, dark purple, light blue, dark blue, maroon, dark maroon,
#   #pastel green, green, light royal blue, royal blue
#   scale_color_manual(values=c("#7c1636","#468758","#2a00ff"))+ 
#   stat_summary(fun.data = mean_se, geom="errorbar", alpha= 0.5)+ #adds the standard error mean
#   # if you want standard deviation run this instead:
#   # stat_summary(fun.data = mean_sdl, geom="errorbar", alpha= 0.5) +
#   ggtitle("Half-Hour Averages")+
#   labs(y="Mean Licks", x="Time (Hours)", title="Half-Hour Averages", col = "Genotype")+
#   facet_grid(~factor(Day),scales="free",space="free")+
#   theme_classic() #change to theme_bw() or something else if you want the grid lines back
# dev.off() #ends the creation of the pdf

pdf("Half-Hour Averages - test", height=2.5,width=5.5) # height/weight in inches
#Using CD_full_samp2 because that contains all the flies, just specific days
base_size = 11
ggplot(rm2_SOMEDAYS, aes(Time,value,col=factor(Pathway,levels = c("Gr64f-GAL4/+","UAS-NaChBac/+","Gr64f>NaChBac"))))+
  # if you want the lines connecting the points, uncomment this
  stat_summary(fun.y = mean,geom="line",size=0.3)+
  #stat_summary(fun.y = mean,geom="point",size=0.5)+ #can change the size of the points
  #scale_color_manual(values=c("#E4ABFA","#8A08BE","#aad3f9","#174c7c","#7c1636","#382229",
  #"#97e5ad","#468758","#2a00ff","#36258c"))+ 
  #light purple, dark purple, light blue, dark blue, maroon, dark maroon,
  #pastel green, green, light royal blue, royal blue
  # scale_color_manual(values=c("#ff6666","#990000"))+    #salmon and cayenne from prism
  scale_color_manual(values=c("#999999","#333333","#339999"))+ #greys and teal from prism
  stat_summary(fun.data = mean_se, geom="errorbar", alpha= 0.5, size = 0.3)+ #adds the standard error mean
  # if you want standard deviation run this instead:
  # stat_summary(fun.data = mean_sdl, geom="errorbar", alpha= 0.5) +
  ggtitle("Half-Hour Averages")+
  labs(y="Mean Licks", x="Time of Day (24h)", title="Half-Hour Averages", col = "Genotype")+
  facet_grid(~factor(Day),scales="free",space="free")+
  scale_x_continuous(breaks=c(0,6,12,18,24), expand = c(0, 0)) +
  # theme_classic()
  theme(axis.line = element_line(size = 0.3,colour = "black"), axis.ticks = element_line(size=0.2), axis.text = element_text(size = base_size, colour = "black"),
        strip.background = element_rect(fill = "white", colour = "black"), strip.text = element_text(size=base_size), 
        panel.background = element_rect(fill="white"), legend.key = element_rect(fill = "white"), legend.text = element_text(face="italic"))
# theme_classic() #change to theme_bw() or something else if you want the grid lines back
dev.off() #ends the creation of the pdf

### RASTER code ###
# pdf("Individual Flies - test.pdf",width=15,height=5)
# ggplot(rm2_SOMEDAYS, aes(Time, variable, fill = value)) +
#   geom_tile() +
#   facet_grid(Pathway ~ Day, scales = "free", space = "free", labeller = labeller(Diet = label_wrap_gen(8))) +
#   ylab("Fly") +
#   scale_x_continuous(expand = c(0, 0)) +
#   scale_y_continuous(expand = c(0, 0)) +
#   scale_fill_gradientn(
#     colours = grad,
#     values = rescale / 1200,
#     limits = c(0, 1200),
#     name = "Licks"
#   ) +
#   ggtitle("Individual Flies") +
#   guides(fill = guide_colorbar(
#     barwidth = 1,
#     barheight = 10,
#     nbin = 100
#   )) +
#   theme(strip.text.y = element_text(size=9))
# dev.off()

pdf("Individual Flies - test.pdf",width=5,height=3.5)
base_size = 12
ggplot(rm2_SOMEDAYS, aes(Time, variable, fill = value)) +
  geom_tile() +
  facet_grid(factor(Pathway,levels = c("Gr64f-GAL4/+","UAS-NaChBac/+","Gr64f>NaChBac")) ~ Day, scales = "free", space = "free", labeller = labeller(Diet = label_wrap_gen(8))) +
  ylab("Fly") +
  xlab("Time of Day (24h)") +
  scale_x_continuous(breaks=seq(0,24,6), expand = c(0,0)) +
  scale_y_continuous(breaks=c(0,10,5), expand = c(0,0)) +
  scale_fill_gradientn(
    colours = grad,
    values = rescale / 1200,
    limits = c(0, 1200),
    name = "Licks"
  ) +
  ggtitle("Individual Flies") +
  guides(fill = guide_colorbar(
    barwidth = 0.5,
    barheight = 4,
    nbin = 100
  )) +
  theme(axis.ticks = element_blank(), axis.text = element_text(size = base_size*0.9, colour = "black"), legend.margin = margin(l=1),
        strip.background = element_rect(fill = "white", colour = "black"), strip.text = element_text(size=base_size*0.6,face="italic"), panel.border = element_rect(fill=NA,colour = "black"))
#theme_classic(axis.ticks = element_blank(), axis.text = element_text(size = base_size,colour = "black"))
# theme_linedraw()
#axis.ticks = element_blank()
# strip.text.x = element_text(size=base_size)
dev.off()

