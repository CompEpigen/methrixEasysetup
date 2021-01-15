
previewbedGraphInput <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    verbatimTextOutput(ns("previewfilename")) 
    ,
    tableOutput(ns("previewtable"))%>%
      helper(type = "inline",
             title = "Preview of the first bedGraph file",
             content = c("The first five lines of the first bedgraph file can be previwed here",
                         "This preview space can be used to give the index for read_bedgraph() function"),
             size = "s")
  )
}