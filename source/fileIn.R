
fileIn <- function(id, label = "read_in"){
  shinyjs::useShinyjs()
  ns <- NS(id)
  tagList(
    shinyFilesButton(
      ns("btn"), 
      "Please select the bedGraph files", 
      title = "Select the bedGraph files:", 
      multiple = TRUE, 
      buttonType = "btn btn-primary", 
      class = NULL) %>%
      helper(type = "inline",
             title = "Select the bedGraph files",
             content = c("Choose the files that are needed for analysis.",
                         "<b>Note:</b> The file names will arranged alpha-numeric wise. Make sure your sample annotation is in same order. "),
             size = "s"),
    checkboxInput(
      inputId = ns("header"),
      label = "Header"
    ) %>%
      helper(type = "inline",
             title = "Header",
             content = c("Check in in case if you have header to the bedgraph files "),
             size = "s"),
    actionButton(
      inputId = ns("pre"),
      label = "Preview the first bedGraph file"
    )
  )
}


