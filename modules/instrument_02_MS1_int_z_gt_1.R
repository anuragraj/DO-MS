init <- function() {
  
  tab <- '020 Instrument Performance'
  boxTitle <- 'MS1 Intensity for z>1 ions'
  help <- 'Plotting the MS1 intensity for all peptide-like ions observed (not necessarily sent to MS2) across runs.'
  source.file <- 'allPeptides'
  
  .validate <- function(data, input) {
    validate(need(data()[[source.file]],paste0("Upload ", source.file,".txt")))
  }
  
  .plotdata <- function(data, input) {
    plotdata <- data()[[source.file]][,c("Raw.file","Charge", "Intensity")]
    plotdata$Intensity <- log10(plotdata$Intensity)
    plotdata <- plotdata[plotdata$Charge > 1,]
    return(plotdata)
  }
  
  .plot <- function(data, input) {
    .validate(data, input)
    plotdata <- .plotdata(data, input)
    
    ggplot(plotdata, aes(Intensity)) + 
      facet_wrap(~Raw.file, nrow = 1) + 
      geom_histogram() + 
      coord_flip() + 
      labs(x=expression(bold("Log"[10]*" Precursor Intensity")), y='Count') +
      theme_base(input=input)
  }
  
  return(list(
    tab=tab,
    boxTitle=boxTitle,
    help=help,
    source.file=source.file,
    validateFunc=.validate,
    plotdataFunc=.plotdata,
    plotFunc=.plot,
    dynamic_width=75
  ))
}
