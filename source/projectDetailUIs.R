


projectDetailsUI <- function(id, label = "read_in"){



  ns <- NS(id)
  tagList(
    shinyDirButton(
      id = ns("projectDirectory"),
      label = "Choose a directory",
      FALSE,
      buttonType = "btn btn-primary" 
    ) %>%
      helper(type = "inline",
             title = "Inline Help",
             content = c("This helpfile is defined entirely in the UI!",
                         "This is on a new line.",
                         "This is some <b>HTML</b>."),
             size = "s")
    
    ,
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

