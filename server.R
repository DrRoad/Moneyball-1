# This code only gets run once for each new user session.
library(shiny)
library(nutshell)
library(lattice)

data(team.batting.00to08)

runs.mdl <- lm(
    formula=runs~singles+doubles+triples+homeruns+
        walks+hitbypitch+sacrificeflies+
        stolenbases+caughtstealing,
    data=team.batting.00to08)

# There is an instance of shinyServer running for each user.
shinyServer(
    function(input, output) {

        # Whenever an input changes, this code is run and creates all three output
        #   variables in the predictions variable.
        predictions <- reactive({
            newdata <- data.frame(singles=as.numeric(input$singles),
                                  doubles=as.numeric(input$doubles),
                                  triples=as.numeric(input$triples),
                                  homeruns=as.numeric(input$homeruns),
                                  walks=as.numeric(input$walks),
                                  hitbypitch=as.numeric(input$hitbypitch),
                                  sacrificeflies=as.numeric(input$sacrificeflies),
                                  stolenbases=as.numeric(input$stolenbases),
                                  caughtstealing=as.numeric(input$caughtstealing))
            predictions <- predict(runs.mdl,newdata, interval="confidence")
            predictions
        })
        
        # Each of the three outputs is set and the calculations above only need 
        #   to run once.
        output$estimatedRuns <- renderText({ round(predictions()[1],digits=0) })
        output$ci <- renderText({ paste(round(predictions()[2],digits=0), "-", 
                                        round(predictions()[3],digits=0)) })
  }
)

