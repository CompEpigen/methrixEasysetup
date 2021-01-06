

projectDetailsserver <- function(id){
  
  moduleServer(
    id,
    function(input, output,session){
      
      observe_helpers(withMathJax = TRUE)
      
      observe({  
        if(!is.null(input$projectDirectory)){
          # browser()
          shinyDirChoose(input, 'projectDirectory', roots=c(home = 'C:/Users/sivan/Desktop'))
          home <- normalizePath("C:/Users/sivan/Desktop", winslash = "/")
          directory <- renderText({
            req(input$projectDirectory)
            file.path(home, paste(unlist(input$projectDirectory$path[-1]), collapse = .Platform$file.sep))
          })
          
          observeEvent(input$tab1Next,{
            workflowr::wflow_start(
              directory = directory(),
              name = input$projectName,
              existing = TRUE,
              overwrite = F,
              git = F)
            
            output$paths <- renderPrint({
              paste0(directory())
            })
           
          })
        }
      })
    }
  )
}