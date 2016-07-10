library('RMySQL')

#Establish connection with SQL database
con <- dbConnect(MySQL(),
                 user="healec", password="*****",
                 dbname="employees", host="localhost")
on.exit(dbDisconnect(con))

#Perform Queries and have them saved in a dataframe//
rs <- dbGetQuery(con, "SELECT * FROM departments;")
