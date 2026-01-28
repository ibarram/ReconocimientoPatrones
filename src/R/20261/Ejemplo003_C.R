# --------------------------------------------------------------------
# Lectura de datos y regresión lineal simple (versión original comentada)
# --------------------------------------------------------------------

# Especifica la ruta relativa del archivo de datos (texto plano)
filename = "../../../data/regresion/Datos_1_3.txt"

# Lee la tabla desde el archivo. 
# sep = "" permite que R detecte separadores por espacios o tabuladores automáticamente.
# header = FALSE indica que el archivo NO tiene fila de encabezados.
data <- read.table(filename, sep = "", header = FALSE)

# Extrae la PRIMERA FILA como vector 'x' y la SEGUNDA FILA como vector 'y'.
# as.numeric() asegura que cada elemento sea numérico.
x <- as.numeric(data[1,])
y <- as.numeric(data[2,])

# Calcula el tamaño de la muestra (número de observaciones)
n <- length(x)

# Calcula sumas necesarias para las fórmulas cerradas de mínimos cuadrados:
Sx <- sum(x)        # Suma de x_i
Sy <- sum(y)        # Suma de y_i
Sxy = sum(x*y)      # Suma de productos x_i * y_i
Sx2 <- sum(x^2)     # Suma de cuadrados x_i^2

# Calcula la pendiente (a1) mediante la fórmula:
# a1 = [n*sum(xy) - sum(x)*sum(y)] / [n*sum(x^2) - (sum(x))^2]
a1 <- (n*Sxy-Sx*Sy)/(n*Sx2-Sx^2)

# Calcula el intercepto (a0) mediante:
# a0 = (sum(y) - a1*sum(x)) / n
a0 <- (Sy-a1*Sx)/n

# Calcula los valores ajustados de y: \hat{y} = a1*x + a0
yl <- a1*x+a0

# Calcula la suma de cuadrados del error (SSE): sum( (y_i - \hat{y}_i)^2 )
SSE <- sum((y-yl)^2)

# Calcula n * var(y). OJO: en R, var(y) usa denominador (n-1), por lo que
# n*var(y) NO es exactamente la SST tradicional (ver versión corregida abajo).
s2y <- n*var(y)

# Calcula R^2 como 1 - SSE / s2y (con la salvedad anterior).
R2 <- 1-SSE/s2y

# Imprime el R^2 calculado
print(R2)

# Genera una secuencia de puntos en el rango de x para dibujar la recta de ajuste
x1 <- seq(min(x), max(x), length.out=n)

# Evalúa la recta de regresión en esos puntos
y1 <- a1*x1+a0

# Dibuja el diagrama de dispersión (puntos rojos, 'pch = 19' = círculo sólido)
plot(x, y, col = "red", pch = 19)

# Dibuja la recta de regresión (línea azul, grosor 4)
lines(x1, y1, col = "blue", lwd = 4)

# Agrega retícula al gráfico
grid()