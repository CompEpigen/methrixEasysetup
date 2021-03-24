projectDetailsserver <- function(id){
  
  moduleServer(
    id,
    function(input, output,session){
      
      
        observe({  
          if(!is.null(input$projectDirectory)){
            # browser
            root <- getVolumes()()
            directory <- reactive ({
              shinyDirChoose(input, 'projectDirectory', roots=root, session = session)
                              
                             # restrictions = system.file(package = "base"))
            return(parseDirPath(root, input$projectDirectory))
            })
            
            wflowPath <- reactive({file.path(directory(), input$projectName)})
            wflowexistspath <- reactive({file.path(directory(), "_workflowr.yml")})
            
            output$paths <- renderPrint({paste0(wflowPath())})
            observeEvent(input$tab1Next,{
            # # if (input$workflowExists == TRUE){
            # #   if(file.exists(wflowexistspath())){
            #     workflowr::wflow_start(
            #       directory = directory(),
            #       existing = T,
            #       overwrite = T
            #     )
            #     
            #     updateTabsetPanel(session, 
            #                       "mES1",
            #                       selected = "readIn")
            #     showNotification("Choosing this might affect the workflow files that are created previously")
            #     return()
            #   } else {
            #     showNotification("There is no workflow project present there. Please check the directory if workflow is present")
            #     return()
            #   }
            # } else {
            # 
              dir.create(file.path(directory(), input$projectName))
            workflowr::wflow_start(
              directory = wflowPath(),
              name = input$projectName,
              existing = T,
              overwrite = T)
            updateTabsetPanel(session, 
                              "mES1",
                              selected = "readIn")
              
            
            # }
            })
            
          }
          
         
        
      })
     
    }
  )
}