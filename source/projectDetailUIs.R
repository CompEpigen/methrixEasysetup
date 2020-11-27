

projectDetails <- function(id, label = "Details of the project"){
  
  tagList(
    textInput(
      inputId = "projectName",
      label = "Name of the Project"
    ),
    textInput(
      inputId = "authorName",
      label = "Name of the author"
    ),
    actionButton(
      inputId = "tab1Next",
      label = "Next",
      icon = icon("arrow-right")
    )
  )
}

