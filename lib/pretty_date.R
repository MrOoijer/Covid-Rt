# Not always robust - so not yet in myLib.

pretty_date <- function(..., start= as.Date("2020-02-01"),
                        end= Sys.Date() + 15, ccloc=4, 
                        xat=NULL){
  if (is.null(xat)) xat= seq(start, by="2 month",
                             length.out= 24)
  xrange= c(start, end)
  f<- "%d-%m"
  xlab="2020 - 2021"
  pretty_plot(..., ccloc=ccloc, xlim= xrange, xlab=xlab, xat=xat, dformat=f)
}
