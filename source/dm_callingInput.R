
dm_callingInput <- function(id){
  
  ns <- NS(id)
  
  tagList(
    h5("Differential methylation Calling"),
    checkboxInput(
      inputId = ns("dmcalling"),
      label = "Perform DM calling"
    ),
    uiOutput(ns("heatmap_dm")),
    actionButton(
      inputId = ns("previewCode3"),
      label = "Preview Code",
    ),
    actionButton(
      inputId = ns("tab4previous"),
      label = "Previous",
      icon = icon("arrow-left")
    ),
    actionButton(
      inputId = ns("save_close"),
      label = "Save and Close the app"
    )
  )
}