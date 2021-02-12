

preprocessInput <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    h5("Coverage based filtering"),
    checkboxInput(
      ns("mask_methrix"),
      " Mask Methrix"
    )%>%
      helper(type = "inline",
             title = "Mask Methrix",
             content = c(" Mask the CpG sites which has very low or high coverage."),
             size = "s"),
    uiOutput(
      ns("maskmethrixtest")
    ),
    checkboxInput(
      ns("remove_uncovered"),
      " Remove Uncovered"
    ) %>%
      helper(type = "inline",
             title = "Remove Uncovered",
             content = c(" Remove the sites which are not covered by any of the samples"),
             size = "s"),
    checkboxInput(
      ns("coverage_filter"),
      " Filter coverage"
    ) %>%
      helper(type = "inline",
             title = "Coverage filter",
             content = c(" Remove the sparsely covered sites",
                         "Use min_samples to define the minimum size of the sampes thta should excess the treshold for each CpG sites.",
                         "# Have to add treshold"),
             size = "s"),
    uiOutput(
      ns("removeUncoveredtest")
    ),
    checkboxInput(
      ns("snpFiltering"),
      "SNP Filtering"
    ) %>%
      helper(type = "inline",
             title = "SNP filtering",
             content = c(" SNPs could disrupt the methylation calling.",
                         " So, it is important to remove CpG sites that overlap the common variants."),
             size = "s"),
    
    checkboxInput(
      ns("methrixreReport"),
      "Methrix Report after filtering?"
    )%>%
      helper(type = "inline",
             title = "Methrix Report",
             content = c(" After filtering, it is essential to run the report again"),
             size = "s"),
    
    checkboxInput(
      ns("plotsafterfilter"),
      "Methrix plots after filtering?"
    ) %>%
      helper(type = "inline",
             title = "Plots",
             content = c(" To visualize the study. ",
                         "We can loos at the desity of coverage by both sample and group-wise."),
             size = "s"),
    
    actionButton(
      inputId = ns("code2"),
      label = "Preview Code"
    ),
    
    actionButton(inputId = ns("tab3Previous"),
                 label = "Previous",
                 icon = icon("arrow-left")),
    actionButton(inputId = ns("tab3Next"),
                 label = "Next",
                 icon = icon("arrow-right"))
  )
}