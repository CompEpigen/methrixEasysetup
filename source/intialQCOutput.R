

intialQCOutput <- function(id){
  
  moduleServer(
    id,
    function(input, output,session){
    
    report_dir <- renderPrint ({
      
      cat("methrix::methrix_report(\n
          meth = meth,\n
          output_dir = getwd(),\n
          prefix = \"initial\")")
    })
    
  })
}