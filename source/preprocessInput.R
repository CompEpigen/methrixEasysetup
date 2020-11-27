

preprocessInput <- function(id){
  
  tagList(
    
    checkboxInput(
      "report_dir",
      "Initial QC",
      
    ),
    
    checkboxInput(
      "coverageBasedFiltering",
      " Coverage based Filtering"
    ),
    
    checkboxInput(
      "snpFiltering",
      "SNP Filtering"
    ),
    
    checkboxInput(
      "methrixReport",
      "Methrix Report"
    ),
    
    actionButton(
      inputId = "code2",
      label = "Generate Code"
    )
  )
}