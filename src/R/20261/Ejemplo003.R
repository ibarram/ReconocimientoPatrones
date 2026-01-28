# Archivo de la base de datos
filename = "../../../data/regresion/Datos_1_3.txt"

data <- read.table(filename, sep = "", header = FALSE)

x <- as.numeric(data[1,])
y <- as.numeric(data[2,])

n <- length(x)
Sx <- sum(x)
Sy <- sum(y)
Sxy = sum(x*y)
Sx2 <- sum(x^2)

a1 <- (n*Sxy-Sx*Sy)/(n*Sx2-Sx^2)
a0 <- (Sy-a1*Sx)/n

yl <- a1*x+a0
SSE <- sum((y-yl)^2)
s2y <- n*var(y)
R2 <- 1-SSE/s2y
print(R2)

x1 <- seq(min(x), max(x), length.out=n)
y1 <- a1*x1+a0

plot(x, y, col = "red", pch = 19)
lines(x1, y1, col = "blue", lwd = 4)
grid()
