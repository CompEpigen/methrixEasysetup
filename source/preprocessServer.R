
preprocessServer <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      

      observeEvent(input$code2,{
        
     
      
      reportDirectory <- reactive({normalizePath("docs/", winslash = "/")})
      
      output$intialQC <- renderPrint ({
        req(input$projectDirectory)
        cat("methrix::methrix_report(\n")
        cat("  meth = meth,\n")
        cat("  output_dir = \"", paste0(reportDirectory()),"\",\n", sep = ""   )
         cat(" prefix = \"initial\")")
      })
      
      output$coverageBasedFiltering <- renderPrint({
        
        cat("meth <- methrix::mask_methrix(\n
          meth,\n
          low_count = 2,\n
          high_quantile = 0.99)")
      })
      
      output$coverageRemoval <- renderPrint({
        
        cat("meth <- methrix::remove_uncovered(meth)\n")
        cat(" meth <- methrix::coverage_filter(\n")
        cat(" m=meth,\n")
        cat(" cov_thr = 5,\n")
        cat(" min_samples = 2)")
      })
      
      output$snpFiltering <- renderPrint({
        cat("meth <- methrix::remove_snps(m = meth, keep = TRUE)")
      })
      
      output$methrixReport <- renderPrint({
        cat(" methrix::methrix_report(meth = meth,\n")
        cat(" output_dir = \"", paste0(reportDirectory()),"\",\n", sep = ""   )
        cat(" recal_stats = TRUE,\n")
        cat(" prefix=\"processed\")")
      })
      
      preprocessDirectory <- reactive({normalizePath("analysis/preprocess.Rmd", winslash = "/")})
      
      sink(file = preprocessDirectory())
      
      cat("---\n")
      cat("title: ",input$projectName,"\n")
      cat("author: ",input$authorName,"\n")
      cat("date: \'\`r format(Sys.time(), \"%d %B, %Y\")\`\'\n")
      cat("output: workflowr::wflow_html\n")
      cat("editor_options:\n")
      cat("\t chunk_output_type: console\n")
      cat("---\n")
      
      cat("\n\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n
        # Intial QC\n")
      cat("methrix::methrix_report(\n")
      cat("  meth = meth,\n")
      cat("  output_dir = \"", paste0(reportDirectory()),"\",\n", sep = ""   )
      cat(" prefix = \"initial\")")
      cat("\n\`\`\`\n\n")
      
      cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n
        # Coverage Filtering\n")
      cat("meth <- methrix::mask_methrix(\n
          meth,\n
          low_count = 2,\n
          high_quantile = 0.99)")
      cat("\n\`\`\`\n\n")
      
      cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n
        # Coverage Removal\n")
      cat("meth <- methrix::remove_uncovered(meth)\n")
      cat(" meth <- methrix::coverage_filter(\n")
      cat(" m=meth,\n")
      cat(" cov_thr = 5,\n")
      cat(" min_samples = 2)")
      cat("\n\`\`\`\n\n")
      
      cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n
        # SNP Filtering\n")
      cat("meth <- methrix::remove_snps(m = meth, keep = TRUE)")
      cat("\n\`\`\`\n\n")
      
      cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n
        # methrix Report\n")
      cat(" methrix::methrix_report(meth = meth,\n")
      cat(" output_dir = \"", paste0(reportDirectory()),"\",\n", sep = ""   )
      cat(" recal_stats = TRUE,\n")
      cat(" prefix=\"processed\")")
      cat("\n\`\`\`\n\n")
      
      })
    }
  )
}