## RspatialPkg

The package provides geospatial related R functions for the plotting (based on ggplot2) of both raster and simple feature related data. The repository contains a number of demonstrations of the functions. 

To install *RspatialPkg* enter the following command lines from an R console:

```R
install.packages("devtools")
```

```R
devtools::install_github("deandevl/RspatialPkg")
```

In your R application file include the package:

```R
library(RspatialPkg)
```

The following table list the functions from the package:

| Function        | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| dot_density_sf  | The function returns a simple feature object (class sf) from the submitted simple feature object that has `POINT` geometries (called a "dot") representing each observation (or counts of observations) of the feature object. |
| get_geom_raster | The function is wrapper around ggplot2::geom_raster that plots from a data.frame with columns for x and y coordinates along with an associated numeric attribute. The function accepts a data frame with columns for numeric x/y values and an attribute that will be mapped as a color or fill aesthetic. Function provides additional ggplot2 text labeling and axis scaling. |
| get_geom_sf     | The function is a wrapper around ggplot2::geom_sf that plots simple feature objects. It accepts objects of class sf for visualizing their points, lines, and polygon geometries. The function provides parameters for controlling color, size, variable aesthetic mapping, and text labeling. |
| matrix_to_sf    | Function converts a matrix of long/lat coordinate(s) into a simple features object (sf::sf). The submitted matrix of longitude (column 1) and latitude (column 2) coordinate(s) is converted into an sf object. |
| sfc_to_matrix   | Function converts point geometries from an sf::sfc object to matrix form |

