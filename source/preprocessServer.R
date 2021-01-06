
preprocessServer <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      
      output$intialQC <- renderPrint ({
        
        cat("methrix::methrix_report(\n
          meth = meth,\n
          output_dir = getwd(), \n
          prefix = \"initial\")")
      })
      
      output$coverageBasedFiltering <- renderPrint({
        
        cat("meth <- methrix::mask_methrix(\n
          meth,\n
          low_count = 2,\n
          high_quantile = 0.99)")
      })
      
      output$coverageRemoval <- renderPrint({
        
        cat("meth <- methrix::remove_uncovered(meth)\n
          meth <- methrix::coverage_filter(\n
          m=meth,\n
          cov_thr = 5,\n
          min_samples = 2)")
      })
      
      output$snpFiltering <- renderPrint({
        cat("meth <- methrix::remove_snps(m = meth, keep = TRUE)")
      })
      
      output$methrixReport <- renderPrint({
        cat(" methrix::methrix_report(meth = meth,\n
          output_dir = getwd(),\n
          recal_stats = TRUE,\n
          prefix=\"processed\")")
      })
    }
  )
}