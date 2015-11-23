pkg <- source("./lib/utils/pkg.R")$value

pkg("dotenv")

envfile <- "./.env"
if (file.exists(envfile)) {
  dotenv::load_dot_env(file = envfile)
}


getenv <- function(ref, default = "") {
  val <- Sys.getenv(ref)
  ifelse(val != '', val, default)
}

config <- list(
  port = getenv("PORT", 9000),
  google = list(
    client_email = getenv("GOOGLE_AUTH_CLIENT_EMAIL"),
    private_key = gsub("\\\\n", "\n",getenv('GOOGLE_AUTH_PRIVATE_KEY'))
  ),
  drive = list(
    parentfolder = getenv("GOOGLE_DRIVE_PARENT_FOLDER"),
    domain = getenv("GOOGLE_DRIVE_DOMAIN")
  ),
  slackurl = getenv("SLACK_URL")
)
