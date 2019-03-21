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
dfm1 <- DFMClass(1,p)
bindfm1 <- BinFeedingData.Licks(dfm1, binInterval)

for (i in 1:6) {
  dfm1 <- DFMClass((100+i),p)
  bindfm1 <- rbind(bindfm1,BinFeedingData.Licks(dfm1, binInterval))
}

dfm2 <- DFMClass(2,p)
bindfm2 <- BinFeedingData.Licks(dfm2, binInterval)

for (i in 1:6) {
  dfm2 <- DFMClass((200+i),p)
  bindfm2 <- rbind(bindfm2,BinFeedingData.Licks(dfm2, binInterval))
}

dfm8 <- DFMClass(8,p)
bindfm8 <- BinFeedingData.Licks(dfm8, binInterval)

for (i in 1:6) {
  dfm8 <- DFMClass((800+i),p)
  bindfm8 <- rbind(bindfm8,BinFeedingData.Licks(dfm8, binInterval))
}

dfm11 <- DFMClass(11,p)
bindfm11 <- BinFeedingData.Licks(dfm11, binInterval)

for (i in 1:6) {
  dfm11 <- DFMClass((1100+i),p)
  bindfm11 <- rbind(bindfm11,BinFeedingData.Licks(dfm11, binInterval))
}

dfm15 <- DFMClass(15,p)
bindfm15 <- BinFeedingData.Licks(dfm15, binInterval)

for (i in 1:6) {
  dfm15 <- DFMClass((1500+i),p)
  bindfm15 <- rbind(bindfm15,BinFeedingData.Licks(dfm15, binInterval))
}

dfm17 <- DFMClass(17,p)
bindfm17 <- BinFeedingData.Licks(dfm17, binInterval)

for (i in 1:6) {
  dfm17 <- DFMClass((1700+i),p)
  bindfm17 <- rbind(bindfm17,BinFeedingData.Licks(dfm17, binInterval))
}

# dfm12 <- DFMClass(12,p)
# bindfm12 <- BinFeedingData.Licks(dfm12, binInterval)
# 
# for (i in 1:10) {
#   dfm12 <- DFMClass((1200+i),p)
#   bindfm12 <- rbind(bindfm12,BinFeedingData.Licks(dfm12, binInterval))
# }
# 
# dfm13 <- DFMClass(13,p)
# bindfm13 <- BinFeedingData.Licks(dfm13, binInterval)
# 
# for (i in 1:10) {
#   dfm13 <- DFMClass((1300+i),p)
#   bindfm13 <- rbind(bindfm13,BinFeedingData.Licks(dfm13, binInterval))
# }
# 
# dfm14 <- DFMClass(14,p)
# bindfm14 <- BinFeedingData.Licks(dfm14, binInterval)
# 
# for (i in 1:10) {
#   dfm14 <- DFMClass((1400+i),p)
#   bindfm14 <- rbind(bindfm14,BinFeedingData.Licks(dfm14, binInterval))
# }
# 
# dfm15 <- DFMClass(15,p)
# bindfm15 <- BinFeedingData.Licks(dfm15, binInterval)
# 
# for (i in 1:10) {
#   dfm15 <- DFMClass((1500+i),p)
#   bindfm15 <- rbind(bindfm15,BinFeedingData.Licks(dfm15, binInterval))
# }
#--------Bin Data-------------


#------Save to Excel----------
# Change numeric values and file names below to correspond to data
BinFeedingData.Licks.SaveResults(dfm1, bindfm1, "M01_28Nov2018.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm2, bindfm2, "M02_28Nov2018.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm8, bindfm8, "M08_28Nov2018.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm11, bindfm11, "M11_28Nov2018.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm15, bindfm15, "M15_28Nov2018.xlsx", binInterval)

BinFeedingData.Licks.SaveResults(dfm17, bindfm17, "M17_28Nov2018.xlsx", binInterval)

# BinFeedingData.Licks.SaveResults(dfm13, bindfm13, "M13_18Oct2018.xlsx", binInterval)
# 
# BinFeedingData.Licks.SaveResults(dfm14, bindfm14, "M14_18Oct2018.xlsx", binInterval)
# 
# BinFeedingData.Licks.SaveResults(dfm15, bindfm15, "M15_18Oct2018.xlsx", binInterval)
# 
# BinFeedingData.Licks.SaveResults(dfm12, bindfm12, "M12_18Oct2018.xlsx", binInterval)
#-------Save to Excel----------
