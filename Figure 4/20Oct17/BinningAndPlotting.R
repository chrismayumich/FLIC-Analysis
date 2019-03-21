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
dfm9 <- DFMClass(9,p)
bindfm9 <- BinFeedingData.Licks(dfm9, binInterval)

dfm7 <- DFMClass(7,p)
bindfm7 <- BinFeedingData.Licks(dfm7, binInterval)

dfm8 <- DFMClass(8,p)
bindfm8 <- BinFeedingData.Licks(dfm8, binInterval)

dfm11 <- DFMClass(11,p)
bindfm11 <- BinFeedingData.Licks(dfm11, binInterval)
#--------Bin Data-------------


#------Save to Excel----------
# Change numeric values and file names below to correspond to data
BinFeedingData.Licks.SaveResults(dfm9, bindfm9, "M09_20Oct2017.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm7, bindfm7, "M07_20Oct2017.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm8, bindfm8, "M08_20Oct2017.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm11, bindfm11, "M11_20Oct2017.xlsx", binInterval)
#-------Save to Excel----------


#---------Plotting-------------
#Update the dfm##, bindfm##, and plot title values
BinFeedingData.Licks.PlotWellsByDay(dfm11, bindfm11, binInterval, title="M11 06Dec16") 

BinFeedingData.Licks.PlotWellsByDay(dfm12, bindfm12, binInterval, title="M12 06Dec16")

BinFeedingData.Licks.PlotWellsByDay(dfm13, bindfm13, binInterval, title="M13 06Dec16")

BinFeedingData.Licks.PlotWellsByDay(dfm14, bindfm14, binInterval, title="M14 06Dec16")
#---------Plotting-------------
