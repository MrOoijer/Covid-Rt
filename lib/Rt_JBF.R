# Rt with JBF.

Rt_JBF <- function(data_set, 
                   SMOOTH_DATA=11, 
                   PER_ANAL=4, SKIP= 5){
  
  ### call new one
  return(Rt_JBF_2(data_set))
  
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
  df4
}

Rt_JBF_2 <- function(data_set)
{
  N= 7500
  
  LO<- 0.4
  HI<- 10
  
  trend_all <- smoothed(data_set, 11)
  M<- matrix(0,nrow=nrow(trend_all), ncol=N)
  for ( m in 1:nrow(trend_all)) 
    M[m,] <- rnorm(N, trend_all[m,2], 0.0263*trend_all[m,2])
  
  M1<- head(M, -4)
  M<- ifelse (M1 >0, tail(M, -4)/M1, 0)
  
  R<-  apply(M, 1, function(x){
    x<- x[x<HI & x > LO]
    mean(x)
  })
  STD<- apply(M, 1, function(x){
    x<- x[x<HI & x > LO]
    sd(x)
  })
  
  result<- data.frame(date= head(trend_all$date, -4), 
                      R=R, lo= R-1.96*STD, hi=R+1.96*STD)
  return(head(result, -5))
}
