

codeGeneration <- function(id, readInParametersInput, projectDetailsUI, stringsAsFactors){
  
  moduleServer(
    id,
    function(input, output, session, readInParametersInput, projectDetailsUI){
      
      dataCode <- reactive({
        
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
                cat("# CpG annotation\n
        chg19_cpgs <- methrix::extract_CPGs(ref_genome = )\n" )
                cat("\n")
                cat("# Sample annotation\n
        sample.anno <-" )
               #  paste0( dput(read.csv(input$sampleanno$datapath, sep = ",", header = TRUE)))
                cat("\n")
                cat( "# Files \n
        bdg_files <- ")
                # paste0(dput(fileandpaths()))
                cat("\n# Reading bedGraph file\n
        methrix::read_bedgraphs( \n")
                cat( "filename = bdg_files,\n")
                cat( "ref_cpgs = hg19_cpgs,\n")
                cat( "pipeline =", input$pipeline, ",\n")
                cat( "zero_based =" ,input$zerobased, ",\n")
                cat( "stranded =" , input$stranded, ",\n")
                cat( "collapse_stranded =", input$collapse, ",\n")
                cat( "vect =", input$vect,",\n")
                cat( "chr_idx =", input$chr_idx,  ",\n")
                cat( "start_idx =", input$start_idx, ",\n")
                cat( "end_idx =", input$end_idx, ",\n")
                cat( "beta_idx =", input$beta_idx, ",\n")
                cat( "M_idx =", input$M_idx, ",\n")
                cat( "U_idx =", input$U_idx, ",\n")
                cat( "strand_idx =", input$strand_idx, ",\n")
                cat( "cov_idx =", input$cov_idx, ",\n")
                cat( "synced_coordinates =", input$synced_coordinates, ",\n")
                cat( "n_threads = ", input$n_threads, ",\n")
                cat( "coldata = sample_anno \n)\n")
                cat("\`\`\`\n")

      })
      })
    
  }
    




  

