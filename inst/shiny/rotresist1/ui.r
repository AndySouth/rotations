#rotations/shiny/rotresist1/ui.r
#andy south 9/10/17
#initially copied from resistance/resistmopb2

library(shiny)


shinyUI(fluidPage( theme = "bootstrap_simplex.css",
#shinyUI(fixedPage( theme = "bootstrap_simplex.css",
 
  #can add CSS controls in here
  #http://shiny.rstudio.com/articles/css.html
  #http://www.w3schools.com/css/css_rwd_mediaqueries.asp
  tags$head(
    tags$style(HTML("

                    [class*='col-'] {
                        padding: 5px;
                        border: 1px;
                        position: relative;
                        min-height: 1px;
                    }

                    .container {
                      margin-right: 0;
                      margin-left: 0;
                      float: left;
                    }
                    .col-sm-1 {width: 8.33%; float: left;}
                    .col-sm-2 {width: 16.66%; float: left;}
                    .col-sm-3 {width: 25%; float: left;}
                    .col-sm-4 {width: 33.33%; float: left;}
                    .col-sm-5 {width: 41.66%; float: left;}
                    .col-sm-6 {width: 50%;  float: left; padding: 0px;} !to make more space for plots
                    .col-sm-7 {width: 58.33%; float: left;}
                    .col-sm-8 {width: 66.66%; float: left;}
                    .col-sm-9 {width: 75%; float: left;}
                    .col-sm-10 {width: 83.33%; float: left;}
                    .col-sm-11 {width: 91.66%; float: left;}
                    .col-sm-12 {width: 100%; float: left;}
                    
                    "))
    ),  
     
  title = "insecticide rotations effects on resistance",
  
  h6("Evolution of resistance to insecticides used in rotations. Needs to be run on a widescreen. Modify inputs and compare 2 scenarios. by @southmapr"),  
  
  #fixedRow(
  fluidRow(
    #column(1),    
    column(6, plotOutput('plotA')),
    column(6, plotOutput('plotB'))
    #column(1)    
  ), #end fixed row
  
  fluidRow(
    column(2, p()),
    column(2, actionButton('aButtonRunA', 'Run Scenario A')),
    #column(3, h6("(takes a few seconds)")),
    column(1, sliderInput("max_generations", "generations", val=150, min = 100, max = 500, step = 50, ticks=FALSE)),
    column(1, p()), 
    column(1, checkboxInput("logy", "log y axis", FALSE)),
    column(2, actionButton('aButtonRunB', 'Run Scenario B')),
    column(2, p())
  ), #end fixed row
  
  
  hr(),
  
  fluidRow(
    column(1,
           h5("scenario "),
           h2("A"),
           hr(),
           h2("B")
    ),
    column(1, offset = 0,
           h5("n. insecticides"),
           sliderInput("n_A", NULL, val=3, min = 1, max = 5, step = 1, ticks=FALSE),
           hr(), #hr(),hr(),
           sliderInput("n_B", NULL, val=3, min = 1, max = 5, step = 1, ticks=FALSE),
           hr()
    ), 
    # moved up to one slider for both scenarios
    # column(1, offset = 0,
    #        h5("generations"),
    #        sliderInput("max_generations_A", NULL, val=150, min = 100, max = 500, step = 50, ticks=FALSE),
    #        hr(), #hr(),hr(),
    #        sliderInput("max_generations_B", NULL, val=150, min = 100, max = 500, step = 50, ticks=FALSE),
    #        hr()
    # ),  
    column(1, offset = 0,
           h5("interval"),
           sliderInput("rotation_interval_A", NULL, val=50, min = 0, max = 100, step = 10, ticks=FALSE),
           hr(), #hr(),hr(),
           sliderInput("rotation_interval_B", NULL, val=50, min = 0, max = 100, step = 10, ticks=FALSE),
           hr()
    ),     
    column(1,
           h5("start freq."),
           sliderInput("frequency_A", NULL, val=0.01, min = 0.0001, max = 0.1, step = 0.001, ticks=FALSE),
           hr(),
           sliderInput("frequency_B", NULL, val=0.01, min = 0.0001, max = 0.1, step = 0.001, ticks=FALSE),
           hr()          
    ),    
    column(1, offset = 0,
           h5("dominance, selection"),
           sliderInput("dom_sel_A", NULL, val=0.5, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr(),
           sliderInput("dom_sel_B", NULL, val=0.5, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr()
    ),
    column(1, offset = 0,
           h5("dominance, cost"),
           sliderInput("dom_cos_A", NULL, val=0.5, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr(),
           sliderInput("dom_cos_B", NULL, val=0.5, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr()
    ),
    column(1, offset = 0,
           h5("exposure"),
           sliderInput("exposure_A", NULL, val=0.5, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr(),#hr(),hr(),
           sliderInput("exposure_B", NULL, val=0.5, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr()
     ),    
    column(1, offset = 0,
           h5("effectiveness"),
           sliderInput("effectiveness_A", NULL, val=0.5, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr(),
           sliderInput("effectiveness_B", NULL, val=0.5, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr()           
    ),
    column(1, offset = 0,
           h5("RR restoration"),
           sliderInput("advantage_A", NULL, val=0.5, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr(),
           sliderInput("advantage_B", NULL, val=0.5, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr()          
    ),
    column(1, offset = 0,
           h5("coverage"),
           sliderInput("coverage_A", NULL, val=0.8, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr(),#hr(),hr(),
           sliderInput("coverage_B", NULL, val=0.8, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr()
    ),     
    column(1, offset = 0,
           h5("migration"),
           sliderInput("migration_A", NULL, val=0.01, min = 0, max = 0.1, step = 0.001, ticks=FALSE),
           hr(),#hr(),hr(),
           sliderInput("migration_B", NULL, val=0.01, min = 0, max = 0.1, step = 0.001, ticks=FALSE),
           hr()
    ),  
    column(1, offset = 0,
           h5("cost"),
           sliderInput("cost_A", NULL, val=0.1, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr(),
           sliderInput("cost_B", NULL, val=0.1, min = 0, max = 1, step = 0.1, ticks=FALSE),
           hr()          
    )    
    # column(2, offset = 0,
    #        h5("Extra params not included in Curtis"),
    #        numericInput("correct_mix_deploy", "Mixture correct deployment", 1, min = 0, max = 1, step = 0.1),
    #        checkboxInput("addCombinedStrategy", "plot adaptive strategy",FALSE)
    # )
  ) #end fixed row

))