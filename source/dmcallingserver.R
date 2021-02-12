
dmcallingserver <- function(id, label = label){
  
  moduleServer(
    id,
    function(input, output, session){
      
      ns <- NS(id)
      observeEvent(input$dmcalling,{
        if(input$dmcalling == T){
          output$heatmap_dm <- renderUI(
            checkboxInput(
              ns("dmheatmap"),
              "Differential Methylation heatmap"
            )
          )
        }
      })
      
      observeEvent(input$previewCode3,{
        if ( input$dmcalling == T){
          output$dmcode1 <- renderPrint({
            cat("bs_obj <- methrix::methrix2bsseq(meth)")
          })
          output$dmcode2 <- renderPrint({
            cat("dmlTest = DSS::DMLtest(bs_obj, group1 = c(\"X1\", \"X2\") , group2 = c(\"X3\", \"X4\"), smoothing = TRUE)")
          })
          
          output$dmcode3 <- renderPrint({
            cat("dmls = DSS::callDML(dmlTest, p.threshold = 0.05)\n")
            cat("dmrs = DSS::callDMR(dmlTest, p.threshold = 0.05)")
          })
        }
        
        if( input$dmheatmap == T){
          
          output$dmcode4 <- renderPrint({
            cat("heatmap_data <- as.data.frame(methrix::get_region_summary(meth, makeGRangesFromDataFrame(dmrs)))\n")
            cat("heatmap_data <- heatmap_data[complete.cases(heatmap_data),]\n")
            cat("pheatmap::pheatmap(mat = head(heatmap_data[,-(1:5)], 50), show_rownames = F, annotation_col = as.data.frame(meth@colData), fontsize = 8)")
          })
        }
        
      })
      
      
      observeEvent(input$save_close,{
        
      
      dm_calling_filePath <- reactive({normalizePath("analysis/03_dm_calling.Rmd", winslash = "/")})
      
      sink( file = dm_calling_filePath())
      
      cat("---\n")
      cat("title: \"dm_calling\"\n")
      cat("author: ",input$authorName,"\n")
      cat("date: \'\`r format(Sys.time(), \"%d %B, %Y\")\`\'\n")
      cat("output:\n")
      cat("    workflowr::wflow_html:\n")
      cat("        toc: false\n")
      cat("        code_folding: \"hide\"\n")
      cat("editor_options:\n")
      cat("    chunk_output_type: console\n")
      cat("---\n")
      
      cat("\n\`\`\`{r lib_3, message=FALSE, warning=FALSE }\n
        # Installing libraries\n")
      cat("library(methrix)\n")
      cat("library(data.table)\n")
      cat("library(pheatmap)\n")
      cat("\n")
      cat("\`\`\`\n")
      
      cat("\n\`\`\`{r read_RDS_3, message=FALSE, warning=FALSE}\n")
      cat(" #Read RDS object\n")
      cat(" meth <- readRDS(\"./data/processed_methrix.RDS\") ")
      cat("\n\`\`\`\n\n")
      
      cat("\n\`\`\`{r bs_obj, message=FALSE, warning=FALSE}\n")
      cat("#transform methrix object to bsseq \n ")
      cat("bs_obj <- methrix::methrix2bsseq(meth)\n")
      cat("\n\`\`\`\n\n")
      
      cat("\n\`\`\`{r dml_test, message=FALSE, warning=FALSE}\n")
      cat("dmlTest = DSS::DMLtest(bs_obj, group1 = c(\"X1\", \"X2\") , group2 = c(\"X3\", \"X4\"), smoothing = TRUE)")
      cat("\n\`\`\`\n\n")
      
      cat("\n\`\`\`{r calling_dmr_dml, message=FALSE, warning=FALSE}\n")
      cat("dmls = DSS::callDML(dmlTest, p.threshold = 0.05)\n")
      cat("dmrs = DSS::callDMR(dmlTest, p.threshold = 0.05)\n")
      cat("write.table(dmls, file = \"./data/dmls.tsv\", quote = F, sep = \"\t\")\n")
      cat("write.table(dmrs, file = \"./data/dmrs.tsv\", quote = F, sep = \"\t\")\n")
      cat("\n\`\`\`\n\n")
      
      cat("\n\`\`\`{r dm_heatmap, message=FALSE, warning=FALSE}\n")
      cat("heatmap_data <- as.data.frame(methrix::get_region_summary(meth, makeGRangesFromDataFrame(dmrs)))\n")
      cat("heatmap_data <- heatmap_data[complete.cases(heatmap_data),]\n")
      cat("pheatmap::pheatmap(mat = head(heatmap_data[,-(1:5)], 50), show_rownames = F, annotation_col = as.data.frame(meth@colData), fontsize = 8)\n")
      cat("\n\`\`\`\n\n")
            })
    }
  )
}