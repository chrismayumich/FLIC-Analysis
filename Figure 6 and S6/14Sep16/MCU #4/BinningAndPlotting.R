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
dfm11 <- DFMClass(11,p)
bindfm11 <- BinFeedingData.Licks(dfm11, binInterval)

dfm12 <- DFMClass(12,p)
bindfm12 <- BinFeedingData.Licks(dfm12, binInterval)

dfm13 <- DFMClass(13,p)
bindfm13 <- BinFeedingData.Licks(dfm13, binInterval)

dfm14 <- DFMClass(14,p)
bindfm14 <- BinFeedingData.Licks(dfm14, binInterval)
#--------Bin Data-------------


#------Save to Excel----------
# Change numeric values and file names below to correspond to data
BinFeedingData.Licks.SaveResults(dfm11, bindfm11, "M11_09Sep_test.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm12, bindfm12, "M12_09Sep_test.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm13, bindfm13, "M13_09Sep_test.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm14, bindfm13, "M14_09Sep_test.xlsx", binInterval)
#-------Save to Excel----------


#---------Plotting-------------
#Update the dfm##, bindfm##, and plot title values
BinFeedingData.Licks.PlotWellsByDay(dfm11, bindfm11, binInterval, title="M11 06-Oct-2016") 

BinFeedingData.Licks.PlotWellsByDay(dfm12, bindfm12, binInterval, title="M12 06-Oct-2016")

BinFeedingData.Licks.PlotWellsByDay(dfm13, bindfm13, binInterval, title="M13 06-Oct-2016")

BinFeedingData.Licks.PlotWellsByDay(dfm14, bindfm14, binInterval, title="M14 06-Oct-2016")
#---------Plotting-------------
