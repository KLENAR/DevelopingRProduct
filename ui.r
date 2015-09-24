library(shiny)
library(ltm)

shinyUI(fluidPage(
  titlePanel("IRT Using the ltm Package"),
  sidebarLayout(
    sidebarPanel(
      
      helpText("For detailes you can see README.md at https://github.com/KLENAR/DevelopingRProduct/blob/master/README.md"),
    
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
        
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"')
      ),
    mainPanel(
      
      h4("Student's Test Results"),
      tableOutput('contents'),
      
      h4("Descriptive Analyses of Student's Test Results"),
      verbatimTextOutput('descriptive'),
      
      h4(" Plot ICCs"),
      plotOutput('distPlot'),
      
      h4("Ability Estimates"),
      verbatimTextOutput('ability'),
      
      h4(" Fit 2PL Model"),
      verbatimTextOutput('summary') 
    )
  )
))