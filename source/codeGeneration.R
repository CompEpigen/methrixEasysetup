

codeGeneration <- function(id, label = "read_in"){
  
  moduleServer(
    id, 
    function(input, output, session){
      
      installed_cpgs <- reactive({
        a <- BSgenome::installed.genomes(splitNameParts = TRUE)
        a[,1]
      })
      
      ns <- NS(id)
      
      output$reference_cpgs <- renderUI({
        selectInput(
          inputId = ns("in_reference_cpgs"),
          label = "Select the reference CPGs",
          choices = installed_cpgs(),
          selected = NULL
        )
      })
      
      observeEvent(input$pipeline,{
        if(input$pipeline == "NULL"){
          shinyjs::enable("zerobased")
          shinyjs::enable("chr_idx")
          shinyjs::enable("beta_idx")
          shinyjs::enable("M_idx")
          shinyjs::enable("collapse")
          shinyjs::enable("start_idx")
          shinyjs::enable("U_idx")
          shinyjs::enable("synced_coordinates")
          shinyjs::enable("cov_idx")
          shinyjs::enable("stranded")
          shinyjs::enable("vect")
          shinyjs::enable("end_idx")
          shinyjs::enable("strand_idx")
          shinyjs::enable("n_threads")
        } else {
          shinyjs::disable("zerobased")
          shinyjs::disable("chr_idx")
          shinyjs::disable("beta_idx")
          shinyjs::disable("M_idx")
          shinyjs::disable("collapse")
          shinyjs::disable("start_idx")
          shinyjs::disable("U_idx")
          shinyjs::disable("synced_coordinates")
          shinyjs::disable("cov_idx")
          shinyjs::disable("stranded")
          shinyjs::disable("vect")
          shinyjs::disable("end_idx")
          shinyjs::disable("strand_idx")
          shinyjs::disable("n_threads")
        }
      })
      
      observeEvent(input$validate,{
        
        if(is.na(input$chr_idx) | is.na(input$start_idx)){
          showNotification("Give proper Chromosome and Start indexes")
          return()
        } else if (length(which(duplicated(c( input$chr_idx,input$start_idx, input$end_idx, input$strand_idx, input$beta_idx, input$M_idx,
                                                input$U_idx, input$cov_idx), incomparables = F))) > 0){
          showNotification("Duplicated Index")
          return()
        }
        
        
      })
      
      observeEvent(input$vect,{
        if(input$vect == TRUE){
          shinyjs::enable("vect_batch_size")
        } else {
          disable("vect_batch_size")
        } 
      })
      
      fileandpaths <-  reactive({
        volumes = getVolumes()
        slctd_file<-parseFilePaths(volumes, input$btn)
        (list(slctd_file$datapath))
      })
      
      observeEvent(input$validate,{
        if(is.null(input$btn)){
          shinyalert(title = "validation error",
                     "Please choose the bedgraph files",
                     type = "error")
        }
      })
      
      observeEvent(input$code,{
        
        
        
        readInCode1 <- reactive({
          cat( "# Files \n")
        cat("bdg_files <- ",paste(fileandpaths()), sep = "")
          
        })
        
        output$generatedCode1 <- renderPrint({
          readInCode1()
        })

        readInCode2 <- reactive({
          cat("# CpG annotation\n
        hg19_cpgs <- methrix::extract_CPGs(ref_genome =\"",input$in_reference_cpgs,"\")\n", sep = "" )
          cat("\n")
        })
        
        output$generatedCode2 <- renderPrint({
          readInCode2()
          })
        
       
        
        readInCode4 <- reactive ({
          
          if(input$pipeline == "NULL"){
            cat(" # Read bedgraph file \n")
            cat( "meth <- methrix::read_bedgraphs( files = bdg_files, ref_cpgs = hg19_cpgs,\n")
            cat( "                                pipeline =", input$pipeline, ", zero_based =" ,input$zerobased, ",\n")
            cat( "                                stranded =" , input$stranded, ", collapse_strands =", input$collapse, ",\n")
            cat( "                                vect =", input$vect,",\n")
            
            if (input$vect == TRUE){
              cat( "vect_batch_size =",  input$vect_batch_size ,",\n")}
            cat( "                                chr_idx =", input$chr_idx,  ", start_idx =", input$start_idx, ",\n")
            cat( "                                end_idx =", ifelse(is.na(input$end_idx), "NULL", input$end_idx), ", beta_idx =", ifelse(is.na(input$beta_idx), "NULL", input$beta_idx), ",\n")
            cat( "                                M_idx =", ifelse(is.na(input$M_idx), "NULL", input$M_idx), ", U_idx =", ifelse(is.na(input$U_idx), "NULL", input$U_idx), ",\n")
            cat( "                                strand_idx =", ifelse(is.na(input$strand_idx), "NULL", input$strand_idx), ", cov_idx =", ifelse(is.na(input$cov_idx), "NULL", input$cov_idx), ",\n")
            cat( "                                synced_coordinates =", input$synced_coordinates, ", n_threads = ", input$n_threads )
            
            if(is.null(input$Btn_GetFile)){
              cat( " ")
            }
            else {
              cat(", coldata = sample_anno ")
            }
            cat(")\n meth")
            cat("\`\`\`\n")
            
            
          }
          else{
            
            
            
            cat("\n# Reading bedGraph file\n
        methrix::read_bedgraphs( \n")
            cat( "files = bdg_files,\n")
            cat( "ref_cpgs = hg19_cpgs,\n")
            cat( "pipeline =", input$pipeline)
            if(is.null(input$Btn_GetFile)){
              cat( " )")
            }
            else {
              cat(",\n coldata = sample_anno)")
            }
            
          }
        })
        
        output$generatedCode4 <- renderPrint({
          readInCode4()
          })
        
      })
      
      observeEvent(input$tab2Next,{
        

        
        read_in_filePath <- reactive({normalizePath("analysis/read_in.Rmd", winslash = "/")})

        sink(file = read_in_filePath())
        
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
        cat( "# Files \n")
        cat("bdg_files <- ",paste(fileandpaths()), sep = "")
        cat("\n\n\`\`\`\n")
        cat("\n")
        cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n")
        cat("# CpG annotation\n
        hg19_cpgs <- methrix::extract_CPGs(ref_genome =\"",input$in_reference_cpgs,"\")\n", sep = "" )
        cat("\n")
        cat("\`\`\`\n")
        cat("\n")
        
        if(!is.null(input$Btn_GetFile)){
          cat(" \n")
        } else {
          cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n")
          cat("sample_anno <- read.csv(\"",paste(sampleannoFilePath()),"\" ,sep = \",\", header = TRUE)\n", sep = "")
          cat("\`\`\`\n")
        }
        cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n")
        if(input$pipeline == "NULL"){
          cat(" # Read bedgraph file \n")
          cat( "meth <- methrix::read_bedgraphs( files = bdg_files, ref_cpgs = hg19_cpgs,\n")
          cat( "                                pipeline =", input$pipeline, ", zero_based =" ,input$zerobased, ",\n")
          cat( "                                stranded =" , input$stranded, ", collapse_strands =", input$collapse, ",\n")
          cat( "                                vect =", input$vect,",\n")
          
          if (input$vect == TRUE){
            cat( "vect_batch_size =",  input$vect_batch_size ,",\n")}
          cat( "                                chr_idx =", input$chr_idx,  ", start_idx =", input$start_idx, ",\n")
          cat( "                                end_idx =", ifelse(is.na(input$end_idx), "NULL", input$end_idx), ", beta_idx =", ifelse(is.na(input$beta_idx), "NULL", input$beta_idx), ",\n")
          cat( "                                M_idx =", ifelse(is.na(input$M_idx), "NULL", input$M_idx), ", U_idx =", ifelse(is.na(input$U_idx), "NULL", input$U_idx), ",\n")
          cat( "                                strand_idx =", ifelse(is.na(input$strand_idx), "NULL", input$strand_idx), ", cov_idx =", ifelse(is.na(input$cov_idx), "NULL", input$cov_idx), ",\n")
          cat( "                                synced_coordinates =", input$synced_coordinates, ", n_threads = ", input$n_threads )
          
          if(is.null(input$Btn_GetFile)){
            cat( " ")
          }
          else {
            cat(", coldata = sample_anno ")
          }
          cat(")\n meth")
          cat("\`\`\`\n")
          
          
          
        }
        else{
          
          
          cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n")
          cat("\n# Reading bedGraph file\n
        methrix::read_bedgraphs( \n")
          cat( "files = bdg_files,\n")
          cat( "ref_cpgs = hg19_cpgs,\n")
          cat( "pipeline =", input$pipeline)
          if(!is.null(input$Btn_GetFile)){
            cat( " ")
          }
          else {
            cat(",\n coldata = sample_anno")
          }
          cat(")")
          cat("\`\`\`\n")
        }
        
        cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n")
        cat("\n")
        cat("# Saving object in workflow")
        cat("saveRDS(meth, \"./data=raw_methrix.RDS\" ")
        cat("\n")
        
        sink()

      })
    }
  )
}
