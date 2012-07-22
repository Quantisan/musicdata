source('load-data.R')

super <- merge(train, users, by.x='User', by.y='RESPID', all.x=T)

words <- as.data.frame(apply(words,2,as.factor))
words$LIKE_ARTIST <- as.numeric(as.character(words$LIKE_ARTIST))
super <- merge(super, words, by=c("Artist", "User"), all.x=T)

super <- transform(super, 
                   Artist=factor(Artist, ordered=F),
                   User=factor(User, ordered=F),
                   Track=factor(Track, ordered=F))

train.words <- merge(train, words, by=c("Artist", "User"), all.x=T)
test.words <- merge(test, words, by=c("Artist", "User"), all.x=T)

require(randomForest)
#super.fix <- na.roughfix(super)
#users.fix <- na.roughfix(users)
tw.fix <- na.roughfix(train.words)
testw.filled <- na.roughfix(test.words)

mdl.lm <- lm(Rating ~ ., data=tw.fix)
out <- predict(mdl.lm, testw.filled)
write.table(as.data.frame(out), file="../../data/rflm.csv", row.names=F, col.name=F, sep=",")