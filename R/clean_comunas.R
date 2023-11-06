# This cleans up accents from municipality names of Chile and gets them in proper format

#' Fix accents and strange characters in municipalities and gets them in proper format.
#' Also converts some municipality names that can be spelled differently to a standard format.
#'
#' @param dfName A dataframe containing a variable with municipalities
#' @param varName A variable containing municipalities, in quotation marks.
#'
#' @return A character vector.
#' @export
#' @examples
#' df <- data.frame(comunas=c("ñuñoa", "Peñalolén", "PEñaflor", "Las condes"))
#' clean_comunas(df, "comunas")
clean_comunas <- function(dfName, varName){
     dfName[[varName]] <- stringi::stri_trans_general(dfName[[varName]], "latin-ascii")
     dfName[[varName]] <- stringi::stri_trans_totitle(dfName[[varName]])
     dfName[[varName]][dfName[[varName]] == "Bio Bio"] <- "Biobio"
     dfName[[varName]][dfName[[varName]] == "Bio-Bio"] <- "Biobio"
     dfName[[varName]][dfName[[varName]] == "Coihaique"] <- "Coyhaique"
     dfName[[varName]][dfName[[varName]] == "Tal Tal"] <- "Taltal"
     dfName[[varName]][dfName[[varName]] == "Til Til"] <- "Tiltil"
     dfName[[varName]][dfName[[varName]] == "Til-Til"] <- "Tiltil"
     dfName[[varName]][dfName[[varName]] == "Llay Llay"] <- "Llayllay"
     dfName[[varName]][dfName[[varName]] == "Llaillay"] <- "Llayllay"
     dfName[[varName]][dfName[[varName]] == "Llai-llay"] <- "Llayllay"
     dfName[[varName]][dfName[[varName]] == "Llay-Llay"] <- "Llayllay"
     dfName
}

