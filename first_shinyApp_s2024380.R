library(shiny)

ui <- fluidPage( 
  pageWithSidebar( 
    headerPanel("Tutorial WQD7001 Shiny App - Student : S2024380 "),
    
    sidebarPanel(
      selectInput("Distribution", "Please Select Distribution Type",
                  choices = c("Normal", "Exponential")),
      sliderInput("sampleSize", "Please Select Sample Size",
                  min = 100, max = 5000, value = 1000, step = 100),
      conditionalPanel(condition = "input.Distribution == 'Normal'",
                       textInput("Mean", "Please Select the mean", 10),
                       textInput("SD", "Please Select Standard Deviation", 3)),
      conditionalPanel(condition = "input.Distribution == 'Exponential'",
                       textInput("Lambda", "Please Select Lambda:",1))
    ),
    
    mainPanel( 
      plotOutput("myPlot")
    )
  )
  
)

server <- function(input, output, session) {
  
  output$myPlot <- renderPlot({
    distType <- input$Distribution
    size <- input$sampleSize
    
    if(distType == "Normal"){
      randomVec <- rnorm(size, mean = as.numeric(input$Mean), sd = as.numeric(input$SD))
    }
    else{
      randomVec <- rexp(size, rate = 1/as.numeric(input$Lambda))
    }
    
    hist(randomVec, col = "#b86e83")
  })
  
}

shinyApp(ui, server)

#reference : https://www.youtube.com/watch?v=Gyrfsrd4zK0&ab_channel=ehsanjahanpour