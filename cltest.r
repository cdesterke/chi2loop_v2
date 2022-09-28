#' @title cltest

#' loop chi.test by 2*2 matrix on character columns of a dataset
#' @usage results<-cltest(models)
#' @examples data(carmodels)
#' @examples df<-preprocess(carmodels)
#' @examples results<-cltest(df)



cltest<-function(df){
    #install require R packages if necessary and load them
    if(!require(dplyr)){
    install.packages("dplyr")
    library(dplyr)
        }
 if(!require(plyr)){
    install.packages("plyr")
    library(plyr)
        }

		# data.frame verification
		if (!is.data.frame(df)){
		stop('"df" need to be a dataframe with character columns\n',
		'You have provided an object of class: ', class(df)[1])
		}
  	# keep only character columns
  	df%>%select_if(is.character)->df

	# combination of columns 2 by 2
	combos<-combn(ncol(df),2)

	# loop of chi.test
	adply(combos,2,function(x){
	test<-chisq.test(df[,x[1]],df[,x[2]])
	out<-data.frame("Row"=colnames(df)[x[1]],
		"Column"=colnames(df)[x[2]],
		"Chi.Square"=round(test$statistic,3),
		"df"=test$parameter,
		"p.value"=test$p.value
		)
	return(out)
	}
	)->res

	# arrange the output
	res%>%mutate(NLP = -log(p.value,10),)%>%
	mutate(NLP=replace(NLP, NLP == "Inf", 300))%>%
	arrange(desc(NLP))->res
	res%>%mutate(significance=ifelse(p.value<=0.05,"YES","no"))->res
	return(res)
}
