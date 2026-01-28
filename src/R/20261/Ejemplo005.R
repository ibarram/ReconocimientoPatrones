# Archivo de la base de datos
filename = "../../../data/regresion/Datos_1_1.txt"

data <- read.table(filename, sep = "", header = FALSE)

x <- as.numeric(data[1,])
y <- as.numeric(data[2,])
p <- 1

r_mS <- function(x, y, p)
{
  n <- length(x)
  xp <- outer(x, 0:p, `^`)
  M <- crossprod(xp)
  v <- t(rep(1,n)%*%(xp[,1:(p+1)]*y))
  solve(M, v)
}
vr_mS <- Vectorize(r_mS, vectorize.args = "p")

a <- r_mS(x, y, p)
va <- vr_mS(x, y, 1:3)

xp <- outer(x, 0:p, `^`)
yl <- xp %*% a

SSE <- sum((y-yl)^2)
s2y <- n*var(y)
R2 <- 1-SSE/s2y
print(R2)

plot(x, y, col = "red", pch = 19)
lines(x, yl, col = "blue", lwd = 4)
grid()

