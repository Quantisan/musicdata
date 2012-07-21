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

qtWorking <<-getQuantWorking(c(0,40,20,8,25,25,15,0,30,0,5,5,15))
