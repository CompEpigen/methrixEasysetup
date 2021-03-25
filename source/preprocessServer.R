
preprocessServer <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      
      ns <- NS(id)
      observeEvent(input$mask_methrix,{
      if(input$mask_methrix == TRUE){
        output$maskmethrixtest <- renderUI(
          tagList(
            numericInput(
              inputId = ns("lowcount"),
              label = "Low-count value",
              value = 2,
              min = 0,
              max = 10000
            ),
            numericInput(
              inputId = ns("high_quantile"),
              label = "High-quantile",
              value = 0.99,
              min = 0,
              max = 1
            )
          )
        )
      } else {
        
      } 
      })
      
      observeEvent(input$coverage_filter,{
        if (input$coverage_filter == TRUE){
          output$removeUncoveredtest <- renderUI({
            tagList(
              numericInput(
                inputId = ns("cov_thr"),
                label = "Minimum Coverage",
                value = 5,
                min = 0,
                max = 1000
              ),
              numericInput(
                inputId = ns("min_samples"),
                label = "Minimum samples",
                value = 2,
                min = 0,
                max = 1000
              )
            )
          })
        } else {}
      })
      
      reportDirectory <- reactive({normalizePath("docs/", winslash = "/")})
      observeEvent(input$code2,{
        
     
      
      
      
      output$intialQC <- renderPrint ({
        
        
        cat("methrix::methrix_report(\n")
        cat("  meth = meth,\n")
        cat("  output_dir = \"", paste0(reportDirectory()),"\",\n", sep = ""   )
         cat(" prefix = \"initial\")")
         
      })
      
      output$maskMethrixCode <- renderPrint({
        
        if(input$mask_methrix == TRUE){
          cat("meth <- methrix::mask_methrix(\n")
          cat("meth,\n")
          cat("low_count = ",input$lowcount,",\n")
          cat("high_quantile = ",input$high_quantile,")")
          
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
          cat(" cov_thr =",input$cov_thr," ,\n")
          cat(" min_samples = ",input$min_samples," )")
        }
        
      })
      
      output$snpFiltering <- renderPrint({
        
        if (input$snpFiltering == TRUE){
          cat("meth <- methrix::remove_snps(m = meth, keep = TRUE)")
        }
       
      })
      
      output$methrixReport <- renderPrint({
        
        if(input$methrixreReport == TRUE){
          if(input$snpFiltering == TRUE){
            cat("methrix::methrix_report(meth = meth$snp_filtered,\n")
            cat("    output_dir = \"",paste0(reportDirectory()),"\",\n", sep = ""   )
            cat("    recal_stats = TRUE,\n")
            cat("    prefix=\"processed\")\n") 
          } else {
            
            cat("methrix::methrix_report(meth = meth,\n")
            cat("    output_dir = \"",paste0(reportDirectory()),"\",\n", sep = ""   )
            cat("    recal_stats = TRUE,\n")
            cat("    prefix=\"processed\")\n") 
          }
          
        }
        
       
      })
      
      output$plotsafterfiltering <- renderPrint({
        
        if(input$plotsafterfilter == TRUE){
          if(input$snpFiltering == TRUE){
            cat("methrix::plot_coverage(m=meth$snp_filtered, type=\"dens\")\n")
            #cat("methrix::pot_coverage(m=meth, type= \"dens\", pheno= \"Day\", perGroup = TRUE) \n")
            cat("methrix::plot_density(m=meth$snp_filtered)\n")
          } else {
            cat("methrix::plot_coverage(m=meth, type=\"dens\")\n")
            #cat("methrix::pot_coverage(m=meth, type= \"dens\", pheno= \"Day\", perGroup = TRUE) \n")
            cat("methrix::plot_density(m=meth)\n")
            #cat("#another functionality to be added") 
          } }
          
        
      })
      
      })
      
      observeEvent(input$tab3Next,{
        
      
      preprocessDirectory <- reactive({normalizePath("analysis/02_preprocess.Rmd", winslash = "/")})
      read_meth_filePath <- reactive({normalizePath("data/raw_methrix.RDS", winslash = "/")})
      
      
      

      
      sink(file = preprocessDirectory())
     

      
      cat("---\n")
      cat("title: \"preprocess\"\n")
      cat("author: ",input$authorName,"\n")
      cat("date: \'\`r format(Sys.time(), \"%d %B, %Y\")\`\'\n")
      cat("output:\n")
      cat("    workflowr::wflow_html:\n")
      cat("        toc: false\n")
      cat("        code_folding: \"hide\"\n")
      cat("editor_options:\n")
      cat("    chunk_output_type: console\n")
      cat("---\n")
      
      cat("\n\`\`\`{r read_RDS, message=FALSE, warning=FALSE}\n")
      cat(" #Read RDS object\n")
      cat(" meth <- readRDS(\"./data/raw_methrix.RDS\") ")
      cat("\n\`\`\`\n\n")
      
      cat("\`\`\`{r lib_2, message=FALSE, warning=FALSE }\n
        # Installing libraries\n")
      cat("library(methrix)\n")
      cat("library(data.table)\n")
      cat("library(pheatmap)\n")
      cat("\n")
      cat("\`\`\`\n")
      
      if ( input$initial_report == T){
        cat("# Initial QC and summary\n")
        cat(" Without any further processing, we can create an interactive html report containing basic summary statistics of the methrix object with methrix_report function. The report can also be accessed [here](initial_methrix_reports.html).\n")
        
        cat("\n\`\`\`{r meth_ini_report, echo=FALSE, cache=FALSE, results=FALSE, warning=FALSE, comment=FALSE, message=FALSE}\n
        # Intial QC\n")
        cat("methrix::methrix_report(\n")
        cat("  meth = meth,\n")
        cat("  output_dir = \"",paste0(reportDirectory()),"\",\n", sep = ""   )
        cat("  prefix = \"initial\")\n")
        cat("\n\`\`\`\n\n")
        
      }
      
      
      
      cat("# Filtering\n")
      cat("# Coverage based filtering\n")
      cat("To ensure the high quality of our dataset, the sites with very low (untrustworthy methylation level) or high coverage (technical problem) should not be used. We can mask these CpG sites. Please note, that the DSS we were using for Differential Methylation Region (DMR) calling, doesn’t need the removal of the lowly covered sites, because it takes it into account by analysis. However, using a not too restrictive threshold won’t interfere with DMR calling.\n")
      cat("Later we can remove those sites that are not covered by any of the samples.\n")
      cat("\`\`\`{r mask_meth, message=FALSE, warning=FALSE}\n
        # Coverage Filtering\n")
      
      if(input$mask_methrix == TRUE){
        
        cat("meth <- methrix::mask_methrix(\n")
        cat("       meth,\n")
        cat("       low_count = ",input$lowcount,",\n")
        cat("       high_quantile = ",input$high_quantile,")\n")
        
      }
      
      if(input$remove_uncovered == TRUE){
        cat("meth <- methrix::remove_uncovered(meth)\n")
      }
      
      
      if (input$coverage_filter == TRUE){
        cat(" meth <- methrix::coverage_filter(\n")
        cat(" m=meth,\n")
        cat(" cov_thr =",input$cov_thr," ,\n")
        cat(" min_samples = ",input$min_samples," )\n")
      }
      
      cat("\n\`\`\`\n\n")
      
      
      
      if (input$snpFiltering == TRUE){
        
        cat("# SNP filtering\n")
        cat("SNPs, mostly the C > T mutations can disrupt methylation calling. Therefore it is essential to remove CpG sites that overlap with common variants, if we have variation in our study population. For example working with human, unpaired data, e.g. treated vs. untreated groups. During filtering, we can select the population of interest and the minimum minor allele frequency (MAF) of the SNPs. SNP filtering is currently implemented for hg19 and hg38 assemblies.\n")
        
        cat("\`\`\`{r SNP_filtering, message=FALSE, warning=FALSE}\n")
        
        cat("# SNP Filtering\n\n")
        cat("meth <- methrix::remove_snps(m = meth, keep = TRUE)\n")
        cat(" meth <- meth[[1]]")
        
        cat("\n\`\`\`\n\n")
      }
      
      
      
      c
     
      if(input$methrixreReport == TRUE){
        
        cat("# Visualization and QC after filtering\n")
        cat("# Methrix report\n")
        cat("After filtering, it worth running a report again, to see if any of the samples were so lowly covered that it warrants an action (e.g. removal of the sample). The report can also be accessed [here](processed_methrix_reports.html)\n")
        cat("There are additional possibilities to visualize the study. We can look at the density of coverage both sample- and group-wise.\n")
        
        cat("\`\`\`{r meth_rereport, echo=FALSE, cache=FALSE, results=FALSE, warning=FALSE, comment=FALSE, message=FALSE}\n")
        
        
        cat("methrix::methrix_report(meth = meth,\n")
        cat("    output_dir = \"",paste0(reportDirectory()),"\",\n", sep = ""   )
        cat("    recal_stats = TRUE,\n")
        cat("    prefix=\"processed\")\n") 
        
        cat("\n\`\`\`\n\n")
        
        
      }
      
      if(input$plotsafterfilter == TRUE){
        cat("There are additional possibilities to visualize the study. We can look at the density of coverage both sample- and group-wise.\n")
        
        cat("\`\`\`{r plot_after_filter, message=FALSE, warning=FALSE}\n")
        cat("methrix::plot_coverage(m=meth, type=\"dens\")\n")
        #cat("methrix::pot_coverage(m=meth, type= \"dens\", pheno= \"Day\", perGroup = TRUE) \n")
        cat("methrix::plot_density(m=meth)\n")
        cat("\`\`\`\n")
        #cat("#another functionality to be added") 
        } 
      
     
      
      
      cat("\`\`\`{r save_obj_2, message=FALSE, warning=FALSE}\n")
      cat("\n")
      cat("# Saving object in workflow\n")
      cat("saveRDS(meth,\"./data/processed_methrix.RDS\")")
      cat("\n")
      cat("\`\`\`\n")
      })
    
      
      }
  )
}