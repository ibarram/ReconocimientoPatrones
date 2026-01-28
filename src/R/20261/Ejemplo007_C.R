# ================================================================
# Ajuste de modelos polinomiales por MCO (usando ecuaciones normales),
# selección automática del grado del polinomio vía umbral en R^2,
# y detección de posibles atípicos mediante "leave-one-out" por x.
#
# Notas clave:
# - Se estandariza x (media 0, desviación 1) antes de construir la matriz de potencias.
# - Se resuelven las ecuaciones normales: (X'X) a = X'y, donde X es de Vandermonde.
# - Se evalúan varios grados p = 1..15 y se elige el menor p con R^2 por arriba de un umbral.
# - Para detectar atípicos, se calcula el R^2 que tendría el modelo si se elimina cada x_i.
# - Los puntos cuya eliminación incrementa R^2 por encima de un umbral alto se marcan.
# ================================================================

require(stats)  # Carga el paquete 'stats' de base (para qt, var, etc.)

# ------------------------------
# 1) Lectura de datos
# ------------------------------

# Ruta del archivo de datos (ajusta si tu estructura de carpetas cambia)
filename = "../../../data/regresion/Datos_1_2.txt"

# Lee el archivo como tabla sin encabezados.
# 'sep = ""' deja que R detecte espacios/tabuladores automáticamente como separadores.
# OJO: El código asume que los datos de x están en la PRIMERA FILA y los de y en la SEGUNDA FILA.
data <- read.table(filename, sep = "", header = FALSE)

# Extrae x desde la primera FILA, y lo fuerza a ser numérico.
x <- as.numeric(data[1,])

# Índices para ordenar x de menor a mayor (se usarán solo para graficar una línea "suave" ordenada).
ix <- order(x)

# Número de observaciones (tamaño de muestra). Se deriva a partir de x.
n <- length(x)

# Extrae y desde la segunda FILA, y lo fuerza a ser numérico.
y <- as.numeric(data[2,])

# Grado máximo de polinomio a evaluar (probamos p = 1, 2, ..., 15).
p <- 15

# ------------------------------
# 2) Funciones auxiliares
# ------------------------------

# r_mS: "regresión - modelo (ajuste) por mínimos cuadrados" para un grado p dado.
# Calcula los coeficientes 'a' del polinomio (de longitud p+1) resolviendo (X'X) a = X'y.
# - x, y: vectores numéricos de igual longitud.
# - p: grado del polinomio (entero >= 0).
# Devuelve: vector a = (a0, a1, ..., ap) de longitud p+1.
r_mS <- function(x, y, p)
{
  # Comprueba que x e y tengan la misma longitud
  stopifnot(length(x) == length(y))
  
  # Longitud (no se usa directamente, pero deja claro el tamaño)
  n <- length(x)
  
  # Estandariza x (media 0 y sd 1). Esto mejora la condición numérica
  # al construir la matriz de potencias (Vandermonde).
  x <- as.numeric(scale(x))
  
  # Construye la matriz X de Vandermonde: columnas x^0, x^1, ..., x^p.
  # outer(x, 0:p, `^`) genera todas las potencias de x contra los exponentes 0..p.
  X <- outer(x, 0:p, `^`)
  
  # Matriz de ecuaciones normales: M = X'X (producto cruzado)
  M <- crossprod(X)
  
  # Vector del lado derecho: v = X'y
  v <- crossprod(X, y)
  
  # Resuelve (X'X) a = X'y para a. 'solve(M, v)' es más estable que solve(M) %*% v.
  return(solve(M, v))
}

# s_mS: "síntesis (predicción) del modelo" dado un vector de coeficientes 'a' y entradas 'x'.
# - a: vector de coeficientes (a0..ap). Si se vectoriza externamente, puede recibir múltiples 'a'.
# - x: vector de entradas donde se quiere predecir.
# Devuelve: y^ = X a (si 'a' es un vector, devuelve vector; si son múltiples 'a', devuelve matriz).
s_mS <- function(a, x)
{
  # Infiera el grado a partir de la longitud de 'a' (p+1 coeficientes)
  p <- length(a)-1
  
  # Longitud (no estrictamente usada, pero documenta el tamaño)
  n <- length(x)
  
  # Estandariza x con su propia media y sd (consistente con r_mS cuando se usa el mismo x)
  x <- as.numeric(scale(x))
  
  # Matriz de potencias X (Vandermonde) hasta grado p
  X <- outer(x, 0:p, `^`)
  
  # Predicciones: X %*% a
  return(X %*% a)
}

# e_R2: calcula R^2 (coeficiente de determinación) para una o varias columnas de predicción.
# - y: vector respuesta observado.
# - yl: vector o matriz de predicciones (si es matriz, cada columna es un conjunto de predicciones).
# Devuelve: R^2 (escalar si yl es vector; vector si yl es matriz).
# Nota: Usa s2y = n * var(y). En R, var(y) usa denominador (n-1), así que s2y != SST exacta.
# Se usa de forma consistente dentro del script para comparar modelos entre sí.
e_R2 <- function(y, yl)
{
  # Asegura coherencia en dimensiones
  n <- length(y)
  yl <- as.matrix(yl)
  stopifnot(nrow(yl) == n)
  
  # "Varianza total" escalada como n*var(y) (ver nota arriba)
  s2y <- n * var(y)
  
  # SSE por columna: sum( (y - y^)^2 )
  SSE <- colSums((yl - y)^2)
  
  # R^2 = 1 - SSE / "SST" (aquí s2y)
  return(1 - SSE / s2y)
}

# r_mSo: R^2 "out-of-sample por omisión" al eliminar todas las observaciones con x == xi.
# - x, y: datos completos
# - p: grado del polinomio
# - xi: valor de x cuya(s) observación(es) se eliminan (si hay duplicados, se quitan todos)
# Devuelve: R^2 del modelo ajustado SIN esas observaciones.
r_mSo <- function(x, y, p, xi)
{
  # Verifica que xi esté presente en x
  stopifnot(xi %in% x)
  
  # Crea un filtro lógico para quedarse SOLO con aquellos x distintos de xi
  # OJO: si hay valores duplicados de xi, se eliminan todos esos puntos.
  ix <- x != xi
  
  # Subconjunto de datos tras la eliminación
  x <- x[ix]
  y <- y[ix]
  
  # Ajusta el modelo con el subconjunto
  a <- r_mS(x, y, p)
  
  # Predice en el subconjunto
  yl <- s_mS(a, x)
  
  # Calcula R^2 del ajuste obtenido
  R2 <- e_R2(y, yl)
  return(R2)
}

# ------------------------------
# 3) Vectorización de funciones
# ------------------------------

# vr_mS: versión vectorizada de r_mS respecto del argumento "p".
# Permite pasar un vector de grados (p = 1,2,...,P) y obtener una lista de coeficientes.
vr_mS <- Vectorize(r_mS, vectorize.args = "p")

# vs_mS: versión vectorizada de s_mS respecto del argumento "a".
# Permite pasar una colección (lista) de coeficientes y obtener predicciones columna a columna.
vs_mS <- Vectorize(s_mS, vectorize.args = "a")

# vr_mSo: versión vectorizada de r_mSo respecto de "xi".
# Permite calcular, para cada xi en x, el R^2 que resulta al omitir dicho valor.
vr_mSo <- Vectorize(r_mSo, vectorize.args = "xi")

# ------------------------------
# 4) Ajuste para múltiples grados y selección del grado óptimo
# ------------------------------

# Vector de grados candidatos: 1, 2, ..., p (p = 15 arriba)
vp <- 1:p

# Ajusta un modelo para cada grado en vp.
# 'a' será una lista donde cada elemento es el vector de coeficientes para ese grado.
a <- vr_mS(x, y, vp)

# Calcula las predicciones para cada conjunto de coeficientes en el mismo x.
# 'yl' resultará en una matriz n x length(vp), donde cada columna corresponde a un grado.
yl <- vs_mS(a, x)

# Calcula R^2 para cada grado (un valor por columna de 'yl').
R2 <- e_R2(y, yl)

# Umbral inferior para R^2 usando un intervalo con t-Student:
# R2_th = media(R2) - t_{0.975, df=p-1} * sd(R2)/sqrt(p)
# Idea: quedarse con grados cuyo R^2 esté "significativamente" por encima de un piso.
R2_th <- mean(R2) - qt(0.975, df = p-1) * sd(R2)/sqrt(p)

# Selecciona el MENOR grado cuyo R^2 supere el umbral (evita sobreajuste).
p_sel <- min(vp[R2 > R2_th])

# Extrae los coeficientes y las predicciones correspondientes al grado seleccionado.
a_sel <- a[[p_sel]]
y_sel <- yl[, p_sel]

# ------------------------------
# 5) Detección de posibles atípicos ("outliers")
# ------------------------------

# Para cada xi en x, calcula el R^2 del modelo (con p_sel) al ELIMINAR todas las filas con ese xi.
# Si al eliminar un punto x_i el R^2 sube "demasiado", ese punto podría ser atípico/influyente.
R2o <- vr_mSo(x, y, p_sel, x)

# Umbral superior para R^2 por omisión (más estricto):
# R2o_th = media(R2o) + t_{0.995, df=n-1} * sd(R2o)/sqrt(n)
# Aquellos puntos cuya omisión dé R^2 > R2o_th se marcarán como atípicos.
R2o_th <- mean(R2o) + qt(0.995, df = n-1) * sd(R2o)/sqrt(n)

# Índices de las observaciones consideradas atípicas bajo este criterio
id_o <- which(R2o > R2o_th)

# ------------------------------
# 6) Gráfica de resultados
# ------------------------------

# Dibuja los puntos observados (x, y) en rojo.
plot(x, y, col = "red", pch = 19)

# Dibuja la curva (polinomial) ajustada para el grado seleccionado.
# Se traza como línea azul gruesa. Se ordena por x para que la línea no "salte".
lines(x[ix], y_sel[ix], col = "blue", type = "l", lwd = 4)

# Resalta posibles atípicos con círculos azules grandes (sin relleno).
# Estos son los puntos para los cuales al quitarlos, el R^2 aumenta por encima del umbral.
points(x[id_o], y[id_o], col = "blue", pch = 1, cex = 2, lwd = 4)

# Retícula para facilitar lectura visual.
grid()