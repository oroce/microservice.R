local({
  r <- getOption("repos")
  r["CRAN"] <- "http://cran.r-project.org"
   options(repos=r)
})

# the magic is from here: http://www.salemmarafi.com/code/install-r-package-automatically/
# install package it isn't and load it
# if it's installed just load it
usePackage <- function(p)
{
  if (!is.element(p, installed.packages()[,1]))
    install.packages(p, dep = TRUE)
  require(p, character.only = TRUE)
}
