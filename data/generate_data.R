# Create some mock chpater veiw data

library(tidyverse)

users <- c('user1', 'user2', 'user3')

view_data <- data.frame(
  userid = character(),
  book = character(),
  chapter = numeric(),
  tstamp = character(),
  stringsAsFactors = FALSE
)

for (i in users) {
  for (k in 1:nrow(bible)) {
    p <- ifelse(i=='user1'&bible$testament[k]=='new',
                0.75,
                ifelse(i=='user2'&bible$testament[k]=='old',
                       0.75,
                       0.5
                )
    )
    read_book <- rbinom(1, 1, p)
    if (read_book == 1) {
      chapt <- chapters[chapters$book==bible$book[k], ]
      for (j in 1:nrow(chapt)) {
        views <- round(
          rnorm(1, mean = (-2 / 150) * j + 3, sd = 1
          )
        )
        views <- ifelse(views < 0, 0, views)
        if (views > 0) {
          for (l in 1:views) {
            temp_df <- data.frame(
              userid = i,
              book = bible$book[k],
              chapter = chapt$chapter[j],
              tstamp = '2019-05-01 12:30:00',
              stringsAsFactors = FALSE
            )
            view_data <- rbind(view_data, temp_df)
          }
        }
      }
    }
  }
}

write.table(
  view_data,
  file = 'views.csv',
  quote = FALSE,
  sep = ',',
  row.names = FALSE
)
