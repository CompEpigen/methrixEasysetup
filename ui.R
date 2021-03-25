if (!requireNamespace("shiny", quietly = TRUE))
  install.packages("shiny")
if (!requireNamespace("shinydashboard", quietly = TRUE))
  install.packages("shinydashboard")
if (!requireNamespace("shinyFiles", quietly = TRUE))
  install.packages("shinyFiles")
if (!requireNamespace("data.table", quietly = TRUE))
  install.packages("data.table")
if (!requireNamespace("shinyjs", quietly = TRUE))
  install.packages("shinyjs")
if (!requireNamespace("rintrojs", quietly = TRUE))
  install.packages("rintrojs")
if (!requireNamespace("shinyBS", quietly = TRUE))
  install.packages("shinyBS")
if (!requireNamespace("magrittr", quietly = TRUE))
  install.packages("magrittr")
if (!requireNamespace("shinyhelper", quietly = TRUE))
  install.packages("shinyhelper")
if (!requireNamespace("workflowr", quietly = TRUE))
  install.packages("workflowr")
if (!requireNamespace("R.utils", quietly = TRUE))
  install.packages("R.utils")





library(shiny)
library(shinydashboard)
library(shinyFiles)
library(data.table)
library(shinyjs)
library(rintrojs)
library(shinyBS)
library(magrittr)
library(shinyhelper)
library(workflowr)
library(R.utils)



source('./source/bedgraphFilepathsServer.R')
source('./source/codeGeneration.R')
source('./source/codeGenerationInput.R')
source('./source/fileIn.R')
source('./source/intialQCOutput.R')
source('./source/preprocessInput.R')
source('./source/preprocessServer.R')
source('./source/preprocessUI.R')
source('./source/previewbedGraphInput.R')
source('./source/projectDetailsserver.R')
source('./source/projectDetailUIs.R')
source('./source/readInCode.R')
source('./source/readInParametersInput.R')
source('./source/sampleAnnotationUI.R')
source('./source/sampleAnnotationserver.R')
source('./source/navPageUI.R')
source('./source/tabChangeserver.R')
source('./source/dm_callingInput.R')
source('./source/dmcallingUI.R')
source('./source/dmcallingserver.R')

ui <- dashboardPage(
  dashboardHeader(
    title = "methrix Easy Setup"
  ),
  dashboardSidebar(
    disable = TRUE
  ),
  dashboardBody(
    navPageUI("read_in")
  )
)

