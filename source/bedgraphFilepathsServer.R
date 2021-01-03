

bedgraphFilepathsServer <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      
      shinyjs::useShinyjs()
      volumes = getVolumes()
      
      
       observe({
        shinyFileChoose(input, "btn", roots = volumes, session = session)
        if(!is.null(input$btn)){
          slctd_file<-parseFilePaths(volumes, input$btn)
          bedgraphFiles <- renderText((slctd_file$datapath[1]))
        }
       
        
        observeEvent(input$pre,{
          
          output$previewtable <- renderTable({
            req(input$btn)
            fread(
              bedgraphFiles(),
              header = input$header,
              sep = "\t",
              nrows = 5)
          })
          output$previewfilename <- renderPrint({
            cat("Preview of the first bedGraph file:", as.character(basename(bedgraphFiles())))
          })
        })
       })
      
     
    }
  )
}