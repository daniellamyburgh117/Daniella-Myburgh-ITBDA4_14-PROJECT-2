# Getting the keyword from the command line

keyword <- "africa"

# Escape special regex characters
keyword_safe <- gsub(
  "([][{}()+*^$|\\\\?.])",
  "\\\\\\1",
  keyword
)

# Exacting word matching
pattern <- paste0(
  "\\b",
  keyword_safe,
  "\\b"
)

# Reading data from Hadoop standard input
con <- file("stdin", open = "r")

row_number <- 0

while (length(line <- readLines(
  con,
  n = 1,
  warn = FALSE
)) > 0) {
  
  row_number <- row_number + 1
  
  # Getting current filename from Hadoop
  file_name <- Sys.getenv(
    "mapreduce_map_input_file"
  )
  
  if (file_name == "") {
    file_name <- "unknown_file"
  } else {
    file_name <- basename(file_name)
  }
  
  # Searching for the keyword
  matches <- gregexpr(
    pattern,
    line,
    ignore.case = TRUE,
    perl = TRUE
  )[[1]]
  
  # Outputting every match
  if (matches[1] != -1) {
    
    for (column_number in matches) {
      
      cat(
        file_name,
        paste0(
          "Row: ",
          row_number,
          ", Column: ",
          column_number
        ),
        sep = "\t"
      )
      
      cat("\n")
    }
  }
}

close(con)