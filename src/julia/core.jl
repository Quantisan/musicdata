users = csvread("/Users/paullam/Dropbox/Projects/musicdata/data/users.csv");  ## couldn't get getcwd() working
train = csvread("/Users/paullam/Dropbox/Projects/musicdata/data/train.csv");
test = csvread("/Users/paullam/Dropbox/Projects/musicdata/data/test.csv");
words = csvread("/Users/paullam/Dropbox/Projects/musicdata/data/words_proper.csv");

userid = intset();
for id in train[2:, 3]
	add(userid, int(id))
end

uscore = zeros(Float, max(userid) + 1);
for i in 2:size(train, 1)
	(artist, track, user, rating, time) = train[i, :]...
	id = int(user) + 1  ## user id starts from 0
	prevscore = uscore[id]
	divider = prevscore == 0.0 ? 1 : 2
	uscore[id] = (uscore[id] + rating) / divider
end

outrating = Array(Float, size(test,1) - 1);
for i in 2:size(test, 1)
	(artist, track, user, time) = train[i, :]...
	id = int(user) + 1  ## user id starts from 0
	outrating[i-1] = uscore[id]
end

csvwrite("/Users/paullam/Dropbox/Projects/musicdata/julia.csv", outrating)