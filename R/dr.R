# dr - David Rodrigues (dr) package with util functions
# @author: David Rodrigues <david @ sixhat . net>
# @version: 0.1

## SCALES 
dr.scale.linear <- function(values, domain=c(0,1), range=c(0,1)){
  # Scales linearly the values of the variable values to the [min, max] range
    dmin=domain[1]
    dmax=domain[2]
    min=range[1]
    max=range[2]
  
  return ((values-dmin)*(max-min)/(dmax-dmin)+min)
}
dr.scale <- function(values, domain=c(0,1), range=c(0,1)){
  # Reverts back to dr.scale.linear
  return (dr.scale.linear(values, domain, range))
}


## TIMELINE
dr.timeline <- function(df, format = "%Y-%m-%d", ordered = "Start", 
                     vlines = TRUE, xlab = "", main = "", ylab = "", spacing = "Start", 
                     scale = 1) {
  # Creates a timeline plot
  
  # Convert String Dates to POSIXct Objects
  df$Start <- as.POSIXct(df$Start, format = format)
  df$End <- as.POSIXct(df$End, format = format)
  
  # Make finish dates equal to starting dates if NA
  for (ct in 1:nrow(df)) {
    if (is.na(df[ct, 2])) {
      df[ct, 2] <- df[ct, 1]
    }
  }
  
  if (ordered == "End") {
    df <- df[with(df, order(End)), ]
  } else {
    df <- df[with(df, order(Start)), ]
  }
  
  
  mint <- min(df$Start)
  maxt <- max(df$End)
  
  if (!is.numeric(spacing)) {
    x = seq(from = mint, to = maxt + 5e+08, length.out = 10)
    y = rep(0, times = 10)
    deltax = (maxt - mint)/10
  } else {
    x = seq(from = mint, to = maxt + 5e+08, length.out = spacing)
    y = rep(0, times = spacing)
    deltax = (maxt - mint)/spacing
  }
  
  
  ylim = c(0, floor(nrow(df) * scale))
  par(pch = 20, cex = 0.6)
  
  
  
  # Plot empty Timeline and add Dates Axis
  plot(x, y, type = "n", ylim = ylim, xaxt = "n", yaxt = "n", ylab = ylab, 
       main = main, xlab = xlab, axes = F)
  #axis.POSIXct(1,at=x,format='%Y-%m-%d', pos=0)
  
  if (spacing == "Start") {
    axis.POSIXct(1, at = df$Start, format = "%Y", pos = 0)
  } else if (spacing == "End") {
    axis.POSIXct(1, at = df$End, format = "%Y", pos = 0)
  } else {
    axis.POSIXct(1, at = x, format = "%Y", pos = 0)
  } 
  
  # For Each Timeline plot the horizontal line and its Label
  # 1st Step - Draw Background vertical lines and Single Points
  for (ct in 1:nrow(df)) {
    if (df[ct, 1] < df[ct, 2]) {
      
      if (vlines) 
        lines(c(df[ct, 1], df[ct, 1]), c(0, ct), col = "gray", 
              lwd = 0.5)
      
      lpos = df[ct, 1]
      text(lpos, ct + 0.4, df[ct, 3], pos = 4)
    }
    # If Same date plot circle with text centered above.
    if (df[ct, 1] == df[ct, 2]) {
      if (vlines) 
        lines(c(df[ct, 1], df[ct, 1]), c(0, ct), col = "gray", 
              lwd = 0.5)
      lpos = df[ct, 1]
      text(lpos, ct + 0.2, df[ct, 3], pos = 3)
      points(c(df[ct, 1], df[ct, 2]), c(ct, ct), cex = 1.4, pch = 21)
    }
  }
  
  #pal=rainbow(length(unique(df$Opt)))
  #cols=as.numeric(factor(df$Opt))
  cols = factor(df$Opt)
  pal = rainbow(nlevels(cols))
  
  #  pal=rainbow(length(cols));
  
  # 2nd Step - Draw Horizontal Lines.
  for (ct in 1:nrow(df)) {
    # If Start and Finish date plot horizontal bold line with text left
    #   aligned
    if (df[ct, 1] < df[ct, 2]) {
      if (df[ct, 4] == "ARQ") {
        points(c(df[ct, 1], df[ct, 2]), c(ct, ct), cex = 1.5, 
               pch = 20, col = "black")
        lines(c(df[ct, 1], df[ct, 2]), c(ct, ct), lwd = 3, col = "black")
      } else if (df[ct, 4] == "GOV") {
        points(c(df[ct, 1], df[ct, 2]), c(ct, ct), cex = 1.5, 
               pch = 20, col = "blue")
        lines(c(df[ct, 1], df[ct, 2]), c(ct, ct), lwd = 3, col = "blue")
      } else if (df[ct, 4] == "PM") {
        points(c(df[ct, 1], df[ct, 2]), c(ct, ct), cex = 1.5, 
               pch = 20, col = "red")
        lines(c(df[ct, 1], df[ct, 2]), c(ct, ct), lwd = 3, col = "red")
      } else {
        points(c(df[ct, 1], df[ct, 2]), c(ct, ct), cex = 1.5, 
               pch = 20, col = pal[cols[ct]])
        lines(c(df[ct, 1], df[ct, 2]), c(ct, ct), lwd = 3, col = pal[cols[ct]])
      }
    }
  }
}
# Example Usage of dr.timeline
# First read the kings of portugal timeline 
reis <- read.table("reis-portugal.txt", header = T, sep = "\t", 
                   na.strings = "NA", stringsAsFactors = F)

# plot the timeline of the 4 distanies.
dr.timeline(reis, format = "%d %b %Y", ordered = "Start", vlines = F, 
            xlab = "Ano", main = "Reinados dos Reis de Portugal", spacing = 100, 
            scale = 1)
