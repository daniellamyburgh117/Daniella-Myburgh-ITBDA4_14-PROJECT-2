# Reading mapper output from standard input
con <- file("stdin", open = "r")

while (length(line <- readLines(
  con,
  n = 1,
  warn = FALSE
)) > 0) {
  
  cat(line)
  cat("\n")
}

close(con)