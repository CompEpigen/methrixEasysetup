
library(shinydashboard)
library(shinyFiles)
library(data.table)
library(shinyjs)
library(rintrojs)
library(shinyBS)

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
            width = 4,
            box(
              projectDetailsUI("Details of the project")
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
              fileIn("filein"))
          ),
          column(
            width = 8,
            box(
              title = "Preview of the first bedGraph file",
              solidHeader = TRUE,
              width = NULL,
              status = "warning",
              verbatimTextOutput("previewfilename"),
              tableOutput("previewtable")
              ),
           
              readInParametersInput("read_in"),
            box(
              title = "Sample Annotation",
              solidHeader = TRUE,
              width = NULL,
              status = "warning",
              sampleAnnotationUI()
            ),
            box(
              title = "Generated Code",
              solidHeader = TRUE,
              width = NULL,
              status = "warning",
              verbatimTextOutput("generatedCode"),
              actionButton(
                inputId = "tab2Previous",
                label = "Previous",
                icon = icon("arrow-left")
              ),
              actionButton(
                inputId = "startWorkflowR",
                label = "Start WorkflowR"
              ),
              actionButton(
                inputId = "tab2Next",
                label = "Next",
                icon = icon("arrow-right")
              )
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
              preprocessInput()
            )
            ),
            column(
              width =4 ,
              box(
                width = NULL,
                title = "Intial QC",
                verbatimTextOutput("intialQC")
              ),
              
              box(
                width = NULL,
                title = "Visualization and QC after filtering",
                h4("Methrix Report"),
                verbatimTextOutput("methrixReport")
              )
              
            ),
          column (
            width=4,
            box(
              width = NULL,
              title = "Filtering",
              h4("Coverage based filtering"),
              verbatimTextOutput("coverageBasedFiltering"),
              h5("Removing uncovered sites"),
              verbatimTextOutput("coverageRemoval"),
              h4("SNP filtering"),
              verbatimTextOutput("snpFiltering")
            )
          )
            
          
        )     
      )
    )
  )
)