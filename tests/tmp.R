#    1  2  3  4  5  6  7  8  9  T  E
#b<- c(0,4, 8, 12, 8, 4, 2, 2, 2, 1, 1)
b<- c(1,0,0,0)
f<- rev(b)/sum(b)

y<- smoothed(cases_all, 11)$cases
z<- stats::filter(y, f, sides=1)
R<- ifelse(z>0, y/z, 1)
R<- tail(R, -10)
d<- tail(cases_all, -10)
d[,2] <- R
d$date<- d$date-4
pretty_date(d, start=as.Date("2021-02-01"), ylim=c(0,5))
repro_rivm[,3]<- as.numeric(repro_rivm[,3])
repro_rivm$Date<- as.Date(repro_rivm$Date)
pretty_date(add=T, kleur=4, repro_rivm[,c(1,3)])

u<- Rt_JBF (cases_all)
pretty_date(add=T, kleur=2, u[,c(1,3)])

a<- Rt_JBF(cases_all, NEW=FALSE)
b<- Rt_JBF(cases_all)
pretty_date(a, start=as.Date("2021-02-01"), ylim=c(0,5))
pretty_date(d, add=TRUE, kleur=2)
