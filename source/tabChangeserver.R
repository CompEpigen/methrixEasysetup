
tabChangeserver <- function(id, label = label){
  
  moduleServer(id,
               function(input, output, session){
                
                
                 observeEvent(input$tab2Previous,{
                   updateTabsetPanel(session,
                                     "mES1",
                                     selected = "start")
                 })
                 
                 observeEvent(input$tab2Next,{
                   req(input$addsampleanno)
                   updateTabsetPanel(session,
                                     "mES1",
                                     selected = "preprocess")
                 })
                 
                 observeEvent(input$tab2Skip,{
                   updateTabsetPanel(session,
                                     "mES1",
                                     selected = "preprocess")
                 })
                 
                 observeEvent(input$tab3Previous,{
                   updateTabsetPanel(session,
                                     "mES1",
                                     selected = "readIn")
                 })
                 
                 observeEvent(input$tab1Next,{
                   updateTabsetPanel(session, 
                                     "mES1",
                                     selected = "readIn")
                 })
                 
                 observeEvent(input$tab3Next,{
                   updateTabsetPanel(session, 
                                     "mES1",
                                     selected = "dm_calling")
                 })
                 
                 observeEvent(input$tab4Previous,{
                   updateTabsetPanel(session, 
                                     "mES1",
                                     selected = "preprocess")
                 })
                 
               })
}