#merge words and train
#doing it manually...
getUserAndArtist <- function(user,artist) {
  res <- function(x) {
    (x[1]==artist) && (x[3] == user)
  }
}

nWords <- nrow(words)
#mergedTrain <- NULL

#words2 <- words[18283:nWords,]
#nWords <- nrow(words2)
mergedTest <- NULL
start <- 1
tmpSeq <- seq(start,nWords,1000)
nSeqs <- length(tmpSeq) - 1
for(j in 1:nSeqs) {
  #print(i)
  print(j)
  startBucket <- tmpSeq[j]
  endBucket <- tmpSeq[j+1]-1
  mergedTest2 <- NULL
  for(i in startBucket:endBucket) {
    ## if(i%%1000 == 0) {
    ##   print(i)
    ## }
    artist <- words[i,1]
    user <- words[i,2]
                                        #tmpFunc <- getUserAndArtist(user,artist)
    tmpData <- train[which(test[,3]==user),]
    if(nrow(tmpData) > 0 ) {
      tmpData <- tmpData[which(tmpData[,1]==artist),]
      
      #rating <- tmpData[,4]#train[which(apply(train,1,tmpFunc)),4]
      if(NROW(tmpData)>0) {
                                        #print("now filling stuff...")
        if(NROW(rating)>1) {
          rating <- mean(rating)
        }
        subData <- c(artist,user,words2[i,])
        mergedTrain2 <- rbind(mergedTrain2,subData)
      }
    }
  }
  mergedTest <- rbind(mergedTest,mergedTrain2)
}




train <<- train
#get sd of all artists
getSD <- function(artist) {
  return(sd(train[which(train[,1]==artist),4]))
}

artists <<- unique(train[,1])
sds <<- sapply(artists,getSD)


#merging test with words...
