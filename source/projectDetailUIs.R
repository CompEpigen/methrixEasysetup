


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
             title = "Choose a directory",
             content = c("Choose the directory to create a workflow project.",
                         "<b>Note:</b> Make sure the directory don't have an existing workflow project."),
             size = "s"),
    # checkboxInput(
    #   inputId = ns("workflowExists"),
    #   label = "Click if you want to edit the workflow project that was already created"
    # )%>%
    #   helper(type = "inline",
    #          title = "New/ Existing Workflow project",
    #          content = c("Click only if you want to edit the workflow project that was created previously using this app.",
    #                      "If you want to create a new workflow project, don't check-in this box."),
    #          size = "s"),
    textInput(
      inputId = ns("projectName"),
      label = "Name of the Project"
    ) %>%
      helper(type = "inline",
             title = "Name of the project",
             content = c("Provide a name for your project.",
                         "<b>Note:<b> Workflow project will be created under this name "))
    
    ,
    textInput(
      inputId = ns("authorName"),
      label = "Name of the author"
    ) %>% helper(
      type = "inline",
      title = "Name of the author",
      content = c("Provide the name of the author.",
                  "<b>Note:<b> Author's name will be reflected in results homepages ")
    )
    ,
    actionButton(
      inputId = ns("tab1Next"),
      label = "Next",
      icon = icon("arrow-right")
    ),
    h5("Note: On clicking Next, Workflow project will be created in the directory that was chosen"),
    
    verbatimTextOutput(ns("paths"))
  )
}

