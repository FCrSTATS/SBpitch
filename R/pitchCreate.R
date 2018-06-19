#' Create a pitch plot ready for Statsbomb data
#'
#' Creating a pitch plot using ggplot2 that is ready to plot actions on top. Numerous options allow customisation.
#'
#' @param grass_colour A string as a colour by word or #HEX code
#' @param line_colour A string as a colour by word or #HEX code
#' @param background_colour A string as a colour by word or #HEX code
#' @param goal_colour A string as a colour by word or #HEX code
#' @param goaltype String, either "line", "box" or "barcanumbers". Default "line"
#' @param middlethird Boolean. Default FALSE
#' @param BasicFeatures Boolean. Default FALSE
#' @param JdeP Boolean. Default FALSE
#' @param padding Numeric. Default = 5
#' @return A plot of a pitch
#' @export
create_Pitch <- function(grass_colour = "#F9F9F9", line_colour = "#8F8F8F", background_colour = "#F9F9F9", goal_colour = "#000000", goaltype = "line", middlethird = FALSE, BasicFeatures = FALSE, JdeP = FALSE, arcs = TRUE, padding = 5){

  library(ggplot2)
  ## set theme for blank pitch
  theme_blankPitch = function(size=12) {
    theme(
      #axis.line=element_blank(),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      #axis.ticks.y=element_text(size=size),
      #   axis.ticks=element_blank(),
      axis.ticks.length=unit(0, "lines"),
      #axis.ticks.margin=unit(0, "lines"),
      axis.title.x=element_blank(),
      axis.title.y=element_blank(),
      legend.background=element_rect(fill=background_colour, colour=NA),
      legend.key=element_rect(colour=background_colour,fill=background_colour),
      legend.key.size=unit(1.2, "lines"),
      legend.text=element_text(size=size),
      legend.title=element_text(size=size, face="bold",hjust=0),
      strip.background = element_rect(colour = background_colour, fill = background_colour, size = .5),
      panel.background=element_rect(fill=background_colour,colour=background_colour),
      #       panel.border=element_blank(),
      panel.grid.major=element_blank(),
      panel.grid.minor=element_blank(),
      panel.spacing=element_blank(),
      plot.background=element_blank(),
      plot.margin=unit(c(0, 0, 0, 0), "lines"),
      plot.title=element_text(size=size*1.2),
      strip.text.y=element_text(colour=background_colour,size=size,angle=270),
      strip.text.x=element_text(size=size*1))}

  ymin <- 0 # minimum width
  ymax <- 80 # maximum width
  xmin <- 0 # minimum length
  xmax <- 120 # maximum length

  # Defining features along the length
  boxEdgeDef <- 18
  boxEdgeOff <- 102
  halfwayline <- 60
  sixYardDef <- 6
  sixYardOff <- 114
  penSpotDef <- 12
  penSpotOff <- 108

  # Defining features along the width
  boxEdgeLeft <- 18
  boxEdgeRight <- 62
  sixYardLeft <- 30
  sixYardRight <- 50
  goalPostLeft <- 36
  goalPostRight <- 44
  CentreSpot <- 40

  # other dimensions
  centreCirle_d <- 20

  ## define the circle function
  circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
    r = diameter / 2
    tt <- seq(0,2*pi,length.out = npoints)
    xx <- center[1] + r * cos(tt)
    yy <- center[2] + r * sin(tt)
    return(data.frame(x = xx, y = yy))
  }

  #### create center circle ####
  center_circle <- circleFun(c(halfwayline,CentreSpot),centreCirle_d,npoints = 100)

  ### FIRST STAGE
  ## initiate the plot, set some boundries to the plot
  p <- ggplot() + xlim(c(xmin-padding,xmax+padding)) + ylim(c(ymin-padding,ymax+padding)) +
  # add the theme
  theme_blankPitch()

  ### ADD MIDDLE THIRD SHADING
  if(middlethird == TRUE){
  p <- p + geom_rect(aes(xmin=(xmax/3*1), xmax=(xmax/3*2), ymin=ymin, ymax=ymax), colour = NA, fill = "black", alpha = 0.10)
  }else{}

  if(BasicFeatures == TRUE){
  p <- p +
  # add the base rectangle of the pitch
  geom_rect(aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), fill = NA, colour = line_colour) +
  # add the 18 yard box defensive
  geom_rect(aes(xmin=xmin, xmax=boxEdgeDef, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = grass_colour, colour = line_colour) +
  # add the 18 yard box offensive
  geom_rect(aes(xmin=boxEdgeOff, xmax=xmax, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = grass_colour, colour = line_colour) +
  # add halway line
  geom_segment(aes(x = halfwayline, y = ymin, xend = halfwayline, yend = ymax),colour = line_colour)
  arcs = FALSE
  }else{
        ## initiate the plot, set some boundries to the plot
  p <- p +
  # add the base rectangle of the pitch
  geom_rect(aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), fill = NA, colour = line_colour) +
  # add the 18 yard box defensive
  geom_rect(aes(xmin=xmin, xmax=boxEdgeDef, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = grass_colour, colour = line_colour) +
  # add the 18 yard box offensive
  geom_rect(aes(xmin=boxEdgeOff, xmax=xmax, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = grass_colour, colour = line_colour) +
  # add halway line
  geom_segment(aes(x = halfwayline, y = ymin, xend = halfwayline, yend = ymax),colour = line_colour) +
  # add the six yard box Defensive
  geom_rect(aes(xmin=xmin, xmax=sixYardDef, ymin=sixYardLeft, ymax=sixYardRight), fill = grass_colour, colour = line_colour)  +
  # add the six yard box offensive
  geom_rect(aes(xmin=sixYardOff, xmax=xmax, ymin=sixYardLeft, ymax=sixYardRight), fill = grass_colour, colour = line_colour) +
  # add centre circle
  geom_path(data=center_circle, aes(x=x,y=y), colour = line_colour) +
    # add penalty spot left
  geom_point(aes(x = penSpotDef , y = CentreSpot), colour = line_colour, size = 0.75) +
  # add penalty spot right
  geom_point(aes(x = penSpotOff , y = CentreSpot), colour = line_colour, size = 0.75) +
  # add centre spot
  geom_point(aes(x = halfwayline , y = CentreSpot), colour = line_colour, size = 0.75) }
  
  #### add goals depending on type

  ## LINE TYPE
  if(goaltype == "line"){
  p <- p +
  # add the goal Defensive
  geom_segment(aes(x = xmin, y = goalPostLeft, xend = xmin, yend = goalPostRight),colour = goal_colour, size = 1) +
  # add the goal offensive
  geom_segment(aes(x = xmax, y = goalPostLeft, xend = xmax, yend = goalPostRight),colour = goal_colour, size = 1)

  }else{}

  ## Barca Numbers TYPE
  if(goaltype == "barcanumbers"){
  p <- p +
  # add the goal Defensive
  geom_segment(aes(x = xmin - 0.75, y = goalPostLeft, xend = xmin - 0.75, yend = goalPostRight),colour = line_colour, size = 0.75) +
  # add the goal offensive
  geom_segment(aes(x = xmax + 0.75, y = goalPostLeft, xend = xmax + 0.75, yend = goalPostRight),colour = line_colour, size = 0.75)

  }else{}

  ## BOX TYPE
  if(goaltype == "box"){
  p <- p +
  # add the goal Defensive
  geom_rect(aes(xmin = xmin - 2 , ymin = goalPostLeft, xmax = xmin, ymax = goalPostRight), fill = grass_colour, colour = line_colour) +
  # add the goal offensive
  geom_rect(aes(xmin = xmax, ymin = goalPostLeft, xmax = xmax + 2, ymax = goalPostRight), fill = grass_colour, colour = line_colour)
  }else{}


  ## add J de P
  if(JdeP == TRUE){
  p <- p +
  # vertical tram lines
  geom_segment(aes(x = boxEdgeDef, y = boxEdgeLeft, xend = boxEdgeOff, yend = boxEdgeLeft), colour = "#941C07", alpha = 0.3) +
  geom_segment(aes(x = boxEdgeDef, y = boxEdgeRight, xend = boxEdgeOff, yend = boxEdgeRight), colour = "#941C07", alpha = 0.3) +
  geom_segment(aes(x = boxEdgeDef, y = CentreSpot - 10, xend = boxEdgeOff, yend = CentreSpot - 10), colour = "#941C07", alpha = 0.3) +
  geom_segment(aes(x = boxEdgeDef, y = CentreSpot + 10, xend = boxEdgeOff, yend = CentreSpot + 10), colour = "#941C07", alpha = 0.3) +
  # horizontal tram lines
  geom_segment(aes(x = boxEdgeDef, y = ymin, xend = boxEdgeDef, yend = ymax), colour = "#941C07", alpha = 0.3) +
  geom_segment(aes(x = boxEdgeOff, y = ymin, xend = boxEdgeOff, yend = ymax), colour = "#941C07", alpha = 0.3) +
  geom_segment(aes(x = (xmax/3*1), y = boxEdgeRight, xend = (xmax/3*1), yend = ymax), colour = "#941C07", alpha = 0.3) +
  geom_segment(aes(x = (xmax/3*1), y = boxEdgeLeft, xend = (xmax/3*1), yend = ymin), colour = "#941C07", alpha = 0.3) +
  geom_segment(aes(x = (xmax/3*2), y = boxEdgeRight, xend = (xmax/3*2), yend = ymax), colour = "#941C07", alpha = 0.3) +
  geom_segment(aes(x = (xmax/3*2), y = boxEdgeLeft, xend = (xmax/3*2), yend = ymin), colour = "#941C07", alpha = 0.3)
  # add the 18 yard box defensive
  #geom_rect(aes(xmin=xmin, xmax=boxEdgeDef, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = NA, colour = line_colour) +
  # add the 18 yard box offensive
  #geom_rect(aes(xmin=boxEdgeOff, xmax=xmax, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = NA, colour = line_colour)
  }else{}

  ## add J de P
  if(arcs == TRUE){
  p <- p +
  # vertical tram lines
  annotate("path",
           x = 12 + 10 * cos(seq(-0.3*pi, 0.3*pi, length.out = 30)),
           y = 40 + 10 * sin(seq(-0.3*pi, 0.3*pi, length.out = 30)),
           col = line_colour) +
  annotate("path",
           x = (120-12) - 10 * cos(seq(-0.3*pi, 0.3*pi, length.out = 30)),
           y = 40 + 10 * sin(seq(-0.3*pi, 0.3*pi, length.out = 30)),
           col = line_colour)
  }else{}

  return(p)

}

create_Pitch()
