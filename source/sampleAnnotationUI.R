

sampleAnnotationUI <- function(id, label = label){
  
  ns <- NS(id)
  tagList(
    
    fileInput(
      inputId = ns("sampleanno"), 
      label = "Sample Annotation file",
      multiple = FALSE, 
      accept = ".csv", 
      buttonLabel = icon("Browse")
    ),
    
    tableOutput(
      outputId = ns("sampleannoTable")
    ),
    
    actionButton(
      inputId = ns("generateCode"),
      label = "Generate Code"
    )
    
  )
}