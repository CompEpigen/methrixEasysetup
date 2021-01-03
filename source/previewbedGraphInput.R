
previewbedGraphInput <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    verbatimTextOutput(ns("previewfilename"))
    ,
    tableOutput(ns("previewtable"))
  )
}