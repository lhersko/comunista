#' This function matches municipalities by name to their corresponding INE code
#'
#' @param dfName A dataframe containing a variable with municipalities
#' @param varName A variable containing municipalities, in quotation marks.
#'
#' @return A character vector.
#' @export
#' @examples
#' #' df <- data.frame(comunas=c("ñuñoa", "Peñalolén", "PEñaflor", "Las condes"))
#' clean_df <- clean_comunas(df, "comunas")
#' code_comunas(clean_df, "comunas")
code_comunas <- function(dfName, varName){
  dfName <- base::merge(dfName, cod_comunas_df, by.x = varName,
              by.y = "nom_comuna", all.x = TRUE)
  dfName
}
