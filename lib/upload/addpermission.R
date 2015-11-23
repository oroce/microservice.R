config <- source("./config/index.R")$value
addpermission <- function (accesstoken = "", id = "") {
  # docs: https://developers.google.com/drive/v2/reference/permissions/insert
  uri <- paste0("https://www.googleapis.com/drive/v2/files/", id, "/permissions")

  res <- httr::POST(
    uri,
    body = list(
      role = "writer",
      type = "domain",
      value = config$drive$domain
    ),
    encode = "json",
    add_headers(
      Authorization = paste0("Bearer ", accesstoken)
    )
  )

  body <- content(res)
}
