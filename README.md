# chi2loop_v2
R package chi2loop in version 2.0.0


### package installation
```r
library(devtools)
install_github("cdesterke/chi2loop_v2")
```


chi2loop R-package was designed to perform 2 by 2 loops of chi.square tests between categrorial variables defined as character columns in imported dataset. 
Importantly, chi2loop package could work on dataframes containing missing data.

- For the first step, in this version, a preprocess function was added to preprocess the input data.frame. This function transforms factor columns as charater columns and remove columns of characters with unique values.

- The second step with the "cltest" function is to perform iterative chi.square tests between columns (2 by 2) to obtain a dataframe of results. Numeric columns will not been traited in this loop process.

- In a third step it is possible to design a NLPplot with the function "nlpplot" on the results data.frame. This nlpplot represents colored bubble with proportional size relative to the negative log10 transformation of the chi.square test p-values. According significance of the tests the symbol will be different in the matrix: bubbles for significant tests and crosses for non significant ones.

- In a fourth step, still on chi.square test results, with the "chinet" function, it is possible to draw a clustering graph based on Louvain algorithm showing the clusters of variable dependencies. The size of the edges between the nodes is proportional to the p-values obtained between the variables so reflecting their association. In this version chinet function draw edges in different colors according the significance of the tests : red for significant ones and gray for non significant ones.

### Script used in the package

> data(carmodels)

> df<-preprocess(carmodels)

> results<-cltest(df)

> nlpplot(results,titleplot="NLP plot on carmodels preprocessed",txt=14)

- titleplot parameter: for definition of the main title 

- txt: size of the labels in the plot 

abbreviations: NLP : negative log10 of chi.test p-values

![nlpplot](https://github.com/cdesterke/chi2loop_v2/blob/main/nlpplot.jpeg)

### network with louvain communities detection with nicely layout
> chinet(results,fold=0.5,cex=2,distance=3,family="sans",layout=layout_nicely)

- fold parameter: increase difference of size of the weighted edges

- cex parameter: change size of the vertex (nodes) label

- distance parameter: change the distance between the vertex and its label

- family parameter: change the font family of the vertex label

- layout parameter: change the design of the network and have several options such as: (layout_as_star, layout_components, layout_in_circle, layout_nicely,layout_on_grid,
layout_on_sphere, layout_randomly, layout_with_dh, layout_with_drl, layout_with_fr, layout_with_gem,
layout_with_graphopt, layout_with_kk, layout_with_lgl, layout_with_mds)

![chinet2a](https://github.com/cdesterke/chi2loop_v2/blob/main/chinetnicely.jpeg)

### chinet with circle layout:

> chinet(results,fold=0.5,cex=2,distance=3,family="sans",layout=layout_in_circle)

![chinet2b](https://github.com/cdesterke/chi2loop_v2/blob/main/chinetincircle.jpeg)

### chinet with star layout and different changes in the parameters:

> chinet(res,fold=0.5,cex=3,distance=5,family="mono",layout=layout_as_star)

![chinet2c](https://github.com/cdesterke/chi2loop_v2/blob/main/chinetstar.jpeg)

### remarks

- cltest works on columns which are defined as.character so this function do not works on columns defined as.factor. During import of your dataset in R specify the parameter "stringsAsFactors=FALSE" 

- after cltest to perform graphics you can filter rows with significant results such as

> library(dplyr)

> results%>%filter(p.value<=0.05)->results

### references

> chisq.test R function in stats library: https://stat.ethz.ch/R-manual/R-devel/library/stats/html/chisq.test.html; accessed on 2022, september 19th 

> igraph network design: https://igraph.org/; accessed on 2022, september 19th 

> Louvain algorithm for detection of communities : Vincent D Blondel et al J. Stat. Mech. (2008) P10008
