

codeGeneration <- function(id, label = "read_in"){
  
  moduleServer(
    id, 
    function(input, output, session){
      
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
        ((slctd_file$datapath))
      })
      
      
      
      observeEvent(input$code,{
        
        
        readInCode1 <- reactive({
          cat( "# Files \n
        bdg_files <- c( \"  ")
          cat(fileandpaths(), sep = "\",\n\"")
          
          cat(" \" )")
        })
        
        output$generatedCode1 <- renderPrint({
          readInCode1()
        })

        readInCode2 <- reactive({
          cat("# CpG annotation\n
        chg19_cpgs <- methrix::extract_CPGs(ref_genome =",input$in_reference_cpgs," )\n" )
          cat("\n")
        })
        
        output$generatedCode2 <- renderPrint({
          readInCode2()
          })
        
       
        
        readInCode3 <- reactive ({
          
          if(input$pipeline == "NULL"){
            cat(" # Read bedgraph file \n")
            cat( "methrix::read_bedgraphs( \n")
            cat( "files = bdg_files,\n")
            cat( "ref_cpgs = hg19_cpgs,\n")
            cat( "pipeline =", input$pipeline, ",\n")
            cat( "zero_based =" ,input$zerobased, ",\n")
            cat( "stranded =" , input$stranded, ",\n")
            cat( "collapse_strands =", input$collapse, ",\n")
            cat( "vect =", input$vect,",\n")
            
            if (input$vect == TRUE){
            cat( "vect_batch_size =",  input$vect_batch_size ,",\n")}
            cat( "chr_idx =", input$chr_idx,  ",\n")
            cat( "start_idx =", input$start_idx, ",\n")
            cat( "end_idx =", ifelse(is.na(input$end_idx), "NULL", input$end_idx), ",\n")
            cat( "beta_idx =", ifelse(is.na(input$beta_idx), "NULL", input$beta_idx), ",\n")
            cat( "M_idx =", 
                 ifelse(is.na(input$M_idx), "NULL", input$M_idx),
                 ",\n")
            cat( "U_idx =", ifelse(is.na(input$U_idx), "NULL", input$U_idx), ",\n")
            cat( "strand_idx =", input$strand_idx, ",\n")
            cat( "cov_idx =", input$cov_idx, ",\n")
            cat( "synced_coordinates =", input$synced_coordinates, ",\n")
            cat( "n_threads = ", input$n_threads, ",\n")
            cat( "coldata = sample_anno \n)\n")
            cat("\`\`\`\n")
            
            
          }
          else{
            
            
            
            cat("\n# Reading bedGraph file\n
        methrix::read_bedgraphs( \n")
            cat( "files = bdg_files,\n")
            cat( "ref_cpgs = hg19_cpgs,\n")
            cat( "pipeline =", input$pipeline, ")\n")
            
          }
        })
        
        output$generatedCode3 <- renderPrint({
          readInCode3()})
        
        
        # sink("hey.R")
        # generatedCode()
        # sink()
        
        
        
      })
    }
  )
}
