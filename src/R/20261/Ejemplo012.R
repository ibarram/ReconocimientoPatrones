path_bd <- "../../../data/a-pressure-map-dataset-for-in-bed-posture-classification-1.0.0/experiment-i/"
file_info <- "subject-info-i.csv"

index_pos <- 1;
index_pac <- 1;
v_max <- 1000;
nc <- 32
nr <- 64
n_sm <- 7
n_frame <- 3

info_pac <- read.csv(paste(path_bd, file_info, sep=""))

file_ipos <- paste(path_bd, "s", info_pac$Subject.Number[index_pac], "/", index_pos, ".txt", sep="")
data <- read.table(file_ipos, header = FALSE, sep = "\t")
dm <- dim(data)
nf <- dm[1]
data_sel <- as.numeric(data[n_frame, 1:(nc*nr)])
frame <- matrix(data_sel, nrow = nr, ncol = nc, byrow = TRUE)

ps_out <- which(frame>v_max)
ps_out_r <- ps_out%%nr
ps_out_r[ps_out_r==0] <- nr
ps_out_c <- (ps_out-ps_out_r)/nr+1

np_sm <- floor((n_sm-1)/2)
x <- frame[ps_out_r, ps_out_c+-np_sm:np_sm]
x[np_sm+1] = NA
ps_out_e <- spline(x, n=n_sm)
frame[ps_out_r, ps_out_c] <- ceiling(ps_out_e$y[np_sm+1])

image(frame)

