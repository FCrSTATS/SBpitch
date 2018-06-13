# SBpitch
Statsbomb have released a [free dataset](https://statsbomb.com/resource-centre) to help the public get used to their data product but also provide data to kick start people's journey into football analytics. 

To help people on their journey I have created a R package that creates customisable plots of pitches in ggplot2 that allows event data to be plotted on top. 

## Installation 

Installation is straight forward via the devtools package and the install_github() function. 

```R
devtools::install_github("FCrSTATS/SBpitch")
```

## The Default Plot 

The package offers lots of customisable features but the default plot.

```R
create_Pitch()
```

![](https://github.com/FCrSTATS/SBpitch/blob/master/images/Unknown.png)

## Variables to Customise 

#### Basic Features 
```R
create_Pitch(BasicFeatures = TRUE)
```
![](https://github.com/FCrSTATS/SBpitch/blob/master/images/Unknown-1.png)

#### Middle Third Shading 
```R
create_Pitch(middlethird = TRUE))
```
![](https://github.com/FCrSTATS/SBpitch/blob/master/images/Unknown-2.png)

#### Box Type 
Line Design
```R
create_Pitch(goaltype = "line")
```
![](https://github.com/FCrSTATS/SBpitch/blob/master/images/Unknown.png)
Box Design
```R
create_Pitch(goaltype = "box")
```
![](https://github.com/FCrSTATS/SBpitch/blob/master/images/Unknown-3.png)
Box Design
```R
create_Pitch(goaltype = "barcanumbers")
```
![](https://github.com/FCrSTATS/SBpitch/blob/master/images/Unknown-4.png)

#### Juego de Posicion 
```R
create_Pitch(JdeP = TRUE)
```
![](https://github.com/FCrSTATS/SBpitch/blob/master/images/Unknown-5.png)

## Colour Schemes 

There are 4 colours that you can adjust 

#### Blue Example
```R
create_Pitch(grass_colour = "#224C56", line_colour =  "#B3CED9", background_colour = "#224C56", goal_colour = "#15393D")
```
![](https://github.com/FCrSTATS/SBpitch/blob/master/images/Unknown-6.png)

#### Night Example
```R
create_Pitch(grass_colour = "#202020", line_colour =  "#797876", background_colour = "#202020", goal_colour = "#131313")
```
![](https://github.com/FCrSTATS/SBpitch/blob/master/images/Unknown-7.png)

#### Green Example
```R
create_Pitch(grass_colour = "#538032", line_colour =  "#ffffff", background_colour = "#538032", goal_colour = "#000000")
```
![](https://github.com/FCrSTATS/SBpitch/blob/master/images/Unknown-8.png)




