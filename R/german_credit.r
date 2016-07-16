# read in data line by line from a text file
Germ_schema<-readLines('/Users/chris_heale/Desktop/Data_science/Data/German_Credit/german.doc')
#Use reg expressions to find all the lines with A** in it.
schema<-grep('A[0-9]',Germ_schema,value = T)
#Use regular expressions to find all the A values and store note that \\1 finds the first grouping (in brackets)
LHS<-sub(".*(A[0-9][0-9].) :(.*)","\\1",schema)
#Use regular expressions to find all the meanings and store, note tat \\2 finds the second grouping (in brackets)
LHS<-sub(".*(A[0-9][0-9]*) :(.*)","\\2",schema[1:3])
#Alternately you can use for the A**
LHS<-regmatches(schema,regexpr("A[0-9][0-9]*",schema))
#And for the meanings
RHS<-regmatches(schema,regexpr(":.*",schema))
#Find the headers and add the classification variable
headers<-str_trim(Germ_schema[grep("Attribute [0-9]",Germ_schema)+1],side='left')
headers<-c(headers,"Good Loan")

#Load the german credit data itself
German_credit<-read.table("/Users/chris_heale/Desktop/Data_science/Data/German_Credit/germancredit.data",stringsAsFactors=F,header=F,sep='')
#Assign column names
colnames(German_credit)<-headers
#Assign A** values to the German Credit
for (i in 1:dim(German_credit)[1]){
  for (j in 1:dim(German_credit)[2]){
    if (!is.na(match(German_credit[i,j],LHS))){
    German_credit[i,j]<-RHS[match(German_credit[i,j],LHS)]}}}


