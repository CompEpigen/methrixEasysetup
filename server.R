

server <-   function(input, output, session){
  
  observeEvent(input$tab1Next,{
    updateTabsetPanel(session, 
                      "mES1",
                      selected = "readIn")
  })
  
  
  observeEvent(input$tab2Previous,{
    updateTabsetPanel(session,
                      "mES1",
                      selected = "start")
  })
  
  observeEvent(input$tab2Next,{
    updateTabsetPanel(session,
                      "mES1",
                      selected = "preprocess")
  })
  
  
  bedgraphFilepathsServer("read_in")
  codeGeneration("read_in")

    
    volumes = getVolumes()
    observe({ 
      input$btn
      if(!is.null(input$btn)){
        slctd_file<-parseFilePaths(volumes, input$btn)
        # output$filename<- renderText(as.chfilesaracter(tools::file_path_sans_ext(basename(slctd_file$datapath))))
        filenames <- reactive({
          data.frame(
            as.vector(
              sub(
                pattern= "(.*?)\\..*$",
                replacement = "\\1",
                basename(slctd_file$datapath)
              )
            )
          )
        })
        saraw<- reactive({
          req(input$sampleanno)
          insampleanno <- input$sampleanno
          read.csv(insampleanno$datapath, sep = ",", header = TRUE)
        })
        
        filenames <- reactive({
          req(input$btn)
          data.frame(
            as.character(
              basename(slctd_file$datapath)
            )
          )
        })
        
        output$sampleannoTable <- renderTable({
            req(input$sampleanno)
            cbind(filenames(), saraw())
        })
      }
    }
    )
    
   
    
    observeEvent(input$tab1Next,{
      updateTabsetPanel(session, 
                        "mES1",
                        selected = "readIn")
    })
    
   
    
    
    
    
    observeEvent(input$tab2Previous,{
      updateTabsetPanel(session,
                        "mES1",
                        selected = "start")
    })
    
    observeEvent(input$tab2Next,{
      updateTabsetPanel(session,
                        "mES1",
                        selected = "preprocess")
    })
    
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
    
    observeEvent(input$code2,{
      zz <- file("analysis/methrix_report.Rmd", open = "wt")
      sink(zz)
      cat("---\n")
      cat("title: ",input$projectName,"\n")
      cat("author: ",input$authorName,"\n")
      cat("date: \'\`r format(Sys.time(), \"%d %B, %Y\")\`\'\n")
      cat("output: workflowr::wflow_html\n")
      cat("editor_options:\n")
      cat("\t chunk_output_type: console\n")
      cat("---\n")
      cat("\n")
      cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n
        # Installing libraries\n")
      cat("library(methrix)\n")
      cat("library(data.table)\n")
      cat("library(shinyFiles)\n")
      cat("library(shinyDashboard)\n")
      cat("library(dmrseq)\n")
      cat("library(DSS)\n")
      cat("library(rGREAT)\n")
      cat("library(rtracklayer)\n")
      cat("library(Gviz)\n")
      cat("library(biomaRt)\n")
      cat("library(pheatmap)\n")
      cat("\n")
      cat("\`\`\`\n")
      cat("\n")
      cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n")
      cat("\n")
      cat(" # Intial QC and summary \n
      methrix::methrix_report(\n
          meth = meth,\n
          output_dir = getwd(), \n
          prefix = \"initial\")\n")
      cat("\`\`\`\n
\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n")
      cat(" # Coverage based filtering\n")
      cat("meth <- methrix::mask_methrix(\n
          meth,\n
          low_count = 2,\n
          high_quantile = 0.99)\n")
      cat("meth <- methrix::remove_uncovered(meth)\n
          meth <- methrix::coverage_filter(\n
          m=meth,\n
          cov_thr = 5,\n
          min_samples = 2)\n")
      cat("meth <- methrix::remove_snps(m = meth, keep = TRUE)")
      cat("\`\`\`\n")
      close(zz)
    })
    
}


