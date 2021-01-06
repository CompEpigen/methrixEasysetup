 

preprocessUI <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    column(
      width =4 ,
      box(
        width = NULL,
        title = "Intial QC",
        verbatimTextOutput(
          outputId = ns("intialQC")
          )
      ),
      
      box(
        width = NULL,
        title = "Visualization and QC after filtering",
        h4("Methrix Report"),
        verbatimTextOutput(ns("methrixReport"))
      )
      
    ),
    column (
      width=4,
      box(
        width = NULL,
        title = "Filtering",
        h4("Coverage based filtering"),
        verbatimTextOutput(ns("coverageBasedFiltering")),
        h5("Removing uncovered sites"),
        verbatimTextOutput(ns("coverageRemoval")),
        h4("SNP filtering"),
        verbatimTextOutput(ns("snpFiltering"))
      )
    )
  )
}