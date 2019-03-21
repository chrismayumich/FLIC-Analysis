#---------Setup---------------
source("SingleWellChamber.R")
source("SaveBinnedData.R")
p<-ParametersClass.SingleWell()
p<-SetParameter(p, Feeding.Threshold.Value = 40, Feeding.Interval.Minimum = 40,
                Feeding.Minevents=5, Tasting.Threshold.Interval=c(10,40))

binInterval = 30 #Set to desired interval in minutes. 
#Note: Anytime this interval changes, the 'Bin Data' section needs to be re-run 
#      before saving or plotting data.
#---------Setup---------------


#--------Bin Data-------------
#Change numeric values to correspond to data
dfm17 <- DFMClass(17,p)
bindfm17 <- BinFeedingData.Licks(dfm17, binInterval)

dfm18 <- DFMClass(18,p)
bindfm18 <- BinFeedingData.Licks(dfm18, binInterval)

dfm19 <- DFMClass(19,p)
bindfm19 <- BinFeedingData.Licks(dfm19, binInterval)

dfm20 <- DFMClass(20,p)
bindfm20 <- BinFeedingData.Licks(dfm20, binInterval)
#--------Bin Data-------------


#------Save to Excel----------
# Change numeric values and file names below to correspond to data
BinFeedingData.Licks.SaveResults(dfm17, bindfm17, "M17_15Aug2017.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm18, bindfm18, "M18_15Aug2017.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm19, bindfm19, "M19_15Aug2017.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm20, bindfm20, "M20_15Aug2017.xlsx", binInterval)
#-------Save to Excel----------


#---------Plotting-------------
#Update the dfm##, bindfm##, and plot title values
BinFeedingData.Licks.PlotWellsByDay(dfm15, bindfm15, binInterval, title="M15 13Mar17") 

BinFeedingData.Licks.PlotWellsByDay(dfm12, bindfm12, binInterval, title="M12 06Dec16")

BinFeedingData.Licks.PlotWellsByDay(dfm13, bindfm13, binInterval, title="M13 06Dec16")

BinFeedingData.Licks.PlotWellsByDay(dfm14, bindfm14, binInterval, title="M14 06Dec16")
#---------Plotting-------------
