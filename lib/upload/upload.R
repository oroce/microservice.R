pkg <- source("lib/utils/pkg.R")$value
pkg("jsonlite")

upload <- function (accesstoken = "", content = "") {
  # docs: https://developers.google.com/drive/v2/reference/files/insert
  uri <- "https://www.googleapis.com/drive/v2/files"
  filename <- paste0("my-report of ", format(Sys.time()))
  res <- httr::POST(
    uri,
    body = list(
      title = filename,
      mimeType = "application/vnd.google-apps.spreadsheet"
    ),
    query = list(
      convert = "true"
    ),
    encode = "json",
    add_headers(
      Authorization = paste0('Bearer ', accesstoken)
    )
  )

  body <- content(res)

  id <- body$id

  uploadUri <- paste0("https://www.googleapis.com/upload/drive/v2/files/", id)

  res <- httr::PUT(
    uploadUri,
    body = content,
    encode = "form",
    query = list(
      uploadType = "media"
    ),
    add_headers(
      Authorization = paste0("Bearer ", accesstoken),
      "Content-Type" = "text/csv"
    )
  )

  body <- content(res)

  id
}
