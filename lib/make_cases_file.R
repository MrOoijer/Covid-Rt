# We work with time series that are in fact dataframes(date, cases). 
# Date has a DDate format and cases can be real or integer

# Gaussian smoother that is often needed
SM_WINDOW = 7
smoothed<- function(dfx, w= SM_WINDOW){
  dfx$cases <- smoother::smth(
    dfx$cases, window = w, tails = TRUE)
  dfx
}

#In the input we might miss certain Dates so we fill those gaps with 0's
flattened<- function(dfx, start= as.Date(min(dfx$date))){
  dd<- seq( start, as.Date(max(dfx$date)), by=1)
  dd<- data.frame(date= dd)
  dfy <- merge(dd, dfx, by= "date", all.x=TRUE)
  dfy$cases[is.na(dfy$cases)] <- 0
  dfy
}

# creates time series in the correct format 
make_cases <- function (data_set, start= as.Date("2020-01-01")){
  df <- data.frame(date=as.Date(data_set[,1]), cases= as.numeric(data_set[,2]))
  df <- df[order(df$date),]
  return(flattened(df, start=start))
}

# ----------------------------------------------------------------

# the most common timeseries

make_all_cases <- function () {
  df<- make_cases(aggregate(cbind(cases=rep(1, nrow(cases_df))) ~ Date_statistics , 
               data = cases_df, 
               FUN = sum  ))
  return(df)
}

make_DOO_cases <- function(){
  h<- cases_df$Date_statistics_type == "DOO"
  df<- make_cases(aggregate(cbind(cases=rep(1, sum(h))) ~ Date_statistics , 
                            data = cases_df[h, ], 
                            FUN = sum  ))
  return(df)
}
