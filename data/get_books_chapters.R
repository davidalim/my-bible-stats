# Get books and chapters of the Bible

library(XML)
library(RCurl)
library(rlist)
theurl <- getURL("https://www.neverthirsty.org/bible-qa/qa-archives/question/how-many-chapters-verses-and-words-are-in-the-bible/",.opts = list(ssl.verifypeer = FALSE) )
tables <- readHTMLTable(theurl)
tables <- list.clean(tables, fun = is.null, recursive = FALSE)

ot <- tables$`Old Testament Statistics`
nt <- tables$`New Testament Statistics`

ot <- ot[2:nrow(ot), 1:2]
ot$V3 <- rep('old', nrow(ot))
nt <- nt[2:nrow(nt), 1:2]
nt$V3 <- rep('new', nrow(nt))

bible <- rbind(ot, nt)
colnames(bible) <- c("book", "chapters", "testament")
bible$book <- as.character(bible$book)
bible$chapters <- as.numeric(as.character(bible$chapters))

expand_chapters <- function(df = bible) {
  chpt <- data.frame(
    book = character(),
    chapter = numeric(),
    testament = character(),
    stringsAsFactors = FALSE
  )
  for (i in 1:nrow(df)) {
    temp <- data.frame(
      book = rep(df$book[i], df$chapters[i]),
      chapter = 1:df$chapters[i],
      testament = rep(df$testament[i], df$chapters[i]),
      stringsAsFactors = FALSE
    )
    chpt <- rbind(chpt, temp)
  }
  return(chpt)
}

chapters <- expand_chapters(bible)
books <- bible

write.table(
  books,
  file = 'books.csv',
  quote = FALSE,
  sep = ',',
  row.names = FALSE
)
write.table(
  chapters,
  file = 'chapters.csv',
  quote = FALSE,
  sep = ',',
  row.names = FALSE
)
