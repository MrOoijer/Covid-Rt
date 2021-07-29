#    1  2  3  4  5  6  7  8  9  T  E
b<- c(0,4, 8, 12, 8, 4, 2, 2, 2, 1, 1)
f<- rev(b)/sum(b)

y<- smoothed(cases_all, 7)$cases
z<- stats::filter(y, f, sides=1)
R<- ifelse(z>0, y/z, 1)
R<- tail(R, -10)
d<- tail(cases_all, -10)
d[,2] <- R
pretty_date(d, start=as.Date("2020-02-01"), ylim=c(0,5))
