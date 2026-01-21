# Archivo de la base de datos
filename = "../../../data/sesgo/caso_sesgo_genero_admision_2000_2024_programa_anio.csv"

# Lectura del archivo CSV
datos <- read.csv(filename)

# Visualizacion de datos
print(head(datos))

# Tamaño de la tabla
sz <- dim(datos)

# Seleccion de los unico de las columna de anio, facultad y escuela
lb_a <- unique(datos$anio)
lb_f <- unique(datos$facultad)
lb_c <- unique(datos$carrera)

# Funcion para la suma en base de una seleccion
f <- function(vct, sl, vtc_d) smn <- sum(vtc_d[vct==sl])
# Vectorizacion de la seleccion
vf <- Vectorize(f, vectorize.args = "sl")

# Admitidos por anio
naat <- vf(datos$anio, lb_a, datos$admitidos_total)
naah <- vf(datos$anio, lb_a, datos$admitidos_hombres)
naam <- vf(datos$anio, lb_a, datos$admitidas_mujeress)
t_ah <- naah/naat
t_am <- naam/naat

plot(lb_a, t_ah, type = 'o', xlab = "Año", ylab="Tasa", lwd = 2,
     col = "blue", ylim = c(.6, .8), lty = "solid", pch = 19,
     main = "Tasa de aceptación de hombre")

