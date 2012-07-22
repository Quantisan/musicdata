wordsKeyed <- cbind(paste(words[,1],words[,2]),words)
testKeyed <- cbind(paste(test[,1],test[,3]),test)
trainKeyed <- cbind(paste(train[,1],train[,3]),train)

names(wordsKeyed)[1] <- "key"
names(testKeyed)[1] <- "key"
names(trainKeyed)[1] <- "key"

dataReg <- merge(wordsKeyed,trainKeyed,by="key")
dataToPredict <- merge(wordsKeyed,testKeyed,by="key")
