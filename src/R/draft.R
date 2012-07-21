if(!exists("test")) {test <- read.csv("test.csv")} #124794 * 4
if(!exists("train")) {train <- read.csv("train.csv")} #188690 * 5
if(!exists("users")) {users <- read.csv("users.csv")} #48645 * 27
if(!exists("words")) {words <- read.csv("words.csv")} #118301 * 88

#words: 50 artists, ~ 50k users

#train: 50 artists, ~ 50k users

#test: 50 artists, ~46k users
