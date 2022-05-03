#' This function matches municipalities by name to their corresponding region
#'
#' @param dfName A dataframe containing a variable with municipalities
#' @param varName A variable containing municipalities, in quotation marks.
#'
#' @return A character vector.
#' @export
#' @examples
#' df <- data.frame(comunas=c("ñuñoa", "Peñalolén", "PEñaflor", "Las condes"))
#' clean_df <- clean_comunas(df, "comunas")
#' code_regiones(clean_df, "comunas")
code_regiones <- function(dfName, varName){
  dfName <- base::merge(dfName, cod_comunas_regiones_df[ , c("nom_comuna", "nom_region_2000", "nom_region_2008", "nom_region_2018", "cod_region_2000", "cod_region_2008", "cod_region_2018")], by.x = varName,
                        by.y = "nom_comuna", all.x = TRUE)
  dfName
}

