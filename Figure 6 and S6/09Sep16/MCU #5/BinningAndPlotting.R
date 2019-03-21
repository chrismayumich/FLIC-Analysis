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
dfm15 <- DFMClass(15,p)
bindfm15 <- BinFeedingData.Licks(dfm15, binInterval)

dfm16 <- DFMClass(16,p)
bindfm16 <- BinFeedingData.Licks(dfm16, binInterval)

dfm17 <- DFMClass(17,p)
bindfm17 <- BinFeedingData.Licks(dfm17, binInterval)

dfm18 <- DFMClass(18,p)
bindfm18 <- BinFeedingData.Licks(dfm18, binInterval)
#--------Bin Data-------------


#------Save to Excel----------
# Change numeric values and file names below to correspond to data
BinFeedingData.Licks.SaveResults(dfm15, bindfm15, "M15_09Sep_test.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm16, bindfm16, "M16_09Sep_test.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm17, bindfm17, "M17_09Sep_test.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm18, bindfm18, "M18_09Sep_test.xlsx", binInterval)
#-------Save to Excel----------


#---------Plotting-------------
#Update the dfm##, bindfm##, and plot title values
BinFeedingData.Licks.PlotWellsByDay(dfm11, bindfm11, binInterval, title="M11 06Dec16") 

BinFeedingData.Licks.PlotWellsByDay(dfm12, bindfm12, binInterval, title="M12 06Dec16")

BinFeedingData.Licks.PlotWellsByDay(dfm13, bindfm13, binInterval, title="M13 06Dec16")

BinFeedingData.Licks.PlotWellsByDay(dfm14, bindfm14, binInterval, title="M14 06Dec16")
#---------Plotting-------------
