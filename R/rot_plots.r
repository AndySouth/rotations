#' rot_plot_resistance plot rotation simulation resistance results
#'
#' @param df_res2 dataframe of resistance results from run_rot()
#' @param plot_refuge whether to plot refuge as well as intervention
#' @param rot_criterion resistant allele frequency threshold to add to plots, set to NULL to not add
#' @param logy whether to use log scale for y axis
#' @param add_gens_under50 whether to add a label of num generations under 50percent resistance
#' @param df_resanother exploratory option to plot results of another scenario on the same graph
#' @param lwd line thickness for resistance curves
#' @param title optional title for plot, NULL for no title
#' @param plot whether to plot results
#' @param plot_mortality whether to add mortality to plots
#'
# check said that namespace dependencies not required
# @import ggplot2
# @importFrom stringr str_detect
#' @return ggplot object
#' @export
#'
#' @examples
#' df_res2 <- run_rot()
#' rot_plot_resistance(df_res2)
#' 

#' 
rot_plot_resistance <- function(df_res2,
                                plot_refuge = TRUE,
                                rot_criterion = 0.5,
                                logy = TRUE,
                                add_gens_under50 = TRUE,
                                df_resanother = NULL,
                                lwd = 1.5,
                                title = NULL,
                                plot = TRUE,
                                plot_mortality = TRUE) {
  
  # column names of input dataframe
  # "generation"  "insecticide"     "resist_gene"  "active_or_refuge" "resistance"
  
  # filter out refuge if not wanted (if coverage=1 no refuge anyway)
  #if (!plot_refuge) df_res2 <- filter(df_res2, active_or_refuge != 'refuge')
  if (!plot_refuge) df_res2 <- df_res2[df_res2$active_or_refuge=='active',]
  
  # to allow plotting of insecticide in use
  # add column which has a value if insecticide in use & NA if not
  # the value determines where the line appears on the y axis
  to_plot_in_use <- 1
  
  df_res2 <- df_res2 %>%
    #mutate( i_in_use = ifelse(stringr::str_detect(region,paste0(insecticide,"_active")),1.05,NA))    
    #now that active & refuge on same plot
    dplyr::mutate( i_in_use = ifelse(resist_gene==paste0('insecticide',insecticide), to_plot_in_use, NA))    
  
  # only colour by active_or_refuge if there is a refuge
  if (plot_refuge) {
    gg <- ggplot( df_res2, aes_string(x='generation',y='resistance',colour='active_or_refuge') ) +
    geom_line( alpha=0.5, lwd=lwd ) +
    #legend for the lines, allows me to set title & labels  
    scale_colour_manual("areas connected\nby migration",values=c("red3","navy"), labels=c("treated","untreated refugia"))
  }   else
  {
    gg <- ggplot( df_res2, aes_string(x='generation',y='resistance')) +
    geom_line( alpha=0.5, lwd=lwd, colour='red3' ) 
    #legend for the lines  
    #scale_colour_manual("",values=c("red3"))      
  }

  # testing adding mortality to the plot
  # note mortality currently added in run_rot but actually we can calc from fixed conversion
  if (plot_mortality) {
    #gg <- ggplot( df_res2, aes_string(x='generation',y='mortality')) +
    #  geom_line( alpha=0.5, lwd=lwd, colour='red3' )
    dfactive <- df_res2[df_res2$active_or_refuge=='active',]
    gg <- gg +
      # add 90% mortality threshold
      geom_hline(yintercept=0.9, colour='green', linetype=3) +
    #  geom_line( aes_string(x='generation',y='mortality'), alpha=0.5, lwd=1, colour='purple', linetype=3 )    
      geom_line( data=dfactive, aes_string(x='generation',y='mortality'), alpha=0.5, lwd=1, colour='darkgreen', linetype=1 )    

    
    }  
   
  gg <- gg + 

    facet_wrap('resist_gene', ncol=1) +
    
    ylab("resistance allele frequency") +
    
    #theme(axis.text.x = element_blank()) +
    
    #trying to get 2nd legend (this puts i_in_use in middle OK start)
    #geom_line( aes_string(x='generation',y='i_in_use', colour=factor('i_in_use')), lwd=2) +
    
    #annotate("text", x = 0, y = 1.15, label = "deployment", size = 2.5, hjust='left') +

    #scale_y now below dependent on logy arg
    
    
    #add new insecticide use indication
    #when I do inherit.aes=FALSE the boxes don't appear
    #when TRUE the legend for the lines gets interfered with
    #geom_ribbon( data=df_res2, aes_string(x='generation', ymin=0, ymax='i_in_use'), inherit.aes = FALSE, fill = "grey90", alpha=0.1) + #,linetype=factor('i_in_use')), colour='green2', lwd=2) +
    geom_ribbon( aes_string(x='generation', ymin=0, ymax='i_in_use'), colour="grey30", fill = "grey80", alpha=0.2) + #,linetype=factor('i_in_use')), colour='green2', lwd=2) +
    
    #trying to add legend for the in_use ribbon, now doesn't work because colour is outside aes above
    #scale_fill_manual("",values="grey90") +
    
    #old insecticide use indication  
    # geom_line( aes_string(x='generation',y='i_in_use',linetype=factor('i_in_use')), colour='green2', lwd=2) +
    # scale_linetype_manual("insecticide in use", values=rep(1,4),
    #   #trying to set labls in override.aes didn't work                    
    #   guide=guide_legend(keywidth = 5, label=FALSE, override.aes = list(colour=c("green2")))) +
    
    theme_minimal() +
    
    # add line at resistance threshold
    if (! is.null(rot_criterion)) geom_hline(yintercept=rot_criterion, linetype=3) 
  
  # experimenting with plotting a 2nd scenario on the same graph
  if (!is.null(df_resanother))
  {
    #if (!plot_refuge) 
    #trying just plotting active
    df_resanother <- df_resanother[df_resanother$active_or_refuge=='active',]
    
    gg <- gg +
          #geom_line( data=df_resanother, alpha=0.5, lwd=2, colour='blue' )    
          geom_line( data=df_resanother, aes_string(x='generation',y='resistance'), alpha=0.5, lwd=lwd, colour='red3', linetype=3 )    

    # try adding insecticide use for 2nd scenario
    df_resanother <- df_resanother %>%
      dplyr::mutate( i_in_use = ifelse(resist_gene==paste0('insecticide',insecticide), to_plot_in_use, NA))  
    
    gg <- gg +    
          geom_ribbon( data=df_resanother, aes_string(x='generation', ymin=0, ymax='i_in_use'), colour="grey30", fill = "grey80", alpha=0.2, linetype=3 ) 
      
    
    
  }
  
  
  
  if (logy) gg <- gg + scale_y_continuous(trans='log10', 
                                         breaks=c(0.001,0.01,0.5,1),
                                         labels=c('0.1%','1%','50%','100%'),
                                         #labels = scales::percent,
                                         #labels = scales::comma,
                                         minor_breaks=NULL) +
                       theme(axis.text.y = element_text(size = rel(0.8))) #, angle = 90))
  
  else     gg <- gg + scale_y_continuous(breaks=c(0,0.25,0.5,0.75,1))
  
  # add text of num gens below 50%  
  if (add_gens_under50) {
    
    # without this didn't work for log scale
    if (logy) y <- 0
    else y <- -Inf
    
    gg <- gg + geom_text(aes(x=Inf, y=y, label=gens_dep_under50), colour='black', show.legend=FALSE, hjust=1, vjust=0)
    
  }
  
  if (!is.null(title)) gg <- gg + ggtitle(title)
    
  if (plot) plot(gg)
  
  invisible(gg)
} 


#insecticide use (currently restricted to 4)
#superceded, now done within rot_plot_resistance
rot_plot_use <- function(df_res2) {
  ggplot( df_res2, aes_string(x='generation',y='insecticide') ) + 
    geom_point(shape=1, colour='red') +
    #geom_line( colour='blue') +  
    #facet_wrap('region', ncol=2) +
    ylim(1,4) +
    theme_bw() 
  #theme(axis.text.x = element_blank()) 
}