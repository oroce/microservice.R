pkg <- source("./lib/utils/pkg.R")$value
config <- source("./config/index.R")$value

usePackage("httr")

notify <- function(msg) {
  res <- httr::POST(
    config$slackurl,
    body = list(
      text = msg
    ),
    encode = "json"
  )
  body <- content(res, as = "text")
}
