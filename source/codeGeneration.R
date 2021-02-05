

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
      
      observeEvent(input$projectDirectory,{
        req(input$tab1Next)
        read_in_filePath <- reactive({normalizePath("analysis/01.read_in.Rmd", winslash = "/")})
        if(file.exists(read_in_filePath())){
          shinyjs::enable("tab2Skip")
        } else {
          shinyjs::disable("tab2Skip")
        }
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
        } else if (length(which(duplicated(c( 
          ifelse(is.na(input$chr_idx), 100, input$chr_idx),
          ifelse(is.na(input$start_idx), 101, input$start_idx), 
          ifelse(is.na(input$end_idx), 102, input$end_idx), 
          ifelse(is.na(input$strand_idx), 103, input$strand_idx), 
          ifelse(is.na(input$beta_idx), 104, input$beta_idx), 
          ifelse(is.na(input$M_idx), 105, input$M_idx),
          ifelse(is.na(input$U_idx), 106, input$U_idx), 
          ifelse(is.na(input$cov_idx), 107, input$cov_idx))))) > 0){
          showNotification("Duplicated Index\n The code doesn't work.")
          return()
        } else if(all(is.na(input$beta_idx) , is.na(input$cov_idx))){
          if(is.na(input$M_idx) | is.na(input$U_idx)){
            showNotification("Missing beta or coverage values.\nU and M are not available either!\nCode doesn't work")
            return()
          }
        } else if(is.na(input$beta_idx) & !is.na(input$cov_idx)){
          if(all(is.na(input$M_idx), is.na(input$U_idx))){
            showNotification("Missing beta values but coverage info available.\nEither U or M are required for estimating beta values!\nCode doesn't work")
            return()
          } else if (all(!is.na(input$M_idx), !is.na(input$U_idx))){
              showNotification("Estimating beta values from M and U\n Code Works")
              return()
            } else if (!is.na(input$M_idx)){
              showNotification("Estimating beta values from M and coverage\n Code Works")
              return()
            } else if(!is.na(input$U_idx)){
              showNotification("Estimating beta values from U and coverage\n Code works")
              return()
            }
        } else if(!is.na(input$beta_idx) & is.na(input$cov_idx)){
          if(all(is.na(input$M_idx), is.na(input$U_idx))){
            showNotification("Missing coverage info but beta values are available.Code doesn't work!")
            return()
          } else {
            showNotification("Estimating Coverage from M and U indexes. Code Works!")
          }
        } else if(!is.na(input$beta_idx) & !is.na(input$cov_idx)){
            if(all(is.na(input$M_idx), is.na(input$U_idx))){
              showNotification("Estimating M and U from coverage and beta values. Code Works!")
              return()
            } 
        } else {
            showNotification("Code Works!")
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
        cat("\nsaveRDS(meth,\"",paste0(meth_filePath()),"\")")  
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
            
            if(input$addsampleanno == F){
              cat( " ")
            }
            else {
              cat(", coldata = sample_anno ")
            }
            cat(")\nmeth\n")
            
            
            
          }
          else{
            
            
            
            cat("\n# Reading bedGraph file\n
        methrix::read_bedgraphs( \n")
            cat( "files = bdg_files,\n")
            cat( "ref_cpgs = hg19_cpgs,\n")
            cat( "pipeline =", input$pipeline)
            if(is.na(input$Btn_GetFile)){
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
        volumes <- getVolumes()
        if(!is.null(input$Btn_GetFile)){
          sampleannoFile <- parseFilePaths(volumes, input$Btn_GetFile)
          sampleannoFilePath <- renderText(as.character(sampleannoFile$datapath))
        }
        
        read_in_filePath <- reactive({normalizePath("analysis/01.read_in.Rmd", winslash = "/")})
        meth_filePath <- reactive({normalizePath("data/raw_methrix.RDS", winslash = "/")})
        index_filePath <- reactive({normalizePath("analysis/index.Rmd")})
        
        sink(file = index_filePath(), append = TRUE)
        
        cat("[Reading in bedGraph files](01.read_in.html)\n\n")
        cat("[Pre-processing of bedGraph files](02.preprocess.html)\n\n")
        cat("[Summary of methrix report](initial_methrix_reports.html)\n\n")
        
        sink(file = read_in_filePath())
        
        cat("---\n")
        cat("title: \"read_in\"\n")
        cat("author: ",input$authorName,"\n")
        cat("date: \'\`r format(Sys.time(), \"%d %B, %Y\")\`\'\n")
        cat("output:\n")
        cat("    workflowr::wflow_html:\n")
        cat("        toc: false\n")
        cat("        code_folding: \"hide\"\n")
        cat("editor_options:\n")
        cat("    chunk_output_type: console\n")
        cat("---\n")
        cat("\n")
        cat("\`\`\`{r lib_1, message=FALSE, warning=FALSE }\n
        # Installing libraries\n")
        cat("library(methrix)\n")
        cat("library(data.table)\n")
        cat("library(pheatmap)\n")
        cat("\n")
        cat("\`\`\`\n")
        cat("\n")
        cat("# bedGraph file paths\n")
        cat("This command lists the bedgraph file paths based on the input from the user.\n\n")
        cat("\`\`\`{r bdg_files, message=FALSE, warning=FALSE}\n")
        cat("\n")
        cat( "# Files \n")
        cat("bdg_files <- ",paste(fileandpaths()), sep = "")
        cat("\n\n\`\`\`\n")
        cat("\n")
        
        cat("# CpG annotation\n")
        cat("The CpG sites are extracted using the respective Bsgenome annotation package. The read_bedgraph function is also able to extract CpG sites on it’s own, however, it might be beneficial to do it separately.\n\n")
        cat("\`\`\`{r CpG_reference, message=FALSE, warning=FALSE}\n")
        cat("# CpG annotation\n
        #hg19_cpgs <- methrix::extract_CPGs(ref_genome =\"",input$in_reference_cpgs,"\")\n", sep = "" )
        cat("\n hg19_cpgs <- readRDS(\"C:/Users/sivan/Desktop/01-02/Sivanesan/docs/hg19.RDS\")")
        cat("\n")
        cat("\`\`\`\n")
        cat("\n")
        
        cat("# Reading bedGraph files\n")
        cat("read_bedgraphs() function is a versatile bedgraph reader intended to import bedgraph files generated virtually by any sort of methylation calling program. It requires user to provide indices for column containing chromosome names, start position and other required fields.\n\n")
        if(input$addsampleanno == FALSE){
          cat(" \n")
        } else {
          cat("\`\`\`{r sample_anno, message=FALSE, warning=FALSE}\n")
          cat("sample_anno <- read.csv(\"",paste(sampleannoFilePath()),"\" ,sep = \",\", header = TRUE)\n", sep = "")
          cat("\`\`\`\n")
        }
        cat("\n\`\`\`{r read_in, message=FALSE, warning=FALSE}\n")
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
          
          if(input$addsampleanno == F){
            cat( " ")
          }
          else {
            cat(", coldata = sample_anno ")
          }
          cat(")\n meth \n")
          cat("\`\`\`\n")
          
          
          
        }
        else{
          
          
          cat("\`\`\`{r read_in, message=FALSE, warning=FALSE}\n")
          cat("\n# Reading bedGraph file\n
        methrix::read_bedgraphs( \n")
          cat( "files = bdg_files,\n")
          cat( "ref_cpgs = hg19_cpgs,\n")
          cat( "pipeline = \"",input$pipeline,"\"")
          if(input$addsampleanno == F){
            cat( " ")
          }
          else {
            cat(", coldata = sample_anno ")
          }
          cat(")")
          cat("\`\`\`\n")
        }
        
        cat("\`\`\`{r save_obj, message=FALSE, warning=FALSE}\n")
        cat("\n")
        cat("# Saving object in workflow\n")
        cat("saveRDS(meth,\"./data/raw_methrix.RDS\")")
        cat("\n")
        cat("\`\`\`\n")
        
        sink()

      })
    }
  )
}
