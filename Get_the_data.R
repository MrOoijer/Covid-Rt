## get new data from RIVM
#
url= "https://data.rivm.nl/covid-19/COVID-19_casus_landelijk.csv"
cases_df<- read.csv(url, stringsAsFactors = FALSE, sep=";")
save(cases_df, file="./data/cases_df.Rdata")
date_of_report<- as.Date(cases_df[1,1])
#
url= "https://data.rivm.nl/covid-19/COVID-19_aantallen_gemeente_per_dag.csv"
gem_df<- read.csv(url, stringsAsFactors = FALSE, sep=";")
save(gem_df, file="./data/gem_df.Rdata")
#
url= "https://data.rivm.nl/covid-19/COVID-19_reproductiegetal.json"
txt<- readLines(url)
repro_rivm<- jsonlite::fromJSON(txt)
save(repro_rivm, file="./data/repro_rivm.Rdata")
