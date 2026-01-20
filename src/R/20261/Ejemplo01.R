library(readr)

ruta <- "../../../data/sesgo/caso_sesgo_genero_admision_2000_2024_programa_anio.csv"
stopifnot(file.exists(ruta))

dato <- read_csv(ruta)

