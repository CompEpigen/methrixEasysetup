
fileIn <- function(input, output, session){
  shinyjs::useShinyjs()
  tagList(
    shinyFilesButton(
      "btn", 
      "Please select the bedGraph files", 
      title = "Please select the bedGraph files:", 
      multiple = TRUE, 
      buttonType = "default", 
      class = NULL),
    checkboxInput(
      inputId = "header",
      label = "Header"
    ),
    actionButton(
      inputId = "pre",
      label = "Preview the first bedGraph file"
    )
  )
}

