# Check and install packages if needed
packages <- c("readxl","RStata","reticulate", "shiny", "bslib", "ggthemes", "RColorBrewer", "sf", "shinythemes", "lubridate", "jsonlite",
              "stringr", "readr", "dplyr", "tidyverse", "shinyjs", "plotly", "ggplot2", "DT", "shinyWidgets",
              "shinydashboard", "shinycssloaders", "cowplot", "ggmap", "ggspatial", "rmarkdown", "rgdal", "fontawesome", "haven", "readxl", "gridExtra", "scales", "writexl", "openxlsx"
)


install_packages <- packages[!sapply(packages, requireNamespace, quietly = TRUE)]

if (length(install_packages) > 0) {
  install.packages(install_packages)
}

# Load packages

library(shiny)
library(bslib)
library(ggthemes)
library(RColorBrewer)
library(sf)
library(shinythemes)
library(lubridate)
library(jsonlite)
library(stringr)
library(readr)
library(dplyr)
library(tidyverse)
library(shinyjs)
library(plotly)
library(ggplot2)
library(DT)
library(shinyWidgets)
library(shinydashboard)
library(bslib)
library(shinycssloaders)
library(ggmap)
library(ggspatial)
library(rmarkdown)
library(rgdal)
library(fontawesome)
library(haven)
library(readxl)
library(scales)
library(writexl)
library(openxlsx)
library(gridExtra)
library(cowplot)

