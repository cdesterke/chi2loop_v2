#' @title nlpplot

#' perform matrix plot of the results obtained by cltest function
#' @param titleplot "string" for the title of the plot
#' @param txt size of the label for the title
#' @examples data(carmodels)
#' @examples df<-preprocess(carmodels)
#' @examples results<-cltest(df)
#' @examples nlpplot(results,titleplot="NLP plot on carmodels",txt=12)


nlpplot<-function(results,titleplot="NLP plot",txt=12){
  #install require R packages if necessary and load them
  if(!require(ggplot2)){
    install.packages("ggplot2")
    library(ggplot2)
  }

  p=ggplot(results,aes(x=Row,y=Column,color=NLP,size=NLP))+
	geom_point(aes(shape=significance))+theme_minimal()+
    	labs(x="covariates in rows", y="covariates in columns",
         title=titleplot)+
	scale_shape_manual(values=c(3, 16))+
    	theme(axis.text.x = element_text(angle = 90))+
	theme(text = element_text(size = txt))+
	scale_colour_gradientn(colors=rainbow(8))+
	theme(legend.position="right")
	return(p)
}