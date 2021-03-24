


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
        
        observeEvent(input$addsampleanno,{
          output$sampleannoTable <- renderTable({
            
            req(input$Btn_GetFile)
            
            read.csv(file = sampleannoFilePath(), sep = ",", header = T)
            
            
            # group_choices <- reactive({read.csv(file = sampleannoFilePath(), sep = ",", header = T)})

            # output$group1 <- renderUI(
            #   selectInput(
            #     inputId = ns("group1_dmc"),
            #     label = "Group 1",
            #     selected = NULL,
            #     choices = group_choices()
            #   )
            # )
          })
          
          
          
          output$generatedCode3 <- renderPrint({
            req(input$Btn_GetFile)
            cat("sample_anno <- read.csv(\"",paste(sampleannoFilePath()),"\" ,sep = \",\", header = TRUE)", sep = "")
          })
        })
        
        
      })
    }
  )
}