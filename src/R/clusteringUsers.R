userCol <<- 1
genderCol <<- 2
ageCol <<- 3
workingCol <<-4
regionCol <<- 5
musicCol <<- 6
listOwnCol <<- 7
listBackCol <<- 8
questsCols <<- 9:27

quantVars <<- c(3,9:27)

if(!exists("workingVals")) {workingVals <<- names(summary(users[,4]))}

if(!exists("musicVals")) {musicVals <<- names(summary(users[,6]))}
#making "gender" variable quantitative
quantGender <- function(gender) {
  return(ifelse(gender=="Female",1,0))
}

#making "working" variable quantitative
quantWorking <- function(working,valSet) {
  qualVal <- which(workingVals==working)
  res <- valSet[qualVal]
  return(res)
}

getQuantWorking <- function(valSet) {
  res <- function(x) {
    return(quantWorking(x,valSet))
  }
  return(res)
}

#randomly created function to make variable "working" quantitative
qtWorking <<-getQuantWorking(c(0,40,20,8,25,25,15,0,30,0,5,5,15))

quantMusic <- function(music, valSet) {
  qualVal <- which(musicVals == music)
  return(valSet[qualVal])
}

getQuantMusic <- function(valSet) {
  res <- function(x) {
    return(quantMusic(x,valSet))
  }
}

#randomly created function to make variable "music" quantitative
qtMusic <<- getQuantMusic(c(2,0,6,6,4,10))

#need to make REGION quantitative as well. the problem is that regions are not ordered in any way...

convertHours <- function(hour,naVal=0) {
  if(hour=="Less than an hour") {
    return(0)
  }
  if(hour == "More than 16 hours") {
    return(16)
  }
  if(hour == "") {
    return(naVal)
  }
  res <- strsplit(hour," ")[[1]][1]
  return(res)
}

distUsers <- function(u1,u2,usersData,qData) {
  if(u1 == u2) {
    return(0)
  }
}

calcDistMat <- function(usersData) {
  quantData <- usersData[,quantVars]
  quantData <- cbind(quantData,sapply(qtWorking,usersData[,4]))
  quantData <- cbind(quantData,sapply(qtMusic,usersData[,6]))
  quantData <- apply(quantData,2,function(x){x/sd(x)})
  
}
