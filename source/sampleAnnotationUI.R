

sampleAnnotationUI <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    shinyFilesButton(ns("Btn_GetFile"), 
                     "Choose a file" ,
                     title = "Please select a file:",
                     multiple = FALSE,
                     buttonType = "default", 
                     class = NULL),
    
    tableOutput(
      outputId = ns("sampleannoTable")
    ) 
  )
}