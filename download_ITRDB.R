library(FedData)
library(rvest)
library(stringr)
library(readr)

# This script enables the local (backup) download of all tree-ring data from the ITRDB.
# The download_itrdb() function from FedData (https://docs.ropensci.org/FedData/index.html) is used to download chronologies.
# A simple script was created to download all measurements in the ITRDB.
# Author of this script: Ronald M. Visser

# Chronologies
dir.create("crn")
itrdb_crn <- download_itrdb("crn")

# Measurements
dir.create("measurements")
continent_folders <- c("africa/", "asia/", "atlantic/", "australia/", "centralamerica/",
                       "correlation-stats/", "europe/", "northamerica/", "southamerica/",
                       "supplemental/", "zhao2018/")
location <- "https://www.ncei.noaa.gov/pub/data/paleo/treering/measurements/"

# downloading rwl and txt files
# with check if local file exist, in case of rerun/restart after lost connection or other error (e.g. SSL connect or timeout)

for (i in 1:length(continent_folders)) {
  dir.create(paste0("measurements/", continent_folders[i]), showWarnings = FALSE)
  message(paste0("Downloading tree-ring data files from: ", str_remove(continent_folders[i], "/")))
  list_rwls <- read_html(paste0(location, continent_folders[i]))  |>  # takes the page above for which we've read the html
    html_nodes("a")|>   # find all links in the page
    html_attr("href") |>  # get the url for these links
    str_subset("\\.rwl")
  for (j in 1:length(list_rwls)) {
    if (length(list_rwls)==0) { break }
    if (file.exists(paste0("measurements/", continent_folders[i], list_rwls[j]))){
      next
    } else {
      tryCatch({download.file(URLencode(paste0(location, continent_folders[i], list_rwls[j])),
                             paste0("measurements/", continent_folders[i], list_rwls[j]))},
               error = function(e){
                 print("An error occurred. Let's try again!")
                 download.file(URLencode(paste0(location, continent_folders[i], list_rwls[j])),
                               paste0("measurements/", continent_folders[i], list_rwls[j]))},
               warning = function(w){
                 print("An warning occurred. Let's try again!")
                 download.file(URLencode(paste0(location, continent_folders[i], list_rwls[j])),
                               paste0("measurements/", continent_folders[i], list_rwls[j]))}
                 )
    }
  }
  list_txt <- read_html(paste0(location, continent_folders[i]))  |>  # takes the page above for which we've read the html
    html_nodes("a")|>   # find all links in the page
    html_attr("href") |>  # get the url for these links
    str_subset("\\.txt")
  for (j in 1:length(list_txt)) {
    if (length(list_txt)==0) { break }
    if (file.exists(paste0("measurements/", continent_folders[i], list_txt[j]))){
      next
      } else {
        tryCatch({download.file(URLencode(paste0(location, continent_folders[i], list_txt[j])),
                               paste0("measurements/", continent_folders[i], list_txt[j]))},
                 error = function(e){
                   print("An error occurred. Let's try again!")
                   download.file(URLencode(paste0(location, continent_folders[i], list_txt[j])),
                                 paste0("measurements/", continent_folders[i], list_txt[j]))},
                 warning = function(w){
                   print("An warning occurred. Let's try again!")
                   download.file(URLencode(paste0(location, continent_folders[i], list_txt[j])),
                                 paste0("measurements/", continent_folders[i], list_txt[j]))}
        )
      }
  }
  list_zip <- read_html(paste0(location, continent_folders[i]))  |>  # takes the page above for which we've read the html
    html_nodes("a")|>   # find all links in the page
    html_attr("href") |>  # get the url for these links
    str_subset("\\.zip")
  for (j in 1:length(list_zip)) {
    if (length(list_zip)==0) { break }
    if (file.exists(paste0("measurements/", continent_folders[i], list_zip[j]))){
      next
    } else {
      tryCatch({download.file(URLencode(paste0(location, continent_folders[i], list_zip[j])),
                              paste0("measurements/", continent_folders[i], list_zip[j]))},
               error = function(e){
                 print("An error occurred. Let's try again!")
                 download.file(URLencode(paste0(location, continent_folders[i], list_zip[j])),
                               paste0("measurements/", continent_folders[i], list_zip[j]))},
               warning = function(w){
                 print("An warning occurred. Let's try again!")
                 download.file(URLencode(paste0(location, continent_folders[i], list_zip[j])),
                               paste0("measurements/", continent_folders[i], list_zip[j]))}
      )
    }
  }
}





