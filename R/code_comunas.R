#' This function matches municipalities by name to their corresponding INE code
#'
#' @param dfName A dataframe containing a variable with municipalities
#' @param varName A variable containing municipalities, in quotation marks.
#'
#' @return A character vector.
#' @export
#'
code_comunas <- function(dfName, varName){
  dfName <- base::merge(dfName, cod_comunas_df, by.x = varName,
              by.y = "nom_comuna", all.x = TRUE)
  dfName
}
