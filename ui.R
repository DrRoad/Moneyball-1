library(shiny)

fluidPage(
    tags$head(
        tags$style(HTML("
            .shiny-text-output {
                color:navy;
                font-size:large;
                font-weight:bold;
            }
        "))
    ),
    headerPanel(
        h1("MONEYBALL", style='color:navy')
    ),
    h3("Estimating Runs Scored by a Baseball Team", style='color:navy'),
    p(paste("This application uses a regression model built with data",
        "from 2000 - 2008 for every major-league baseball team.",
        "It applies this model, which predicts the number",
        "of runs scored by a team. The application also gives",
        "the 95% confidence interval of the prediction.")
    ),
    p(paste("Use the sliders to adjust the inputs, such as singles,",
        "doubles, etc. Notice the effects on the number of runs scored",
        "by the team and the resulting confidence interval for the prediction.")
    ),
    sidebarLayout(
    sidebarPanel(
        fluidRow(
            column(6,
                   sliderInput("singles", "Singles:", 
                               min = 0, max = 5000, value = 995, step = 1),
                   sliderInput("doubles", "Doubles:", 
                               min = 0, max = 1500, value = 309, step = 1),
                   sliderInput("triples", "Triples:", 
                               min = 0, max = 100, value = 34, step = 1),
                   sliderInput("homeruns", "Home Runs:", 
                               min = 0, max = 600, value = 236, step = 1)
            ),
            column(6,
                   sliderInput("walks", "Walks:", 
                               min = 0, max = 2000, value = 608, step = 1),
                   sliderInput("hitbypitch", "Hit by Pitch:", 
                               min = 0, max = 300, value = 93, step = 1),
                   sliderInput("sacrificeflies", "Sacrifice Flies:", 
                               min = 0, max = 150, value = 52, step = 1),
                   sliderInput("stolenbases", "Stolen Bases:", 
                               min = 0, max = 150, value = 47, step = 1),
                   sliderInput("caughtstealing", "Caught Stealing:", 
                               min = 0, max = 150, value = 43, step = 1)
            )
        ), width = 8
    ),
    mainPanel(
        fluidRow(
            column(12,
                   h4('Estimated runs scored based on your input:'),
                   textOutput('estimatedRuns'),
                   br(),
                   h4('95% confidence interval:'),
                   textOutput('ci')
            )
        ), width=4
    )),
    br(),
    p(style='color:purple',"Data and data model from ",
      a("R in a Nutshell", 
        href="http://web.udl.es/Biomath/Bioestadistica/R/Manuals/r_in_a_nutshell.pdf"),
      "by Joseph Adler, 2010.")
)

