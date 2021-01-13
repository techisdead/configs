
# Can select whether you want to reinstall or install only if not present
# pck: package name or GH repo
# ignore_installed: defaults to FALSE
# source: github or cran (default cran).
#
install_me <- function(pck, ignore_installed = FALSE, source = "CRAN"){

  if(!require(remotes)){stop("Install remotes first please")}
  match.arg(source, c("CRAN", "github"))
  stopifnot( is.logical(ignore_installed))

  if(isTRUE(ignore_installed)) {

    switch (source,
            CRAN = { install.packages(pck) },
            github = { remotes::install_github(pck) },
            "Please choose CRAN or github as source"
    )

  }else {

    if(!require(gsub(".*\\/","", pck), character.only = TRUE, quietly = TRUE)){
      print( paste0( "Installing ", pck) )

      switch (source,
              CRAN = { install.packages(pck) },
              github = { remotes::install_github(pck) },
              "Please choose CRAN or github as source"
      )

      stopifnot(require(gsub(".*\\/","", pck), character.only = TRUE, quietly = TRUE)  )


    }
  }
  invisible(return(NULL))
}

#install.packages("remotes")
# force update lattice - problem with the version in R4.0 not updating autoamtically
#install.packages("lattice")
#install.packages("boot")

## The basics
lapply(c("data.table", "ggplot2", "remotes", "glue"
         , "units", "vctrs", "Rcpp", "magrittr", "reticulate",
         "RPostgres", "scales"),
       install_me, ignore_installed = FALSE, source = "CRAN")

#package dev basics
lapply(
  c( "usethis","devtools", "testthat", "here")
  , install_me, ignore_installed = FALSE, source = "CRAN")



## Install connections
lapply(
  c( "DBI", "RMariaDB", "readxl", "mongolite", "RAthena" )
  , install_me, ignore_installed = FALSE, source = "CRAN")


# writing and editing
lapply( c("knitr","rmarkdown", "bookdown", "blogdown", "distill"
          ,"english", "kableExtra","xaringan", "xaringanthemer")
        , install_me, ignore_installed = FALSE, source = "CRAN")

# web apps
lapply(
  c("shiny", "shinyjs", "htmlwidgets","shinycssloaders",
    "shinydashboard", "shinyFiles", "shinythemes",
    "shinyTree" ,"shinyWidgets")
  , install_me, ignore_installed = FALSE, source = "CRAN")

# data eng
lapply(
  c("arrow", "aws.signature","aws.s3", "base64enc"
    ,"covr", "httr")
  , install_me, ignore_installed = FALSE, source = "CRAN")

# modelling and data science
lapply(
  install.packages(c("binom", "lme4", "glmmTMB","DHARMa", "Distance","survival","MASS",
                     "mgcv","keras"))
  ,install_me, ignore_installed = FALSE, source = "CRAN")

# pretties
lapply(
  install.packages(c("corrplot","DT", "patchwork","RColorBrewer", "viridis",
                     "viridisLite"))
  ,install_me, ignore_installed = FALSE, source = "CRAN")

# project stuff
lapply(
  c("audio")
  ,install_me, ignore_installed = FALSE, source = "CRAN")

# fun
lapply( c("fortunes")
        ,install_me, ignore_installed = FALSE, source = "CRAN")


# spatial
lapply(
  c("rgeos", "sf", "dodgr", "ggmap")  # for symbolix.utils
  ,install_me, ignore_installed = FALSE, source = "CRAN")


# our stuff - opensource not on CRAN
lapply(
  c("SymbolixAU/clubhouser")
  ,install_me, ignore_installed = FALSE, source = "github")

# Our stff - cran
lapply(
  c("colourvalues", "geojsonsf","googleway", "googlePolylines"
    , "jsonify", "mapdeck","sfheaders")
  ,install_me, ignore_installed = FALSE, source = "CRAN")

# our stuff - private
lapply( c("SymbolixAU/symbolix.utils"
          ,"SymbolixAU/SymbolixTemplates"
          , "SymbolixAU/blacrm"
          , "SymbolixAU/datatests")
        ,install_me, ignore_installed = FALSE, source = "github")

