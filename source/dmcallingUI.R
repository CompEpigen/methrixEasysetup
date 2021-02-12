
dmcallingUI  <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    column(
      width = 8,
      box(
        width = NULL,
        title = "Differential Methylation Calling",
        
        verbatimTextOutput(ns("dmcode1")),
        verbatimTextOutput(ns("dmcode2")),
        verbatimTextOutput(ns("dmcode3")),
        verbatimTextOutput(ns("dmcode4"))
      )
    )
  )
}