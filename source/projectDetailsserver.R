projectDetailsserver <- function(id){
  
  moduleServer(
    id,
    function(input, output,session){
      
      
        observe({  
          if(!is.null(input$projectDirectory)){
            # browser
            roots <- getVolumes()()
            directory <- reactive ({
              shinyDirChoose(input, 'projectDirectory', roots=roots, session = session, 
                             restrictions = system.file(package = "base"))
            return(parseDirPath(roots, input$projectDirectory))
            })
            
            wflowPath <- reactive({file.path(directory(), input$projectName)})
            
            # dir.create(file.path(directory(), input$projectName))
            output$paths <- renderPrint({paste0(wflowPath())})
            observeEvent(input$tab1Next,{
              dir.create(file.path(directory(), input$projectName))
            workflowr::wflow_start(
              directory = wflowPath(),
              name = input$projectName,
              existing = T,
              overwrite = F)
              
            })
            
          }
          
         
        
      })
     
    }
  )
}