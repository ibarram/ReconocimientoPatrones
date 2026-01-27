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
nlb_a <- length(lb_a)
vlb_a <- 1:nlb_a
lb_f <- unique(datos$facultad)
nlb_f <- length(lb_f)
vlb_f <- 1:nlb_f
lb_c <- unique(datos$carrera)
nlb_c <- length(lb_c)
vlb_c <- 1:nlb_c

# Función para la suma en base de dos caractersiticas seleccionadas
f <- function(vct1, sl1, vct2, sl2, vtc_d) smn <- sum(vtc_d[vct1==sl1&vct2==sl2])
# Vectorización de la selección
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
matplot(ft, type = "o", xlab = "Año", ylab="Tasa", lwd = 4, 
        col = vlb_f, ylim = c(min(ft), max(ft)), lty = 1, pch = vlb_f, 
        main="Tasa de aceptación por género")
palette("R3"); 
grid()
legend("topleft", lb_f, col=vlb_f, pch = vlb_f, 
       text.col = "gray", title= "Facultades")

