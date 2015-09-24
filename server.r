library(shiny)
library(ltm)
shinyServer(function(input, output, session) {
  
  # Demo datatable    
  mytable<-matrix(c(0 ,0 ,0 ,1 ,
                    0 ,1 ,0 ,1 ,
                    0 ,1 ,1 ,1 ,
                    0 ,1 ,1 ,0 ,
                    1 ,1 ,1 ,0 ),
                  ncol=4,byrow=TRUE)
  colnames(mytable)<-c("item1","item2","item3","item4")
  
  # Dataset
  v <- reactiveValues(data = as.data.frame(mytable) ) 
  
  # Return the requested dataset to 'contents'
  output$contents <- renderTable({
    inFile <- input$file1
    if (is.null(inFile))
    {
        v$data<-as.data.frame(mytable)  
    }  
    else
    {
      v$data<- read.csv(inFile$datapath, header=input$header, sep=input$sep, 
                       quote=input$quote) 
    }
    v$data
   })
  
  # Return the plot to 'distPlot'
  output$distPlot <- renderPlot({
    fit2PL <- ltm(v$data ~ z1)
    plot(fit2PL, legend = TRUE, cx = "bottomright")
    })
  
  # Return the descriptive statistics for the test data-set to 'descriptive'  
  output$descriptive <- renderPrint({
    descript( v$data)
  })
  
  # Return the summary to 'summary'  
  output$summary <- renderPrint({
    fit2PL <- ltm(v$data ~ z1)
    summary(fit2PL)
  })
  
  # Return the ability estimations 'ability'  
  output$ability <- renderPrint({
    fit2PL <- ltm(v$data ~ z1)
    factor.scores(fit2PL)
    })
  
  
  
  
})