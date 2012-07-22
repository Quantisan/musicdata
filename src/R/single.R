source('load-data.R')

super <- merge(train, users, by.x='User', by.y='RESPID', all.x=T)

words <- as.data.frame(apply(words,2,as.factor))
words$LIKE_ARTIST <- as.numeric(as.character(words$LIKE_ARTIST))
super <- merge(super, words, by=c("Artist", "User"), all.x=T)

super <- transform(super, 
                   Artist=factor(Artist, ordered=F),
                   User=factor(User, ordered=F),
                   Track=factor(Track, ordered=F))

require(randomForest)
super.fix <- na.roughfix(super)
users.fix <- na.roughfix(users)

require(party)
#super.tr <- ctree(Rating ~ ., data=super.fix)