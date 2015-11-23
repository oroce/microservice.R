config <- source("./config/index.R")$value
pkg <- source("./lib/utils/pkg.R")$value
report <- source("./lib/routes/report.R")$value
upload <- source("./lib/upload/index.R")$value
notify <- source("./lib/notify/index.R")$value

pkg("Rook")
pkg("webutils")

app <- Rhttpd$new()
app$add(
  name="my-app",
  app=Rook::URLMap$new(
    "/csv" = function(env){
      req <- Rook::Request$new(env)
      res <- Rook::Response$new()

      df <- report()

      body <- capture.output(
        write.table(df, quote = FALSE, sep = ",", eol = "\r\n")
      )

      query <- parse_query(req$query_string())

      if(!is.null(query$upload)){
        id <- upload(body)
        url <- paste0("https://drive.google.com/file/d/", id,"/view?usp=drivesdk")
        msg <- paste0("Report is published at: ", url)
        if (!is.null(query$notify)) {
          notify(msg)
        }
        res$header("Content-Type", "text/plain")
        res$write(msg)
        res$finish()
      } else {
        res$header("Content-Type", "text/plain")
        res$write(body)
        res$finish()
      }
    }
  )
)
app$start(listen="127.0.0.1", port=config$port, quiet=FALSE):

suspend_console()
