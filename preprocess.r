#' @title preprocess

#' this function take input dataframe with possible missing data and preprocessed it:
#' 1- it transforms factor columns as character columns
#' 2- it removes character columns having unique values
#' @usage preprocess(carmodels)
#' @examples data(carmodels)
#' @examples df<-preprocess(carmodels)



preprocess<-function(df){
    #install require R packages if necessary and load them
    if(!require(dplyr)){
    install.packages("dplyr")
    library(dplyr)
        }

    # data.frame verification
    if (!is.data.frame(df)){
    stop('"df" need to be a dataframe with character columns\n',
    'You have provided an object of class: ', class(df)[1])
        }

    #transform factor columns as characters
    df %>% mutate_if(is.factor, as.character) -> df    
    
	#remove columns with only one value
    df %>% na.omit()%>% select(where(~n_distinct(.) > 1))%>%names()->selection
    df %>%select(all_of(selection))->df
    return(df)
}
