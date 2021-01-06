

server <-   function(input, output, session){

  projectDetailsserver("read_in")
  bedgraphFilepathsServer("read_in")
  codeGeneration("read_in")
  sampleAnnotationserver("read_in")
  preprocessServer("read_in")
  
  
  
  
  observeEvent(input$tab1Next,{
    updateTabsetPanel(session, 
                      "mES1",
                      selected = "readIn")
  })
  
  
  observeEvent(input$tab2Previous,{
    updateTabsetPanel(session,
                      "mES1",
                      selected = "start")
  })
  
  observeEvent(input$tab2Next,{
    updateTabsetPanel(session,
                      "mES1",
                      selected = "preprocess")
  })
  
    
   
    
    observeEvent(input$tab1Next,{
      updateTabsetPanel(session, 
                        "mES1",
                        selected = "readIn")
    })
    
   
    
    
    
    
    observeEvent(input$tab2Previous,{
      updateTabsetPanel(session,
                        "mES1",
                        selected = "start")
    })
    
    observeEvent(input$tab2Next,{
      updateTabsetPanel(session,
                        "mES1",
                        selected = "preprocess")
    })
    
   
    
    
}




