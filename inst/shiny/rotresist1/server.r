#rotations/shiny/rotresist1/server.r
#andy south 9/10/17
#initially copied from resistance/resistmopb2


library(shiny)
#library(devtools)
#install_github('AndySouth/rotations')
library(rotations)


shinyServer(function(input, output) {
    
  
  output$plotA <- renderPlot({
    
    #add dependency on the button
    if ( input$aButtonRunA >= 0 ) 
    {
      #isolate reactivity of other objects
      isolate({
        
        #cat("running resistSimple with these inputs:", input$P_1, input$P_2*input$P_1, input$h.RS1_00, input$h.RS2_00,"\n")
        
        run_rot(n_insecticides =    input$n_A, 
                max_generations =   input$max_generations_A,
                start_freqs =       input$frequency_A,
                rotation_interval = input$rotation_interval_A, 
                eff =               input$effectiveness_A,
                dom =               input$dominance_A,
                rr =                input$advantage_A,
                expo_hi =           input$exposure_A,
                coverage =          input$coverage_A,
                migration_rate_intervention = input$migration_A, 
                cost =              input$cost_A,
                logy =              input$logy ) #inefficient that it reruns when changing to log

                
        # a hack to output the inputs, so it can be run from the console
        cat("A:\n")
        cat("run_rot( n_insecticides =",input$n_A,",", 
                      "max_generations =",input$max_generations_A,",", 
                      "start_freqs =",input$frequency_A,",", 
                      "rotation_interval =",input$rotation_interval_A,",",
                      "eff =",input$effectiveness_A,",",
                      "dom =",input$dominance_A,",",
                      "rr =",input$advantage_A,",",
                      "expo_hi =",input$exposure_A,",",
                      "coverage =",input$coverage_A,",",
                      "migration_rate_intervention =",input$migration_A,",",
                      "cost =",input$cost_A,",",
                      "logy =",input$logy,
                      ")\n" )
        
               
      }) #end isolate  
    } #end button
  })

  output$plotB <- renderPlot({
    
    #add dependency on the button
    if ( input$aButtonRunB >= 1 ) 
    {
      #isolate reactivity of other objects
      isolate({
        
        run_rot(n_insecticides =    input$n_B, 
                max_generations =   input$max_generations_B,
                start_freqs =       input$frequency_B,
                rotation_interval = input$rotation_interval_B, 
                eff =               input$effectiveness_B,
                dom =               input$dominance_B,
                rr =                input$advantage_B,
                expo_hi =           input$exposure_B,
                coverage =          input$coverage_B,
                migration_rate_intervention = input$migration_B, 
                cost =              input$cost_B,
                logy =              input$logy ) #inefficient that it reruns when changing to log
        
        
        
        # a hack to output the inputs, so it can be run from the console
        cat("B:\n")
        cat("run_rot( n_insecticides =",input$n_B,",", 
            "max_generations =",input$max_generations_B,",", 
            "start_freqs =",input$frequency_B,",", 
            "rotation_interval =",input$rotation_interval_B,",",
            "eff =",input$effectiveness_B,",",
            "dom =",input$dominance_B,",",
            "rr =",input$advantage_B,",",
            "expo_hi =",input$exposure_B,",",
            "coverage =",input$coverage_B,",",
            "migration_rate_intervention =",input$migration_B,",",
            "cost =",input$cost_B,",",
            "logy =",input$logy,
            ")\n" )
        
      }) #end isolate  
    } #end button
  })  
  
    
})