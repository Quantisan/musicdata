source('load-data.R')

super <- merge(train, users, by.x='User', by.y='RESPID', all.x=T)

words <- as.data.frame(apply(words,2,as.factor))
super <- merge(super, words, by=c("Artist", "User"), all.x=T)

super <- transform(super, 
                   Artist=factor(Artist, ordered=F),
                   User=factor(User, ordered=F),
                   Track=factor(Track, ordered=F))

require(randomForest)
super.fix <- na.roughfix(super)
users.fix <- na.roughfix(users)