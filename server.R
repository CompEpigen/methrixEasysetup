

server <-   function(input, output, session){

  projectDetailsserver("read_in")
  bedgraphFilepathsServer("read_in")
  codeGeneration("read_in")
  sampleAnnotationserver("read_in")
  preprocessServer("read_in")
  tabChangeserver("read_in")
  
  observe_helpers(withMathJax = TRUE)
  
  
  
  
   
    
    
}




