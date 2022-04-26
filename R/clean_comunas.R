# This cleans up accents from municipality names of Chile and gets them in proper format


#' Fix accents and weird characters in comunas and gets them in proper format.
#' Also converts some municipality names that can be spelled differently to a standard format.
#'
#' @param dfName A dataframe containing a variable with comunas.
#' @param varName A variable containing municipalities, in quotation marks.
#'
#' @return A character vector.
#' @export
clean_comunas <- function(dfName, varName){
     dfName[[varName]] <- stringi::stri_trans_general(dfName[[varName]], "latin-ascii")
     dfName[[varName]] <- stringi::stri_trans_totitle(dfName[[varName]])
     dfName[[varName]][dfName[[varName]] == "Bio Bio"] <- "Biobio"
     dfName[[varName]][dfName[[varName]] == "Coihaique"] <- "Coyhaique"
     dfName
}
