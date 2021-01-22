library(shinydashboard)
library(shinyFiles)
library(data.table)
library(shinyjs)
library(rintrojs)
library(shinyBS)
library(magrittr)
library(shinyhelper)



source('F:/methrixEasySetup/source/bedgraphFilepathsServer.R')
source('F:/methrixEasySetup/source/codeGeneration.R')
source('F:/methrixEasySetup/source/codeGenerationInput.R')
source('F:/methrixEasySetup/source/fileIn.R')
source('F:/methrixEasySetup/source/intialQCOutput.R')
source('F:/methrixEasySetup/source/preprocessInput.R')
source('F:/methrixEasySetup/source/preprocessServer.R')
source('F:/methrixEasySetup/source/preprocessUI.R')
source('F:/methrixEasySetup/source/previewbedGraphInput.R')
source('F:/methrixEasySetup/source/projectDetailsserver.R')
source('F:/methrixEasySetup/source/projectDetailUIs.R')
source('F:/methrixEasySetup/source/readInCode.R')
source('F:/methrixEasySetup/source/readInParametersInput.R')
source('F:/methrixEasySetup/source/sampleAnnotationUI.R')
source('F:/methrixEasySetup/source/sampleAnnotationserver.R')
source('F:/methrixEasySetup/source/navPageUI.R')
source('F:/methrixEasySetup/source/tabChangeserver.R')


ui <- dashboardPage(
  dashboardHeader(
    title = "methrix Easy Setup"
  ),
  dashboardSidebar(
    disable = TRUE
  ),
  dashboardBody(
    navbarPage(
      "",
      id = "mES1",
      tabPanel(
        "Start",
        value = "start",
        fluidRow( 
          column(
            width = 5,
            box(
              projectDetailsUI("read_in")
            )
          )
        )
      ),
      tabPanel(
        "Reading in the bedGraph files",
        value = "readIn",
        fluidRow(
          column(
            width = 4,
            box(
              title = "Select the file locally",
              width = NULL,
              fileIn("read_in")
            )
          ),
          column(
            width = 8,
            box(
              title = "Preview of the first bedGraph file",
              solidHeader = TRUE,
              width = NULL,
              status = "warning",
              previewbedGraphInput("read_in")
            ),
            
            readInParametersInput("read_in"),
            box(
              title = "Sample Annotation",
              solidHeader = TRUE,
              width = NULL,
              status = "warning",
              sampleAnnotationUI("read_in")
            ),
            box(
              title = "Generated Code",
              solidHeader = TRUE,
              width = NULL,
              status = "warning",
              readInCode ("read_in")
            )
          )
        )
      ),
      
      tabPanel(
        "Preprocessing, Normalization and QC",
        value = "preprocess",
        fluidRow(
          column(
            width = 3,
            box( width = NULL,
                 preprocessInput("read_in")
            )
          ),
          preprocessUI("read_in")
          
          
        )     
      )
    )
  )
)