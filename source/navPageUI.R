

navPageUI <- function(id, label= label){
  
  ns <- NS(id)
  
  navbarPage(
    "",
    id = ns("mES1"),
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
            
            previewbedGraphInput("read_in")
          ),
          
          readInParametersInput("read_in"),
          box(
            title = "Sample Annotation",
            solidHeader = TRUE,
            width = NULL,
            
            sampleAnnotationUI("read_in")
          ),
          box(
            title = "Generated Code",
            solidHeader = TRUE,
            width = NULL,
            
            readInCode ("read_in")
          )
        )
      )
    ),
    
    tabPanel(
      " QC and Reports",
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
    ),
    
    tabPanel(
      "Differential methylation calling",
      value = "dm_calling",
      fluidRow(
        column(
          width = 3,
          box( width = NULL,
               dm_callingInput("read_in")
          )
        ),
        
        dmcallingUI("read_in")
        
        
        
      )     
    )
  )
}