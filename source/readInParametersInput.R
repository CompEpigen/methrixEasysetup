


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
           ) %>%
             helper(type = "inline",
                    title = "Choose the pipeline",
                    content = c("Choose a pipeline for reading in the bedgraph files. Choose NULL to manually enter other parameters. ",
                                "<b>Note:</b> For different pipeline other than null, there is a specific format that is required. "),
                    size = "s"),
           
           uiOutput(
             outputId = ns("reference_cpgs")
           ) %>%
             helper(type = "inline",
                    title = "Reference CPGs",
                    content = c(" Here's the list of installed CPGs on your local storage.  ",
                                "In case of CPGs required,???"),
                    size = "s"),
           
           numericInput(
             inputId = ns("vect_batch_size"),
             label = "Vector batch size",
             value = 2,
             min = 2,
             max = 5
           ) %>%
             helper(type = "inline",
                    title = "Vector Batch Size",
                    content = c(" If you want your samples to be processed in batches, then give a number as in how many batches.  ",
                                "<b>Note:<b> It is appplicable only when vectorize code is TRUE."),
                    size = "s"),
           
           
           numericInput(
             inputId = ns("chr_idx"),
             label = "Chromosome column",
             value = NULL,
             min = 1,
             max = 100
           ) %>%
             helper(type = "inline",
                    title = "Chromosome index",
                    content = c(" Give the column number which contains the information about the chromosome numbers."),
                    size = "s"),
           
           numericInput(
             inputId = ns("beta_idx"),
             label = "Beta value column ",
             value = NULL,
             min = 1,
             max = 100
           ) %>%
             helper(type = "inline",
                    title = "Beta value column",
                    content = c(" Give the column number which contains the information about the beta values.",
                                "Note: Only few accepted combinations are allowed which are:",
                                "* Methylated and Unmethylated counts column",
                                "* Methylated counts and Coverage column ",
                                "* Unmethylated counts and Coverage column ",
                                "* beta values and coverage column "),
                    size = "s"),
           
           numericInput(
             inputId = ns("M_idx"),
             label = "Methylated counts column ",
             value = NULL ,
             min = 1,
             max = 100
           ) %>%
             helper(type = "inline",
                    title = "Methylated counts column",
                    content = c(" Give the column number which contains the information regarding thr read counts supporting methylation",
                                "Note: Only few accepted combinations are allowed which are:",
                                "* Methylated and Unmethylated counts column",
                                "* Methylated counts and Coverage column ",
                                "* Unmethylated counts and Coverage column ",
                                "* beta values and coverage column "),
                    size = "s"),
           
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
           )%>%
             helper(type = "inline",
                    title = "Collapse",
                    content = c(" If TRUE collapses CpGs on different crick starnd into Watson."),
                    size = "s"),
           numericInput(
             inputId = ns("start_idx"),
             label = "Start column ",
             value = NULL,
             min = 1,
             max = 100
           ) %>%
             helper(type = "inline",
                    title = "Start index",
                    content = c(" Give the column number which contains the information about the start position"),
                    size = "s"),
           numericInput(
             inputId = ns("U_idx"),
             label = "Un-methylated counts column ",
             value = NULL,
             min = 1,
             max = 100
           )  %>%
             helper(type = "inline",
                    title = "un-Methylated counts column",
                    content = c(" Give the column number which contains the information regarding the read counts supporting un-methylation",
                                "Note: Only few accepted combinations are allowed which are:",
                                "* Methylated and Unmethylated counts column",
                                "* Methylated counts and Coverage column ",
                                "* Unmethylated counts and Coverage column ",
                                "* beta values and coverage column "),
                    size = "s"),
           checkboxInput(
             inputId = ns("synced_coordinates"),
             label = "Are the start and end coordinates of a stranded bedgraph are synchronized between + and - strands?",
             value = F
           ),
           numericInput(
             inputId = ns("cov_idx"),
             label = "Coverage column",
             value = NULL,
             min = 1,
             max = 100
           )  %>%
             helper(type = "inline",
                    title = "Coverage column",
                    content = c(" Give the column number which contains the information regarding the coverage column",
                                "Note: Only few accepted combinations are allowed which are:",
                                "* Methylated and Unmethylated counts column",
                                "* Methylated counts and Coverage column ",
                                "* Unmethylated counts and Coverage column ",
                                "* beta values and coverage column "),
                    size = "s")
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
             max = 100
           ) %>%
             helper(type = "inline",
                    title = "End column",
                    content = c(" Give the column number which contains the information about the end positions"),
                    size = "s"),
           numericInput(
             inputId = ns("strand_idx"),
             label = "Strand information column",
             value = NULL,
             min = 1,
             max = 100
           ) %>%
             helper(type = "inline",
                    title = "Strand information column",
                    content = c(" Give the column number which contains the strand information."),
                    size = "s"),
           numericInput(
             inputId = ns("n_threads"),
             label = "Number of threads to use",
             value = 1,
             min = 1,
             max = 8
           ),
           
           actionButton(
             inputId = ns("validate"),
             label = "Validate Code"
           ),
           
           
           actionButton(
             inputId = ns("code"),
             label = "Generate Code"
           )
           
           
    )
  )
  )
}