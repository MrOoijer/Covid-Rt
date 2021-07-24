# Rt with EpiEstim
library(EpiEstim)

Rt_Epi <- function(inc, SMOOTH_DATA=15, PER_ANAL=9){
  # inc: incident count
  # SMOOTH_DATA - first smoothing parameter
  inc<- smoothed(inc, SMOOTH_DATA)
  names(inc)<- c("dates", "I")
  T <- nrow(inc)
  f<- which(inc$I !=0)[1]
  
  t_start <- seq(f+1, T- PER_ANAL) # starting at 2 as conditional on the past observations
  t_end <- t_start + PER_ANAL 
  
  # The following is a prior on details of the unknown serial interval, 
  # not yet as a fucntion parameter
  
  f<- discr_si(2:9, 4.5,1.5)
  config <- make_config(list(mean_si = 4.5, 
                             std_mean_si =2,
                             min_mean_si = 2.5,
                             max_mean_si = 6.5,
                             std_si = 1.5,
                             std_std_si = 0.5,
                             min_std_si = 0.5,
                             max_std_si = 2.5,
                             si_distr= f, 
                             t_start=t_start,
                             t_end=t_end
  ))
  a<- estimate_R(inc, 
                 method= "uncertain_si", 
                 config = config)
  ## Reformat the results
  dd <- a$dates
  f  <- length(dd) -nrow(a$R)
  dd <- dd[-(1:f)]
  res<-data.frame(date=dd, R=a$R[,3], low=a$R[, 5],
                  hi= a$R[, 11])
  return(res)
}
