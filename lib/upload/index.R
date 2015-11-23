pkg <- source("./lib/utils/pkg.R")$value
config <- source("./config/index.R")$value
uploadfile <- source("./lib/upload/upload.R")$value
setparent <- source("./lib/upload/setparent.R")$value
addpermission <- source("./lib/upload/addpermission.R")$value

pkg("httr")
pkg("jsonlite")


run <- function(content = "") {

  secrets <- config$google
  endpoint <- oauth_endpoints("google")
  scope <- "https://www.googleapis.com/auth/drive"
  token <- oauth_service_token(endpoint, list(
    private_key = secrets$private_key,
    client_email = secrets$client_email
  ), scope)

  accesstoken <- token$credentials$access_token

  id <- uploadfile(accesstoken, content)

  if (config$drive$parentfolder != '') {
    setparent(accesstoken, config$drive$parentfolder, id)
  }
  addpermission(accesstoken, id)

  return(id)
}
