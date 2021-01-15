

readInCode <- function(id){
 
    
    ns <- NS(id)
    tagList(
      verbatimTextOutput(ns("generatedCode1")),
      verbatimTextOutput(ns("generatedCode2")),
      verbatimTextOutput(ns("generatedCode3")),
      verbatimTextOutput(ns("generatedCode4")),
      actionButton(
        inputId = ns("tab2Previous"),
        label = "Previous",
        icon = icon("arrow-left")
      ),
     
      actionButton(
        inputId = ns("tab2Next"),
        label = "Next",
        icon = icon("arrow-right")
      ),
      h5("Note: On clicking Next, read_in.Rmd file will be created in analysis folder of the workflow project that was created previously."),
      
    )
  }
