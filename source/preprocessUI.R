 

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
        verbatimTextOutput(ns("methrixReport")),
        h4("Plots after filtering"),
        verbatimTextOutput(ns("plotsafterfiltering"))
      )
      
    ),
    column (
      width=4,
      box(
        width = NULL,
        title = "Filtering",
        h4("Coverage based filtering"),
        h5("Mask Methrix"),
        verbatimTextOutput(ns("maskMethrixCode")),
        h5("Removing uncovered sites"),
        verbatimTextOutput(ns("coverageRemoval")),
        h5("Coverage filter"),
        verbatimTextOutput(ns("coverageFilter")),
        h4("SNP filtering"),
        verbatimTextOutput(ns("snpFiltering")),
      )
    )
  )
}