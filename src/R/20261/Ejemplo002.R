# Archivo de la base de datos
filename = "../../../data/sesgo/caso_sesgo_genero_admision_2000_2024_programa_anio.csv"

# Lectura del archivo CSV
datos <- read.csv(filename)

# Visualizacion de datos
print(head(datos))

# Tamaño de la tabla
sz <- dim(datos)

# Selección de los único de las columnas de anio, facultad y escuela
lb_a <- unique(datos$anio)
lb_f <- unique(datos$facultad)
lb_c <- unique(datos$carrera)

# Función para la suma en base de dos caractersiticas seleccionadas
f <- function(vct1, sl1, vct2, sl2, vtc_d) smn <- sum(vtc_d[vct1==sl1&vct2==sl2])
# Vectorización de la selección
vf <- Vectorize(f, vectorize.args = c("sl1","sl2"))

vf1 <- Vectorize(f, vectorize.args = "sl1")
vf2 <- Vectorize(vf1, vectorize.args = "sl2")

# Admitidos por anio
naat <- vf2(datos$anio, lb_a, datos$facultad, lb_f, datos$admitidos_total)
naah <- vf2(datos$anio, lb_a, datos$facultad, lb_f, datos$admitidos_hombres)
naam <- vf2(datos$anio, lb_a, datos$facultad, lb_f, datos$admitidas_mujeres)
t_ah <- naah/naat
t_am <- naam/naat
ft <- t_am/t_ah

# Grafica de aceptación por género desde 2000 a 2024
par(mar = c(6, 4, 4, 2) + 0.1, xpd = NA)
plot(lb_a, ft[,lb_f[1]], type = 'o', xlab = "Año", ylab="Tasa", lwd = 2,
     col = "blue", ylim = c(.2, 6), lty = "solid", pch = 19,
     main = "Tasa de aceptación por género")
grid()

for(i_f in lb_f)
{
lines(lb_a, ft[,i_f], type = 'o', lwd = 2,
      col = "red", lty = "solid", pch = 19)
}