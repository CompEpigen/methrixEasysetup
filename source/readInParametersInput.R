


readInParametersInput <- function (id, label = label){
  
  ns <- NS(id)
  
  box(
    title = "Parameters",
    solidHeader = TRUE,
    width = NULL,
    status = "warning",
  
  tagList(
    
    shinyjs::useShinyjs(),

    
    column(width = 4,
           
           selectInput(
             inputId = ns("pipeline"), 
             label = "Choose the pipeline", 
             choices =  c("NULL",
                          "Bismarck",
                          "MethylcDeckal", 
                          "MethylcTools",
                          "BisSNP", 
                          "BSseeker2_CGmap"),
             selected = "NULL"
           ),
           
           uiOutput(
             outputId = ns("reference_cpgs")
           ),
           
           numericInput(
             inputId = ns("vect_batch_size"),
             label = "Vector batch size",
             value = 2,
             min = 2,
             max = 5
           ),
           
           
           numericInput(
             inputId = ns("chr_idx"),
             label = "Chromosome column of bedGraph file",
             value = NULL,
             min = 1,
             max = 8
           ),
           
           numericInput(
             inputId = ns("beta_idx"),
             label = "Beta value column ",
             value = NULL,
             min = 1,
             max = 8
           ),
           
           numericInput(
             inputId = ns("M_idx"),
             label = "Methylated counts column ",
             value = NULL ,
             min = 1,
             max = 8
           ),
           
    ),
    
    column(width = 4,
           
           checkboxInput(
             inputId = ns("zerobased"), 
             label = "Zero-Based", 
             value = T,
           ),
           
           checkboxInput(
             inputId = ns("collapse"),
             label = "Collapse strands",
             value = F
           ),
           numericInput(
             inputId = ns("start_idx"),
             label = "Start column ",
             value = NULL,
             min = 1,
             max = 8
           ),
           numericInput(
             inputId = ns("U_idx"),
             label = "Un-methylated counts column ",
             value = NULL,
             min = 1,
             max = 8
           ),
           checkboxInput(
             inputId = ns("synced_coordinates"),
             label = "Are the start and end coordinates of a stranded bedgraph are synchronized between + and - strands?",
             value = F
           ),
           numericInput(
             inputId = ns("cov_idx"),
             label = "Beta value column of the bedGraph file",
             value = NULL,
             min = 1,
             max = 8
           )
    ),
    
    column(width = 4,
           checkboxInput(
             inputId = ns("stranded"),
             label = "Stranded",
             value = F
           ),
           checkboxInput(
             inputId = ns("vect"),
             label = "Vectorize code",
             value = F
           ),
           numericInput(
             inputId =ns( "end_idx"),
             label = "End column ",
             value = NULL,
             min = 1,
             max = 8
           ),
           numericInput(
             inputId = ns("strand_idx"),
             label = "Strand information column",
             value = NULL,
             min = 1,
             max = 8
           ),
           numericInput(
             inputId = ns("n_threads"),
             label = "Number of threads to use",
             value = NULL,
             min = 1,
             max = 8
           ),
           
           actionButton(
             inputId = ns("code"),
             label = "Generate Code"
           )
           
           
    )
  )
  )
}