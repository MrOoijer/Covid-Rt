# Rt with JBF.

Rt_JBF <- function(data_set, 
                   SMOOTH_DATA=11, 
                   PER_ANAL=4, SKIP= 5){
  # smooth
  cs<- smoothed(data_set, SMOOTH_DATA)
  
  # emulate error margin -- completely unfounded in theory
  cs2<- cs
  cs2$cases <- 1.96*abs(cs2$cases - data_set$cases)
  cs2<- smoothed(cs2, SMOOTH_DATA)
  df3<- cbind(cs, lo= cs$cases- cs2$cases, hi= cs$cases+ cs2$cases)
  
  # Avg increas in PER_ANAL days - including margins
  D= sqrt(2)
  df4<- df3
  df4[, 3] <- (df4[,2] + df4[,3])/D
  df4[, 4] <- (df4[,2] + df4[,4])/D
  #now the in/decrease
  df5<- df4
  df4<- head(df4, -PER_ANAL)
  df5<- tail(df5, -PER_ANAL)
  df4$cases<- df5$cases/df4$cases
  tmp<- df4$lo
  df4$lo<- df5$lo/df4$hi
  df4$hi<- df5$hi/tmp
  df4$date<- df4$date - 0
  # do not yet show recent values bacause unreliable
  df4<- head(df4, -SKIP)
}