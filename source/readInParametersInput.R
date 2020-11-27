
readInParametersInput <- function(id, label = "Parameters"){
  
  box(
    title = "Parameters",
    solidHeader = TRUE,
    width = NULL,
    status = "warning",
  
  tagList(
    fluidPage(
      
      fluidRow(
        
        column(width = 4,
               
               selectInput(
                 inputId = "pipeline", 
                 label = "Choose the pipeline", 
                 choices =  c("NULL","Bismarck","MethylcDeckal", "MethylcTools","BisSNP", "BSseeker2_CGmap"),
                 selected = "NULL"
               ),
               
               uiOutput(
                 outputId = "reference_cpgs"
               ),
               
               numericInput(
                 inputId = "chr_idx",
                 label = "Chromosome column of bedGraph file",
                 value = NULL,
                 min = 1,
                 max = 8
               ),
               
               numericInput(
                 inputId = "beta_idx",
                 label = "Beta value column ",
                 value = NULL,
                 min = 1,
                 max = 8
               ),
               numericInput(
                 inputId = "M_idx",
                 label = "Methylated counts column ",
                 value = NULL,
                 min = 1,
                 max = 8
               ),
               
               ),
        
        column(width = 4,
               
               checkboxInput(
                 inputId = "zerobased", 
                 label = "Zero-Based", 
                 value = T,
               ),
               
               checkboxInput(
                 inputId = "collapse",
                 label = "Collapse strands",
                 value = F
               ),
               numericInput(
                 inputId = "start_idx",
                 label = "Start column ",
                 value = NULL,
                 min = 1,
                 max = 8
               ),
               numericInput(
                 inputId = "U_idx",
                 label = "Un-methylated counts column ",
                 value = NULL,
                 min = 1,
                 max = 8
               ),
               checkboxInput(
                 inputId = "synced_coordinates",
                 label = "Are the start and end coordinates of a stranded bedgraph are synchronized between + and - strands?",
                 value = F
               ),
               numericInput(
                 inputId = "cov_idx",
                 label = "Beta value column of the bedGraph file",
                 value = 0,
                 min = 1,
                 max = 8
               )
               ),
        
        column(width = 4,
               checkboxInput(
                 inputId = "stranded",
                 label = "Stranded",
                 value = F
               ),
               checkboxInput(
                 inputId = "vect",
                 label = "Use vectoried code",
                 value = F
               ),
               numericInput(
                 inputId = "end_idx",
                 label = "End column ",
                 value = NULL,
                 min = 1,
                 max = 8
               ),
               numericInput(
                 inputId = "strand_idx",
                 label = "Strand information column",
                 value = NULL,
                 min = 1,
                 max = 8
               ),
               numericInput(
                 inputId = "n_threads",
                 label = "Number of threads to use",
                 value = NULL,
                 min = 1,
                 max = 8
               ),
               
               actionButton(
                 inputId = "code",
                 label = "Generate Code"
               )
               
               
               )
      )
    )

  ) 
  )
}
