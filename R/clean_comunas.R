# This cleans up accents from municipality names of Chile and gets them in proper format

#' Fix accents and strange characters in municipalities and gets them in proper format.
#' Also converts some municipality names that can be spelled differently to a standard format.
#' Reports the percentage of municipalities that were successfully matched to known names.
#' Reports names of municipalities in your data that are not matched to known names.
#' Suggest close names.
#'
#' @param dfName A dataframe containing a variable with municipalities
#' @param varName A variable containing municipalities, in quotation marks.
#'
#' @return A character vector.
#' @export
#' @examples
#' df <- data.frame(comunas=c("ñuñoa", "Peñalolén", "PEñaflor", "Las condes"))
#' clean_comunas(df, "comunas")
known_names <- c(
  "Coyhaique", "Nueva Imperial", "Victoria", "Tocopilla", "Quintero", "Quilpue", "Calera", "San Javier",
  "Rancagua", "Rio Bueno", "San Bernardo", "Villa Alemana", "Antofagasta", "Cholchol", "Puchuncavi", "Maipu",
  "Puente Alto", "Curico", "Nancagua", "Colina", "Angol", "San Pedro De La Paz", "Valparaiso", "Vina Del Mar",
  "Loncoche", "San Felipe", "Concepcion", "El Bosque", "Copiapo", "Quinta Normal", "Valdivia", "Alto Hospicio",
  "Los Andes", "Lanco", "Osorno", "Iquique", "San Ramon", "Temuco", "Renca", "Melipilla", "Quirihue", "La Florida",
  "Recoleta", "Coquimbo", "Limache", "Quillota", "Machali", "Longavi", "Santiago", "Olmue", "Cerrillos", "Cerro Navia",
  "Lo Espejo", "Los Vilos", "Pozo Almonte", "Pitrufquen", "Rengo", "La Serena", "Petorca", "Nogales", "Gorbea",
  "Requinoa", "Santa Barbara", "Tierra Amarilla", "La Granja", "Corral", "Tiltil", "Codegua", "La Pintana",
  "Isla De Maipo", "Mostazal", "Llanquihue", "Rio Negro", "Combarbala", "Caldera", "Linares", "Puerto Varas",
  "Vallenar", "Canete", "Isla De Pascua", "Puerto Montt", "Las Condes", "Macul", "Quilicura", "Talca", "Ancud",
  "Hualpen", "Los Angeles", "San Fernando", "Colbun", "Chillan", "Coronel", "Estacion Central", "Tome", "Freire",
  "Camarones", "Arauco", "Chillan Viejo", "Cabildo", "Pedro Aguirre Cerda", "Providencia", "Arica", "Huechuraba",
  "Penaflor", "Lo Barnechea", "Penalolen", "Punta Arenas", "Molina", "Calbuco", "La Reina", "Curacavi", "San Carlos",
  "Buin", "Cauquenes", "Lampa", "Pudahuel", "Lo Prado", "Malloa", "San Clemente", "San Rafael", "Ovalle", "Bulnes",
  "Maule", "Calle Larga", "Conchali", "Purranque", "San Jose De Maipo", "Chimbarongo", "Chiguayante", "Tucapel",
  "Chepica", "Talagante", "Graneros", "Talcahuano", "Villarrica", "Lebu", "Yerbas Buenas", "Paine", "Panguipulli",
  "Parral", "San Ignacio", "La Ligua", "Retiro", "San Miguel", "Padre Las Casas", "Lautaro", "Cochrane", "Donihue",
  "Pemuco", "Casablanca", "Coelemu", "Dalcahue", "La Cisterna", "El Carmen", "Aisen", "Pucon", "Tirua", "San Joaquin",
  "Independencia", "Placilla", "Padre Hurtado", "San Vicente", "Cabrero", "La Union", "Rinconada", "Vicuna", "Calama",
  "La Estrella", "Santa Cruz", "Hualaihue", "Porvenir", "San Nicolas", "Concon", "El Monte", "Yumbel", "Vilcun",
  "Hijuelas", "Maullin", "Las Cabras", "Carahue", "Lota", "Olivar", "Los Lagos", "Treguaco", "Castro", "Santa Juana",
  "Calera De Tango", "Putaendo", "Algarrobo", "Quinta De Tilcoco", "Curanilahue", "Coltauco", "Cartagena", "Vichuquen",
  "Laja", "Llayllay", "Paredones", "Panquehue", "Los Alamos", "Penco", "Los Muermos", "Frutillar", "San Antonio",
  "Ninhue", "Lumaco", "Romeral", "Pinto", "Mejillones", "Monte Patria", "Paillaco", "Cunco", "Quellon", "Mafil",
  "Antuco", "Vitacura", "Yungay", "Puqueldon", "La Cruz", "Natales", "Collipulli", "Contulmo", "Futaleufu", "San Esteban",
  "Chile Chico", "San Juan De La Costa", "Los Sauces", "Traiguen", "Curarrehue", "Santa Maria", "Hualqui", "Mulchen",
  "Fresia", "Constitucion", "Nunoa", "Cisnes", "San Pablo", "Diego De Almagro", "Pichidegua", "Renaico", "Huasco",
  "Taltal", "Pichilemu", "Mariquina", "Illapel", "Pirque", "Villa Alegre", "Andacollo", "Nacimiento", "Perquenco",
  "Niquen", "Peumo", "Zapallar", "Galvarino", "Pica", "El Tabo", "Palmilla", "Saavedra", "Rio Claro", "Coihueco",
  "Papudo", "Teodoro Schmidt", "Coinco", "Hualane", "Florida", "Curepto", "Puyehue", "Navidad", "Chonchi", "Freirina",
  "Maria Elena", "Pelarco", "Maria Pinto", "Futrono", "Puren", "El Quisco", "Rauco", "Lago Ranco", "Cobquecura",
  "Palena", "Ercilla", "Negrete", "Teno", "Salamanca", "Alto Del Carmen", "Santo Domingo", "La Higuera", "Peralillo",
  "Puerto Octay", "Quillon", "Marchihue", "Canela", "Chanaral", "Curacautin", "Licanten", "Camina", "San Pedro",
  "Pencahue", "Tolten", "Rio Hurtado", "Litueche", "Quinchao", "Quilleco", "Queilen", "Putre", "Lolol", "San Fabian",
  "Guaitecas", "Paiguano", "Quemchi", "Punitaqui", "Cochamo", "Tortel", "Rio Ibanez", "Melipeuco", "Alhue", "Empedrado",
  "Chanco", "Lonquimay", "Portezuelo", "Cabo De Hornos", "Sagrada Familia", "Ranquil", "Catemu", "Huara", "San Rosendo",
  "Sierra Gorda", "Quilaco", "Pelluhue", "Lago Verde", "San Pedro De Atacama", "Pumanque", "Curaco De Velez", "Alto Biobio",
  "Juan Fernandez", "Laguna Blanca", "O'higgins", "Chaiten", "Torres Del Paine", "Colchane", "Primavera", "General Lagos",
  "San Gregorio", "Ollague", "Timaukel", "Rio Verde", "Antartica"
)


clean_comunas <- function(dfName, varName){
     dfName[[varName]] <- stringi::stri_trans_general(dfName[[varName]], "latin-ascii")
     dfName[[varName]] <- stringi::stri_trans_totitle(dfName[[varName]])
     dfName[[varName]] <- trimws(gsub("\\s+", " ", dfName[[varName]]))
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
     dfName[[varName]][dfName[[varName]] == "Est Central"] <- "Estacion Central"
     dfName[[varName]][dfName[[varName]] == "La Calera"] <- "Calera"
     dfName[[varName]][dfName[[varName]] == "Titil"] <- "Tiltil"
     dfName[[varName]][dfName[[varName]] == "Paihuano"] <- "Paiguano"
     dfName[[varName]][dfName[[varName]] == "Marchigue"] <- "Marchihue"
     dfName[[varName]][dfName[[varName]] == "Trehuaco"] <- "Treguaco"
     dfName[[varName]][dfName[[varName]] == "Ohiggins"] <- "O'higgins"
     dfName[[varName]][dfName[[varName]] == "O´Higgins"] <- "O'higgins"
     dfName[[varName]][dfName[[varName]] == "P Aguirre Cerda"] <- "Pedro Aguirre Cerda"
     dfName[[varName]][dfName[[varName]] == "San Jose Maipo"] <- "San Jose De Maipo"
     dfName[[varName]][dfName[[varName]] == "San Pedro De Melipilla"] <- "San Pedro"
     dfName[[varName]][dfName[[varName]] == "Aysen"] <- "Aisen"
     dfName[[varName]][dfName[[varName]] == "Hijuela"] <- "Hijuelas"



     known_names <- as.data.frame(known_names)
     known_names <- dplyr::rename(known_names, "comunas" = "known_names")

# check number of correctly merged municipalities
     check_merge <- dfName %>%
       dplyr::select({{varName}}) %>%
       dplyr::rename(comunas = {{varName}}) %>%
       dplyr::inner_join(known_names, by = "comunas") %>%
       distinct()

     check_merge <- unique(check_merge$comunas)
     check_merge <- as.data.frame(check_merge)

     check_merge <- check_merge %>%
       dplyr::rename(comunas = check_merge)

     print(paste(length(unique(dfName[[varName]])), "unique municipalities in your data"))
     print(paste(length(unique(check_merge$comunas)), "unique municipalities matched to master list"))
     print(paste(100*length(unique(check_merge$comunas))/length(unique(dfName[[varName]])), "% of your municipalities were matched to valid names"))

     # identify municipalities that were not merged
     check_merge <- dfName %>%
       dplyr::select({{varName}}) %>%
       dplyr::rename(comunas = {{varName}}) %>%
       dplyr::anti_join(known_names, by = "comunas") %>%
       distinct()
     check_merge <- unique(check_merge$comunas)
     check_merge <- as.data.frame(check_merge)
     check_merge <- check_merge %>%
       dplyr::rename(comunas = check_merge)


     if (nrow(check_merge) == 0) {
       print("All municipalities have valid names")
     } else {
       print(paste(nrow(check_merge),"Municipalities were not recognized. They are:", toString(check_merge$comunas)))
     }


     # Set a threshold for similarity
     threshold <- 3

     # Find the closest match using adist from base R
     check_merge <- check_merge[!is.na(check_merge$comunas), , drop = FALSE]

     distances <- utils::adist(check_merge$comunas, known_names$comunas)

     # Find the index of the closest match
     closest_match_index <- which.min(distances)

     # Check if a match was found and print the result
     if (distances[closest_match_index] <= threshold && !all(known_names$comunas == "NA")) {
       closest_match <<- known_names$comunas[closest_match_index]
       print(paste("A close match found: ", closest_match))
     } else {
       print("No close match found.")
     }

     dfName
}


