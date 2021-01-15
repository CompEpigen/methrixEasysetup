

sampleAnnotationUI <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    shinyFilesButton(ns("Btn_GetFile"), 
                     "Choose a file" ,
                     title = "Please select a file:",
                     multiple = FALSE,
                     buttonType = "default", 
                     class = NULL) %>%
      helper(type = "inline",
             title = "Sample Annotation file",
             content = c(" Choose a sample annotation file from the local storage. ",
                         "Note:",
                         "1. Make sure it is tab seperated file.",
                         "2. Make sure the sample annotation is filed alpha-numeric wise since the bedGraph files will be added in an alphabetically."),
             size = "s"),
    
    tableOutput(
      outputId = ns("sampleannoTable")
    ) 
  )
}