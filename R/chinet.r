#' @title chinet

#' perform network plot with lovain clustering on the results obtained by cltest function
#' @param fold fold for edge weight variations
#' @param cex police size for labels of the vertex
#' @param distance distance between label and vertex
#' @param family family of font for the labels
#' @param layout layout style of the network (layout_as_star, layout_components, layout_in_circle, layout_nicely,layout_on_grid, layout_on_sphere, layout_randomly, layout_with_dh, layout_with_drl, layout_with_fr, layout_with_gem, layout_with_graphopt, layout_with_kk, layout_with_lgl, layout_with_mds)
#' @examples data(carmodels)
#' @examples df<-preprocess(carmodels)
#' @examples results<-cltest(df)
#' @examples chinet(results,fold=0.5,cex=2,distance=3,family="sans",layout=layout_in_circle)


chinet<-function(results,fold=1,cex=2,distance=3,family="sans",layout=layout_as_star){

  #install require R packages if necessary and load them
  if(!require(dplyr)){
    install.packages("dplyr")
    library(dplyr)
  }

    if(!require(igraph)){
    install.packages("igraph")
    library(igraph)
  }

  # prepare results data for network analysis
	results%>%select(Row,Column,NLP,significance)->new	
	colnames(new)<-c("from","to","weight","significance")
	
	## replace significance data by distinct color for edges
	new%>%mutate(significance = replace(significance,significance=="YES","red"))%>%
	mutate(significance = replace(significance,significance=="no","gray30"))->new
		
  # build the network
  g <- graph_from_data_frame(new, directed = FALSE)
  
  # performed louvain communities detection
  lc <- cluster_louvain(g)
  membership(lc)
  communities(lc)
  
  # plot the weighted network
    plot(lc,g,edge.width=new$weight*fold,edge.color=new$significance,vertex.color="black",
	vertex.label.cex=cex,vertex.label.dist=distance,vertex.label.family=family,layout=layout)
}