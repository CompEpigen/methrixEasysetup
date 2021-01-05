
fileIn <- function(id, label = "read_in"){
  shinyjs::useShinyjs()
  ns <- NS(id)
  tagList(
    shinyFilesButton(
      ns("btn"), 
      "Please select the bedGraph files", 
      title = "Please select the bedGraph files:", 
      multiple = TRUE, 
      buttonType = "default", 
      class = NULL),
    checkboxInput(
      inputId = ns("header"),
      label = "Header"
    ),
    actionButton(
      inputId = ns("pre"),
      label = "Preview the first bedGraph file"
    )
  )
}

