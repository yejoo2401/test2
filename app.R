library(shiny)
ui<- fluidPage(
  
  selectInput(inputId = "n_breaks",label = "Number of bins in histogram:",
              choices = c(1,5,10),selected = 5),
  checkboxInput(inputId = "individual_obs",
                label = strong("Show individual observations"),
                value = FALSE),
  checkboxInput(inputId = "density",
                label = strong("Show density estimate"),
                value = FALSE),
  plotOutput(outputId = "main_plot", height = "400px"),
  
  conditionalPanel(condition = "input.density==true",
                   sliderInput(inputId = "bw_adjust",
                               label = "Bandwidth adjustment:",
                               min = 0.3,max=3,value = 1,step=0.2))
)

server<- function(input,output) {
  
  output$main_plot <- renderPlot({
    
    hist(shopbarchart$N, probability = TRUE, 
         breaks = as.numeric(input$n_breaks),
         xlab = "number", main = "shop usage")
    
    if(input$individual_obs){
      rug(shopbarchart$N)
    }
    
    if(input$density){
      dens<-density(shopbarchart$N, adjust = input$bw_adjust)
      lines(dens, col="red")
    }
    
  })
}

#console: runApp("0602newdir2")
shinyApp(ui=ui, server = server)
