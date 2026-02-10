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
      x <- frame[ps_out_r[i], ps_out_c[i]+-np_sm:np_sm]
      x[np_sm+1] = NA
      ps_out_e <- spline(x, n=n_sm)
      frame[ps_out_r[i], ps_out_c[i]] <- ceiling(ps_out_e$y[np_sm+1])
    }
  }
  return(frame)
}

cda_v <- Vectorize(cda, vectorize.args = "n_frame")

path_bd <- "../../../data/a-pressure-map-dataset-for-in-bed-posture-classification-1.0.0/experiment-i/"
file_info <- "subject-info-i.csv"

index_pos1 <- 3;
index_pos2 <- 2;
index_pac <- 1;
v_max <- 1000;
nc <- 32
nr <- 64
n_sm <- 7
n_frame <- 3

info_pac <- read.csv(paste(path_bd, file_info, sep=""))

file_ipos1 <- paste(path_bd, "s", info_pac$Subject.Number[index_pac], "/", index_pos1, ".txt", sep="")
file_ipos2 <- paste(path_bd, "s", info_pac$Subject.Number[index_pac], "/", index_pos2, ".txt", sep="")

data1 <- read.table(file_ipos1, header = FALSE, sep = "\t")
data2 <- read.table(file_ipos2, header = FALSE, sep = "\t")

dm1 <- dim(data1)
nf1 <- dm1[1]

dm2 <- dim(data2)
nf2 <- dm2[1]

frame1 <- cda_v(data1, n_frame:nf1, nc, nr, v_max, n_sm)
frame2 <- cda_v(data2, n_frame:nf2, nc, nr, v_max, n_sm)

fct1_1 <- apply(frame1, 2, median)
fct2_1 <- apply(frame1, 2, mean)
fct1_2 <- apply(frame2, 2, median)
fct2_2 <- apply(frame2, 2, mean)

mn_fct1 <- min(c(fct1_1, fct1_2))
mx_fct1 <- max(c(fct1_1, fct1_2))
mn_fct2 <- min(c(fct2_1, fct2_2))
mx_fct2 <- max(c(fct2_1, fct2_2))
plot(fct1_1, fct2_1, type = "p", col = "red", 
     xlim = c(mn_fct1, mx_fct1),
     ylim = c(mn_fct2, mx_fct2),
     pch = 16, lwd = 2)
lines(fct1_2, fct2_2, type = "p", col = "blue",
      pch = 16, lwd = 2)



