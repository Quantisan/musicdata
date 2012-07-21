#setwd("~/Rcode/hackathonMusic/musicdata/src/R")

if(!exists("test")) {test <- read.csv("../../data/test.csv")} #125794 * 4
if(!exists("train")) {train <- read.csv("../../data/train.csv")} #188690 * 5
if(!exists("users")) {users <- read.csv("../../data/users.csv")} #48645 * 27
if(!exists("words")) {words <- read.csv("../../data/words_proper.csv")} #118301 * 88
if(!exists("userKey")) {userKey <-  read.csv("../../data/UserKey.csv")}
#words: 50 artists, ~ 50k users

#train: 50 artists, ~ 50k users

#test: 50 artists, ~46k users

#all users in test and train are in words
# *almost* all users in test and train are in users dataset.
# *almost* all users in test are in train
#all artists in test are in train.


getArtistTime <- function(artist,time) {
  artistCol <- 1
  timeCol <- 5
  res <- function(x){
    (x[artistCol]==artist) && (x[timeCol]==time) 
  }
}
