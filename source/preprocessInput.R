

preprocessInput <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    checkboxInput(
      ns("report_dir"),
      "Initial QC",
      
    ),
    
    checkboxInput(
      ns("coverageBasedFiltering"),
      " Coverage based Filtering"
    ),
    
    checkboxInput(
      ns("snpFiltering"),
      "SNP Filtering"
    ),
    
    checkboxInput(
      ns("methrixReport"),
      "Methrix Report"
    ),
    
    actionButton(
      inputId = ns("code2"),
      label = "Generate Code"
    )
  )
}