
codeGenerationInput <- function(input, output, session){
  
  reactive( 
            cat("---\n"),
            cat("title: ",input$projectName,"\n"),
            cat("author: ",input()$authorName,"\n"),
            cat("date: \'\`r format(Sys.time(), \"%d %B, %Y\")\`\'\n"),
            cat("output: workflowr::wflow_html\n"),
            cat("editor_options:\n"),
            cat("\t chunk_output_type: console\n"),
            cat("---\n"),
            cat("\n"),
            cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n
    # Installing libraries\n"),
            cat("library(methrix)\n"),
            cat("library(data.table)\n"),
            cat("library(shinyFiles)\n"),
            cat("library(shinyDashboard)\n"),
            cat("library(dmrseq)\n"),
            cat("library(DSS)\n"),
            cat("library(rGREAT)\n"),
            cat("library(rtracklayer)\n"),
            cat("library(Gviz)\n"),
            cat("library(biomaRt)\n"),
            cat("library(pheatmap)\n"),
            cat("\n"),
            cat("\`\`\`\n"),
            cat("\n"),
            cat("\`\`\`{r libraries, message=TRUE, warning=FALSE, include=FALSE}\n"),
            cat("\n"),
    )
}