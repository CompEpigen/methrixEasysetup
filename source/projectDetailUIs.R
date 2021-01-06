

projectDetailsUI <- function(id, label = "read_in"){
  ns <- NS(id)
  tagList(
    shinyDirButton(
      id = ns("projectDirectory"),
      label = "Choose a directory",
      FALSE,
      buttonType = "btn btn-primary"
    ),
    textInput(
      inputId = ns("projectName"),
      label = "Name of the Project"
    ),
    textInput(
      inputId = ns("authorName"),
      label = "Name of the author"
    ),
    actionButton(
      inputId = ns("tab1Next"),
      label = "Next",
      icon = icon("arrow-right")
    ),
    
    verbatimTextOutput(ns("paths"))
  )
}

