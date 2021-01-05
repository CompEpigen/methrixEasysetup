


sampleAnnotationserver <- function(id){
  
  moduleServer(
    id,
    function(input, output, session){
      
      volumes = getVolumes()
      observe({
        shinyFileChoose(input, "Btn_GetFile",
                        roots= volumes, session = session)
        
        if(!is.null(input$Btn_GetFile)){
          sampleannoFile <- parseFilePaths(volumes, input$Btn_GetFile)
          sampleannoFilePath <- renderText(as.character(sampleannoFile$datapath))
        }
        
        
        output$sampleannoTable <- renderTable({
          
          req(input$Btn_GetFile)
          
          read.csv(file = sampleannoFilePath(), sep = ",", header = T)
          
        })
        
        output$generatedCode3 <- renderPrint({
          req(input$Btn_GetFile)
          cat("sampleanno <- read.csv(\"", paste(sampleannoFilePath()) ,"\" ,sep = \",\", header = TRUE)")
        })
        
      })
    }
  )
}