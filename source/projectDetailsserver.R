projectDetailsserver <- function(id){
  
  moduleServer(
    id,
    function(input, output,session){
      
      observeEvent(input$tab1Next,{
        if(!is.null(input$projectDirectory)){
          showNotification("Please select the directory to create workflow files", type = "error")
          return()
        }
      })
      observe({  
        if(!is.null(input$projectDirectory)){
          # browser
          volumes=getVolumes()
          shinyDirChoose(input, 'projectDirectory', roots=c(home=getwd()))
          req(input$projectDirectory)
          home <- normalizePath(getwd(), winslash = "/")
          directory <- renderText({
            req(input$projectDirectory)
            file.path(home, paste(unlist(input$projectDirectory$path[-1]), collapse = .Platform$file.sep))
          })
            workflowr::wflow_start(
              directory = directory(),
              name = input$projectName,
              existing = TRUE,
              overwrite = TRUE,
              git = F)
            output$paths <- renderPrint({
              paste0(directory())
            })
        }
        
      })
    }
  )
}