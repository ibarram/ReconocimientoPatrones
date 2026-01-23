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
vf <- Vectorize(f, vectorize.args = "sl1")

# Admitidos por anio
naat <- vf(datos$anio, lb_a, datos$admitidos_total)
naah <- vf(datos$anio, lb_a, datos$admitidos_hombres)
naam <- vf(datos$anio, lb_a, datos$admitidas_mujeres)
t_ah <- naah/naat
t_am <- naam/naat

# Grafica de aceptación por género desde 2000 a 2024
par(mar = c(6, 4, 4, 2) + 0.1, xpd = NA)
plot(lb_a, t_ah, type = 'o', xlab = "Año", ylab="Tasa", lwd = 2,
     col = "blue", ylim = c(.2, .8), lty = "solid", pch = 19,
     main = "Tasa de aceptación por género")
grid()
lines(lb_a, t_am, type = 'o', lwd = 2,
      col = "red", lty = "solid", pch = 19)
legend("bottomleft", inset = c(0, -1), legend = c("Hombres", "Mujeres"),
       col = c("blue", "red"), lty = 1, pch = 19, lwd = 2, bty = "n")
