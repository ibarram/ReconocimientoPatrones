cda <- function(data, n_frame, nc, nr, v_max, n_sm)
{
  data_sel <- as.numeric(data[n_frame, 1:(nc*nr)])
  frame <- matrix(data_sel, nrow = nr, ncol = nc, byrow = TRUE)
  
  ps_out <- which(frame>v_max)
  if(length(ps_out)>0)
  {
    ps_out_r <- ps_out%%nr
    ps_out_r[ps_out_r==0] <- nr
    ps_out_c <- (ps_out-ps_out_r)/nr+1
    
    np_sm <- floor((n_sm-1)/2)
    for(i in 1:length(ps_out_c))
    {
      if(ps_out_c[i]<=np_sm)
      {
        x <- frame[ps_out_r[i], ps_out_c[i]+(0:(n_sm-1))]
        x[1] = NA
      }
      else if((ps_out_c[i]+np_sm)>nc)
      {
        x <- frame[ps_out_r[i], ps_out_c[i]+((-n_sm+1):0)]
        x[n_sm] = NA
      }
      else
      {
        x <- frame[ps_out_r[i], ps_out_c[i]+(-np_sm:np_sm)]
        x[np_sm+1] = NA
      }
      ps_out_e <- spline(x, n=n_sm)
      frame[ps_out_r[i], ps_out_c[i]] <- ceiling(ps_out_e$y[np_sm+1])
    }
  }
  return(frame)
}
cda_v <- Vectorize(cda, vectorize.args = "n_frame")

fctE <- function(path_bd, infP_N, index_pos, n_frame, nc, nr, v_max, n_sm)
{
  file_ipos <- paste(path_bd, "s", infP_N, "/", index_pos, ".txt", sep="")
  data <- read.table(file_ipos, header = FALSE, sep = "\t")
  dm <- dim(data)
  nf <- dm[1]
  frame <- cda_v(data, n_frame:nf, nc, nr, v_max, n_sm)
  fct1 <- apply(frame, 2, median)
  fct2 <- apply(frame, 2, mean)
  fct <- data.frame(fct1 = fct1, fct2 = fct2)
  return(fct)
}

path_bd <- "../../../data/a-pressure-map-dataset-for-in-bed-posture-classification-1.0.0/experiment-i/"
file_info <- "subject-info-i.csv"

index_pos1 <- 1;
index_pos2 <- 2;
index_pac <- 1;
v_max <- 1000;
nc <- 32
nr <- 64
n_sm <- 7
n_frame <- 3

info_pac <- read.csv(paste(path_bd, file_info, sep=""))
nP <- length(info_pac$Subject.Number)

mc1 <- fctE(path_bd, info_pac$Subject.Number[1], index_pos1, n_frame, nc, nr, v_max, n_sm)
mc2 <- fctE(path_bd, info_pac$Subject.Number[1], index_pos2, n_frame, nc, nr, v_max, n_sm)
vnf1 <- integer(nP)
vnf2 <- integer(nP)
vnf1[1] <- length(mc1[[1]])
vnf2[1] <- length(mc2[[1]])
for(i in 2:nP)
{
  m1 <- fctE(path_bd, info_pac$Subject.Number[i], index_pos1, n_frame, nc, nr, v_max, n_sm)
  vnf1[i] <- length(m1$fct1)
  m2 <- fctE(path_bd, info_pac$Subject.Number[i], index_pos2, n_frame, nc, nr, v_max, n_sm)
  vnf2[i] <- length(m2$fct1)
  fct1 <- c(mc1$fct1, m1$fct1)
  fct2 <- c(mc1$fct2, m1$fct2)
  mc1 <- data.frame(fct1 = fct1, fct2 = fct2)
  fct1 <- c(mc2$fct1, m2$fct1)
  fct2 <- c(mc2$fct2, m2$fct2)
  mc2 <- data.frame(fct1 = fct1, fct2 = fct2)  
}

fct1_1 <- mc1$fct1
fct2_1 <- mc1$fct2
fct1_2 <- mc2$fct1
fct2_2 <- mc2$fct2

mn_fct1 <- min(c(fct1_1, fct1_2))
mx_fct1 <- max(c(fct1_1, fct1_2))
mn_fct2 <- min(c(fct2_1, fct2_2))
mx_fct2 <- max(c(fct2_1, fct2_2))
plot(fct1_1, fct2_1, type = "p", col = "red", 
     xlim = c(mn_fct1, mx_fct1),
     ylim = c(mn_fct2, mx_fct2),
     pch = 1, lwd = 1, cex = 3)
lines(fct1_2, fct2_2, type = "p", col = "blue",
      pch = 2, lwd = 1, cex = 1)



