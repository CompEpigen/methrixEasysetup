
preprocessServer <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      

      observeEvent(input$code2,{
        
     
      
      # reportDirectory <- reactive({normalizePath("docs/", winslash = "/")})
      
      output$intialQC <- renderPrint ({
        
        
        cat("methrix::methrix_report(\n")
        cat("  meth = meth,\n")
        # cat("  output_dir = \"", paste0(reportDirectory()),"\",\n", sep = ""   )
         cat(" prefix = \"initial\")")
         
      })
      
      output$maskMethrixCode <- renderPrint({
        
        if(input$mask_methrix == TRUE){
          cat("meth <- methrix::mask_methrix(\n")
          cat("meth,\n")
          cat("low_count = 2,\n")
          cat("high_quantile = 0.99)")
          
        }
        
        
      })
      
      output$coverageRemoval <- renderPrint({
        
        if(input$remove_uncovered == TRUE){
          cat("meth <- methrix::remove_uncovered(meth)\n")
          
          
        }
        
       
      })
      
      output$coverageFilter <- renderPrint({
        
        if (input$coverage_filter == TRUE){
          cat(" meth <- methrix::coverage_filter(\n")
          cat(" m=meth,\n")
          cat(" cov_thr = 5,\n")
          cat(" min_samples = 2)")
        }
        
      })
      
      output$snpFiltering <- renderPrint({
        
        if (input$snpFiltering == TRUE){
          cat("meth <- methrix::remove_snps(m = meth, keep = TRUE)")
        }
       
      })
      
      output$methrixReport <- renderPrint({
        
        if(input$methrixreReport == TRUE){
          cat(" methrix::methrix_report(meth = meth,\n")
          # cat(" output_dir = \"", paste0(reportDirectory()),"\",\n", sep = ""   )
          cat(" recal_stats = TRUE,\n")
          cat(" prefix=\"processed\")")
          
        }
        
       
      })
      
      output$plotsafterfiltering <- renderPrint({
        
        if(input$plotsafterfilter == TRUE){
          
          cat("methrix::plot_coverage(m=meth. type=\"dens\"\n
              methrix::pot_coverage(m=meth, type= \"dens\", pheno= \"Day\", perGroup = TRUE \n
              methrix::plot_density(m=meth)\n
              #another functionality to be added")
          
        }
      })
      
      # preprocessDirectory <- reactive({normalizePath("analysis/preprocess.Rmd", winslash = "/")})
      
      # sink(file = preprocessDirectory())
      sink("R.Rmd")
      
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
      # cat("  output_dir = \"", paste0(reportDirectory()),"\",\n", sep = ""   )
      cat(" prefix = \"initial\")")
      cat("\n\`\`\`\n\n")
      
      cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n
        # Coverage Filtering\n")
      if(input$mask_methrix == TRUE){
        cat("meth <- methrix::mask_methrix(\n")
        cat("meth,\n")
        cat("low_count = 2,\n")
        cat("high_quantile = 0.99)") }
      
      if(input$remove_uncovered == TRUE){
        cat("meth <- methrix::remove_uncovered(meth)\n")
      }
      
      
      if (input$coverage_filter == TRUE){
        cat(" meth <- methrix::coverage_filter(\n")
        cat(" m=meth,\n")
        cat(" cov_thr = 5,\n")
        cat(" min_samples = 2)")
      }
      
      cat("\n\`\`\`\n\n")
      
      
      
      cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n")
      
      if (input$snpFiltering == TRUE){
        cat("# SNP Filtering\n\n")
        cat("meth <- methrix::remove_snps(m = meth, keep = TRUE)")
      }
      
      cat("\n\`\`\`\n\n")
      
      cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n")
     
      if(input$methrixreReport == TRUE){
        cat(" methrix::methrix_report(meth = meth,\n")
        # cat(" output_dir = \"", paste0(reportDirectory()),"\",\n", sep = ""   )
        cat(" recal_stats = TRUE,\n")
        cat(" prefix=\"processed\")\n") 
        
      }
      
      if(input$plotsafterfilter == TRUE){
        
        cat("methrix::plot_coverage(m=meth. type=\"dens\"\n
              methrix::pot_coverage(m=meth, type= \"dens\", pheno= \"Day\", perGroup = TRUE \n
              methrix::plot_density(m=meth)\n
              #another functionality to be added") }
      
      cat("\n\`\`\`\n\n")
      
      })
    }
  )
}