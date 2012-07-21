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

NAval <<- 0

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
    if(is.na(x)) {
      return(NAval)
    }
    return(quantWorking(x,valSet))
  }
  return(res)
}

#randomly created function to make variable "working" quantitative
qtWorking <<-getQuantWorking(c(0,40,20,8,25,25,15,0,30,0,5,5,40,15))

quantMusic <- function(music, valSet) {
  qualVal <- which(musicVals == music)
  return(valSet[qualVal])
}

getQuantMusic <- function(valSet) {
  res <- function(x) {
    if(is.na(x)) {
      return(NAval)
    }
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

distUsers <- function(u1,u2,usersData,qData,regAdd=0.5) {
  if(u1 == u2) {
    return(0)
  }
  row1 <- which(usersData[,1]==u1)
  row2 <- which(usersData[,1]==u2)
  tmpDist <- sum((qData[row1,]-qData[row2])^2)
  reg1 <- usersData[row1,regionCol]
  reg2 <- usersData[row2,regionCol]
  if(reg1!=reg2) {
    tmpDist <- tmpDist+regAdd
  }
  return(sqrt(tmpDist))
}


makeQuantData <- function(usersData) {
  #browser()
  quantData <- apply(usersData[,quantVars],2,as.numeric)
  quantData <- apply(quantData,c(1,2),function(x){ifelse(is.na(x),0,x)})
  quantData <- cbind(quantData,sapply(as.character(usersData[,2]),quantGender))
  quantData <- cbind(quantData,sapply(as.character(usersData[,4]),qtWorking))
  quantData <- cbind(quantData,sapply(as.character(usersData[,6]),qtMusic))
  quantData <- apply(quantData,2,function(x){x/sd(x,na.rm=TRUE)})
  rownames(quantData) <- usersData[,1]
  return(quantData)
}

calcDistMat <- function(usersData) {
  quantData <- usersData[,quantVars]
  quantData <- cbind(quantData,sapply(usersData[,4],qtWorking))
  quantData <- cbind(quantData,sapply(usersData[,6],qtMusic))
  quantData <- apply(quantData,2,function(x){x/sd(x)})
  usersIds <- usersData[,1]
  nUsers <- nrow(usersData)
  res <- matrix(ncol=nUsers,nrow=nUsers)
  for(i in 2:nUsers) {
    uI <- usersIds[i]
    for(j in 1:i) {
      uJ <- usersIds[j]
      if(i == j) {
        res[i,i] <- 0
      } else {
        tmp <- distUsers(uI,uJ,usersData,quantData)
        res[i,j] <- tmp
        res[j,i] <- tmp
      }
    }
  }
  return(res)
}

if(!exists("qData")) {qData <<- makeQuantData(users)}
if(!exists("clusts10")) {clusts10 <<- kmeans(qData,centers=10)}
if(!exists("tmpClusts10")) {tmpClusts10 <<- clusts10$cluster}

getUserCluster <-function(userId) {
  return(tmpCluster10[which(names(tmpCluster10)==userId)])
}

getArtistValOnClust <- function(artist,cluster) {
  
}

#calc average ranking of artist per cluster on train data.
calcAverageRanking <- function(trainData) {
  artists <- unique(trainData[,1])
  
}
