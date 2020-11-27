

sampleAnnotationUI <- function(id){
  
  tagList(
    
    fileInput(
      inputId = "sampleanno", 
      label = "Sample Annotation file",
      multiple = FALSE, 
      accept = ".csv", 
      buttonLabel = icon("Browse")
    ),
    
    tableOutput(
      outputId = "sampleannoTable"
    ),
    
    actionButton(
      inputId = "generateCode",
      label = "Generate Code"
    )
    
  )
}