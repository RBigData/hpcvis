#' Benchmark Plotter
#' 
#' Simple benchmarks plotter.
#' 
#' \code{benchplot()} produces simple benchmark plots. If multiple benchmarks
#' are given (i.e., multiple columns are present in the \code{timings}
#' dataframe) then the generated plot will automatically plot them against each
#' other, separated by color.
#' 
#' @param cores Numeric vector containing the cores used in each benchmark.
#' @param timings A dataframe containing the wall-clock timings of each
#' benchmark.
#' @param plot.type character; determines what kind of plot to produce.
#' options are "runtime", "speedup", or "both".
#' @param title character or NULL; plot title.
#' @keywords utility
#' @examples
#' 
#' \dontrun{
#' library(pbdPROF)
#' 
#' x <- c(1, 2, 4, 6, 8, 10, 12, 16)
#' y <- c(111.424, 80.696, 42.832, 29.468, 24.060, 19.390, 15.938, 11.860)
#' 
#' benchplot(x, y, "both")
#' }
#' 
benchplot <- function(cores, timings, plot.type="speedup", title=NULL)
{
  ### Fool R CMD check
  Cores <- value <- variable <- NULL
  rm(list = c("Cores", "value", "variable"))
  
  
  
  plot.type <- match.arg(tolower(plot.type), c("speedup", "runtime", "both"))
  
  if (plot.type == "both")
  {
    g1 <- benchplot(cores=cores, timings=timings, plot.type="runtime", title=title)
    g2 <- benchplot(cores=cores, timings=timings, plot.type="speedup", title=title)
    
    g <- arrangeGrob(g1, g2, ncol=2)
    
    return( g )
  }
  
  n <- ncol(timings)
  
  df <- data.frame(Cores=cores, timings)
  names(df)[1L] <- "Cores"
  
  
  ### Multiple sets of timings
  if (ncol(df) > 2)
  {
    if (plot.type == "runtime")
    {
      df <- melt(df, id.vars="Cores")
      
      g <- ggplot(df, aes(x=Cores, y=value, group=variable))
    }
    else if (plot.type == "speedup")
    {
      
      for (i in 2:ncol(df))
        df[, i] <- df[1L, i] / df[, i]
      
      df <- melt(df, id.vars="Cores")
      
      slope <- 1
      intercept <- 0
      
      g <- ggplot(df, aes(x=Cores, y=value, group=variable)) + 
             geom_abline(intercept=intercept, slope=slope, linetype="dashed") +
             ylab(paste("Speedup Relative to", df[1,1], "Core(s)"))
    }
    
    g <- g +
           geom_point(aes(colour=variable)) + 
           geom_line(aes(colour=variable), size=1) +
           theme(legend.direction="horizontal",
             legend.position=c(.5, .972)) + 
           labs(title=title,
             colour=element_blank()) 
  }
  
  ### One set of timings
  else
  {
    yname <- names(df)[2L]
    
    if (plot.type == "runtime")
    {
      g <- ggplot(df, aes_string(x="Cores", y=yname)) + 
             ylab("Run Time")
    }
    else if (plot.type == "speedup")
    {
      df[, 2] <- df[1, 2] / df[, 2]
      
      slope <- 1
      intercept <- 0
      
      g <- ggplot(df, aes_string(x="Cores", y=yname)) + 
             geom_abline(intercept=intercept, slope=slope, linetype="dashed") +
             ylab(paste("Speedup Relative to", df[1,1], "Core(s)"))
    }
    
    g <- g + 
           geom_point() + 
           geom_line(size=1) +
           labs(title=title)
  }
  
  
  return( g )
}
