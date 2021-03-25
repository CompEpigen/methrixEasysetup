
dmcallingserver <- function(id, label = label){
  
  moduleServer(
    id,
    function(input, output, session){
      
      ns <- NS(id)
      observeEvent(input$dmcalling,{
        if(input$dmcalling == T){
          output$heatmap_dm <- renderUI(
            tagList(
            checkboxInput(
              ns("regional_annotation"),
              "Annotation of Differentially Methylated region and Visualization"
            )
            )
          )
          
          
            
          if(input$addsampleanno == T){
            
            volumes <- getVolumes()
            if(!is.null(input$Btn_GetFile)){
              sampleannoFile <- parseFilePaths(volumes, input$Btn_GetFile)
              sampleannoFilePath <- renderText(as.character(sampleannoFile$datapath))
            }
            
            group_choices <- reactive({colnames(read.csv(file = sampleannoFilePath(), sep = ",", header = T))})
            
            output$grouping <- renderUI(
               selectInput(
                 inputId = ns("grouping"),
                 label = "Group based on ",
                 selected = NULL,
                 choices = group_choices()
               )
             )
            # group_chosen <- reactive({
            #   req(input$grouping)
            #   input$grouping
            #   })
            # 
            # internal_choices <- reactive({
            #   req(input$grouping)
            #   reading <- read.csv(file = sampleannoFilePath(), sep = ",", header = T)
            #   reading$input$grouping
            # })
            output$group1 <- renderUI({
              req(input$grouping)
              textInput(
                inputId = ns("group1"),
                label = "Group 1",
                value = NULL,
                width = NULL
              )
            })
            
            output$group2 <- renderUI(
              textInput(
                inputId = ns("group2"),
                label = "Group 2",
                value = NULL,
                width = NULL
              )
            )
            
          } else {
          output$group1 <- renderUI(
            checkboxGroupInput(ns("group1"),
                               "Group 1",
                               choices = c("X1", "X2", "X3", "X4")))
            output$group2 <- renderUI(
              checkboxGroupInput(ns("group2"),
                                 "Group 2",
                                 choices = c("X1", "X2", "X3", "X4")))
          }
          
        }
      })
      
      
      
      observeEvent(input$previewCode3,{
        if ( input$dmcalling == T){
          output$dmcode1 <- renderPrint({
            cat("bs_obj <- methrix::methrix2bsseq(meth)")
          })
          output$dmcode2 <- renderPrint({
            cat("dmlTest = DSS::DMLtest(bs_obj, group1 = which(colData(bs_obj)$") 
            cat(input$grouping)
            cat("== \"") 
            cat(input$group1)
            cat("\"), group2 = which(colData(bs_obj)$") 
            cat(input$grouping)
            cat("== \"") 
            cat(input$group2)
            cat("\"))")
          })
          
          output$dmcode3 <- renderPrint({
            cat("dmls = DSS::callDML(dmlTest, p.threshold = 0.05)\n")
            cat("dmrs = DSS::callDMR(dmlTest, p.threshold = 0.05)")
          })
        }
        
        if( input$regional_annotation == T){
          
          output$dmcode4 <- renderPrint({
            
            cat("# Number and Size of DMRs")
            cat("dmrs <- makeGRangesFromDataFrame(dmrs, keep.extra.columns =TRUE)\n")
            cat("count <- c(\"Higher in", paste0(input$group1)," \" = length(dmrs[dmrs$diff.Methy<0,]),
           \"Higher in", paste0(input$group2)," \" = length(dmrs[dmrs$diff.Methy>0,])) \n
           length <- c(\"Higher in", paste0(input$group1)," \" = sum(width(dmrs[dmrs$diff.Methy<0,])), 
            \"Higher in", paste0(input$group2)," \" = sum(width(dmrs[dmrs$diff.Methy<0,]))) \n")
            cat("data <- data.frame(Direction=c(\"Gain\", \"Loss\"), Count=count, Length=length)\n")
            cat("g <- ggplot(data=data)+geom_col(aes(x=factor(1), y=Count, fill=Direction), position = \"dodge\")+theme_bw()+theme(axis.title.x = element_blank(), axis.text.x = element_blank())+scale_fill_brewer(palette = \"Dark2\")+ggtitle(\"Number of differentially methylated regions\")+scale_y_continuous(labels = comma)\n")
            cat("ggplotly(g)\n")
            
            cat("# Regional Annotation \n")
            cat("peakAnnoList <- lapply(list(\"group1\"=dmrs[dmrs$diff.Methy<0,],\"group2\" = dmrs[dmrs$diff.Methy>0,]), annotatePeak, TxDb=txdb, tssRegion=c(-3000, 3000), 
                verbose=FALSE)\n")
            cat("ChIPseeker::plotAnnoBar(peakAnnoList)\n")
            
            cat("# Visualizing DMRs\n")
            cat("# Heatmap of DMR\n")
            cat("Top 50 DMRs are shown in the heatmap\n")
            
            cat("heatmap_data <- as.data.frame(methrix::get_region_summary(meth, makeGRangesFromDataFrame(dmrs)))\n")
            cat("heatmap_data <- heatmap_data[complete.cases(heatmap_data),]\n")
            cat("pheatmap::pheatmap(mat = head(heatmap_data[,-(1:5)], 50), show_rownames = F, annotation_col = as.data.frame(meth@colData), fontsize = 8)\n")
            
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
      cat("if(!requireNamespace(\"ChIPseeker\")) {\n")
      cat("BiocManager::install(\"ChIPseeker\")\n")
      cat("}\n")
      cat("if(!requireNamespace(\"TxDb.Hsapiens.UCSC.hg19.knownGene\")) {\n")
      cat("BiocManager::install(\"TxDb.Hsapiens.UCSC.hg19.knownGene\")\n")
      cat("}\n")
      cat("if(!requireNamespace(\"ReactomePA\")) {\n")
      cat("BiocManager::install(\"ReactomePA\")\n")
      cat("}\n")
      cat("if(!requireNamespace(\"clusterProfiler\")) {\n")
      cat("BiocManager::install(\"clusterProfiler\")\n")
      cat("}\n")
      cat("library(ChIPseeker)\n")
      cat("library(TxDb.Hsapiens.UCSC.hg19.knownGene)\n")
      cat("txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene\n")
      cat("library(ReactomePA)\n")
      cat("library(clusterProfiler)")
      cat("\n")
      cat("\`\`\`\n")
      
      cat("\n\`\`\`{r read_RDS_3, message=FALSE, warning=FALSE}\n")
      cat(" #Read RDS object\n")
      cat(" meth <- readRDS(\"./data/processed_methrix.RDS\") ")
      cat("\n\`\`\`\n\n")
      
      cat("# bsseq object \n
A very important step of a WGBS data analysis is the differential methylation calling. During this step, we would like to identify changes between groups or conditions first on the site level. Then, we will need to identify larger regions (DMR-s, differentially methylated regions) affected by methylation changes that are more likely to represent functional alterations. Methrix doesn’t have a DMR caller, therefore we will use DSS. At this stage, DSS is not yet able to work directly with methrix, therefore we transform our methrix object to bsseq for the sake of DMR calling.\n")
      cat("\n\`\`\`{r bs_obj, message=FALSE, warning=FALSE}\n")
      cat("#transform methrix object to bsseq \n ")
      cat("bs_obj <- methrix::methrix2bsseq(meth)\n")
      cat("\n\`\`\`\n\n")
      
      cat("# Grouping for DM calling\n")
      cat("\n\`\`\`{r dml_test, echo=FALSE, cache=FALSE, results=FALSE, warning=FALSE, comment=FALSE, message=FALSE}\n")
      cat("dmlTest = DSS::DMLtest(bs_obj, group1 = which(colData(bs_obj)$") 
      cat(input$grouping)
      cat("== \"") 
      cat(input$group1)
      cat("\"), group2 = which(colData(bs_obj)$") 
      cat(input$grouping)
      cat("== \"") 
      cat(input$group2)
      cat("\"))")
      cat("\n\`\`\`\n\n")
      
      cat("#Differential Methylation Calling\n")
      cat("Differential methylation is called using DSS package. However, DMRs and DMLs are saved in data folder of workflow project as RDS as well as TSV format.")
      cat("\n\`\`\`{r calling_dmr_dml, message=FALSE, warning=FALSE}\n")
      cat("dmls = DSS::callDML(dmlTest, p.threshold = 0.05)\n")
      cat("dmrs = DSS::callDMR(dmlTest, p.threshold = 0.05)\n")
      cat("write.table(dmls, file = \"./data/dmls.tsv\", quote = F, sep = \"\t\")\n")
      cat("write.table(dmrs, file = \"./data/dmrs.tsv\", quote = F, sep = \"\t\")\n")
      cat("saveRDS(dmrs,\"./data/dmrs.RDS\")\n")
      cat("saveRDS(dmls, \"./data/dmls.RDS\")\n")
      cat("head(dmrs)\n")
      cat("head(dmls)\n")
      cat("\n\`\`\`\n\n")
      
      sink()
      
      anno_and_visualization_filePath <- reactive({normalizePath("analysis/04_anno_visualization.Rmd", winslash = "/")})
      
      sink( file = anno_and_visualization_filePath())
      
      cat("---\n")
      cat("title: \"annotation_visualization\"\n")
      cat("author: ",input$authorName,"\n")
      cat("date: \'\`r format(Sys.time(), \"%d %B, %Y\")\`\'\n")
      cat("output:\n")
      cat("    workflowr::wflow_html:\n")
      cat("        toc: false\n")
      cat("        code_folding: \"hide\"\n")
      cat("editor_options:\n")
      cat("    chunk_output_type: console\n")
      cat("---\n")
      
      cat("\n\`\`\`{r lib_4, message=FALSE, warning=FALSE }\n
        # Installing libraries\n")
      cat("if(!requireNamespace(\"ChIPseeker\")) {\n")
      cat("BiocManager::install(\"ChIPseeker\")\n")
      cat("}\n")
      cat("if(!requireNamespace(\"TxDb.Hsapiens.UCSC.hg19.knownGene\")) {\n")
      cat("BiocManager::install(\"TxDb.Hsapiens.UCSC.hg19.knownGene\")\n")
      cat("}\n")
      cat("if(!requireNamespace(\"ReactomePA\")) {\n")
      cat("BiocManager::install(\"ReactomePA\")\n")
      cat("}\n")
      cat("if(!requireNamespace(\"clusterProfiler\")) {\n")
      cat("BiocManager::install(\"clusterProfiler\")\n")
      cat("}\n")
      cat("if(!requireNamespace(\"plotly\")) {\n")
      cat("install.packages(\"plotly\")\n")
      cat("}\n")
      cat("if(!requireNamespace(\"ggplot2\")) {\n")
      cat("install.packages(\"ggplot2\")\n")
      cat("}\n")
      cat("if(!requireNamespace(\"scales\")) {\n")
      cat("install.packages(\"scales\")\n")
      cat("}\n")
      cat("library(plotly)\n")
      cat("library(ggplot2)\n")
      cat("library(scales)\n")
      cat("library(ChIPseeker)\n")
      cat("library(TxDb.Hsapiens.UCSC.hg19.knownGene)\n")
      cat("txdb <-TxDb.Hsapiens.UCSC.hg19.knownGene\n")
      cat("library(ReactomePA)\n")
      cat("library(clusterProfiler)\n")
      cat("\n\`\`\`\n\n")
      
      cat("\n\`\`\`{r read_RDS_4, message=FALSE, warning=FALSE}\n")
      cat(" # Read RDS object\n")
      cat(" dmrs <- readRDS(\"./data/dmrs.RDS\") \n")
      cat(" meth <- readRDS(\"./data/processed_methrix.RDS\")\n")
      cat("\n\`\`\`\n\n")
      
      cat("# Visualizing DMRs\n")
      cat("# Heatmap of DMR\n")
      cat("Top 50 DMRs are shown in the heatmap\n")
      cat("\n\`\`\`{r dm_heatmap, message=FALSE, warning=FALSE}\n")
      cat("heatmap_data <- as.data.frame(methrix::get_region_summary(meth, makeGRangesFromDataFrame(dmrs)))\n")
      cat("heatmap_data <- heatmap_data[complete.cases(heatmap_data),]\n")
      cat("pheatmap::pheatmap(mat = head(heatmap_data[,-(1:5)], 50), show_rownames = F, annotation_col = as.data.frame(meth@colData), fontsize = 8)\n")
      cat("\n\`\`\`\n\n")
      
      cat("# Number and Size of DMRs\n")
      
      cat("# Number of DMRs\n")
      
      cat("\n\`\`\`{r num_of_dmrs, message=FALSE, warning=FALSE}\n")
      cat("dmrs <- makeGRangesFromDataFrame(dmrs, keep.extra.columns =TRUE)\n")
      cat("count <- c(\"Higher in", paste0(input$group1)," \" = length(dmrs[dmrs$diff.Methy<0,]),
           \"Higher in", paste0(input$group2)," \" = length(dmrs[dmrs$diff.Methy>0,])) \n
           length <- c(\"Higher in", paste0(input$group1)," \" = sum(width(dmrs[dmrs$diff.Methy<0,])), 
            \"Higher in", paste0(input$group2)," \" = sum(width(dmrs[dmrs$diff.Methy<0,]))) \n")
      cat("data <- data.frame(Direction=c(\"Gain\", \"Loss\"), Count=count, Length=length)\n")
      cat("g <- ggplot(data=data)+geom_col(aes(x=factor(1), y=Count, fill=Direction), position = \"dodge\")+theme_bw()+theme(axis.title.x = element_blank(), axis.text.x = element_blank())+scale_fill_brewer(palette = \"Dark2\")+ggtitle(\"Number of differentially methylated regions\")+scale_y_continuous(labels = comma)\n")
      cat("ggplotly(g)")
      cat("\n\`\`\`\n\n")
      
      
      cat("# Length of DMRs \n")
      cat("\n\`\`\`{r size_of_dmrs, message=FALSE, warning=FALSE}\n")
      cat("   p <- ggplot(data=data)+geom_col(aes(x=factor(1), y=Length, fill=Direction), position = \"dodge\")+theme_bw()+theme(axis.title.x = element_blank(), axis.text.x = element_blank())+scale_fill_brewer(palette = \"Dark2\")+ggtitle(\"Length of differentially methylated regions\")+scale_y_continuous(labels = comma)\n")
      cat("ggplotly(p)\n")
      cat("\n\`\`\`\n\n")

      
      cat("# Regional annotation\n")
      cat("To describe and interpret the differentially methylated regions, we can use the ChIPseeker package. The location of the DMRs can already give us a hint the involved processes, but once we assign the regions to genes, a pathway enrichment analysis is also possible.")
      
      cat("\n\`\`\`{r regional_annotation, message=FALSE, warning=FALSE}\n")
      
      cat("peakAnnoList <- lapply(list(\"Higher in", paste0(input$group1)," \"=dmrs[dmrs$diff.Methy<0,], \"Higher in ",paste0(input$group2),"\" = dmrs[dmrs$diff.Methy>0,]), annotatePeak, TxDb=txdb, tssRegion=c(-3000, 3000), verbose=FALSE)\n")
      cat("ChIPseeker::plotAnnoBar(peakAnnoList)\n")
      cat("\n\`\`\`\n\n")
      
      
      
      
      
      sink()
      
      stopApp()
            })
    }
  )
}