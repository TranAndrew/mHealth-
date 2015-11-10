# Access Excel files
learn1data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Casey\\c event 2.csv", header=TRUE, sep=",")
learn2data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Casey\\c event 3.csv", header=TRUE, sep=",")
learn3data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Casey\\c event 4.csv", header=TRUE, sep=",")
learn4data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Casey\\c event 5.csv", header=TRUE, sep=",")
test1data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Casey\\c event 6.csv", header=TRUE, sep=",")
test2data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Casey\\c event 7.csv", header=TRUE, sep=",")
test3data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Casey\\c event 8.csv", header=TRUE, sep=",")
# Select data columns
a_l1 <- learn1data[,12]; a_l2 <- learn2data[,12]; a_l3 <- learn3data[,12]; a_l4 <- learn4data[,12]
a_t1 <- test1data[,12]; a_t2 <- test2data[,12]; a_t3 <- test3data[,12]
# Set missing first alpha value to zero
a_l1[1] <- 0; a_l2[1] <- 0; a_l3[1] <- 0; a_l4[1] <- 0
a_t1[1] <- 0; a_t2[1] <- 0; a_t3[1] <- 0
# Assign walking and falling index ranges
normstart_l1 <- 54; fallstop_l1 <- 461 
normstart_l2 <- 85; fallstop_l2 <- 432  
normstart_l3 <- 90; fallstop_l3 <- 725  
normstart_l4 <- 113; fallstop_l4 <- 771 
normstart_t1 <- 116; fallstop_t1 <- 798  
normstart_t2 <- 114; fallstop_t2 <- 753 
normstart_t3 <- 137; fallstop_t3 <- 1036 
# Useful segments of data set
learnseg_l1 <- a_l1[normstart_l1:fallstop_l1]; learnseg_l2 <- a_l2[normstart_l2:fallstop_l2]; learnseg_l3 <- a_l3[normstart_l3:fallstop_l3]; learnseg_l4 <- a_l4[normstart_l4:fallstop_l4]
testseg_t1 <- a_t1[normstart_t1:fallstop_t1]; testseg_t2 <- a_t2[normstart_t2:fallstop_t2]; testseg_t3 <- a_t3[normstart_t3:fallstop_t3]

# Moving average 
install.packages("zoo")
library(zoo)
# Learning moving average
learn1mvavg <- rollapply(data = learnseg_l1, width = 10, FUN = 'mean')
learn2mvavg <- rollapply(data = learnseg_l2, width = 10, FUN = 'mean')
learn3mvavg <- rollapply(data = learnseg_l3, width = 10, FUN = 'mean')
learn4mvavg <- rollapply(data = learnseg_l4, width = 10, FUN = 'mean')
lenavg_l1 <- length(learn1mvavg); lenavg_l2 <- length(learn2mvavg); lenavg_l3 <- length(learn3mvavg); lenavg_l4 <- length(learn4mvavg)
# Value frequencies in subsets
red1data <- 0; red2data <- 0; red3data <- 0; red4data <- 0
red1data[1] <- learn1mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_l1) if(abs(learn1mvavg[i] - learn1mvavg[i-1]) > 0) { red1data[j] <- learn1mvavg[i]; j = j + 1 }
red2data[1] <- learn2mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_l2) if(abs(learn2mvavg[i] - learn2mvavg[i-1]) > 0) { red2data[j] <- learn2mvavg[i]; j = j + 1 }
red3data[1] <- learn3mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_l3) if(abs(learn3mvavg[i] - learn3mvavg[i-1]) > 0) { red3data[j] <- learn3mvavg[i]; j = j + 1 }
red4data[1] <- learn4mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_l4) if(abs(learn4mvavg[i] - learn4mvavg[i-1]) > 0) { red4data[j] <- learn4mvavg[i]; j = j + 1 }
# Plot concatenated subsets cleaned of duplicated entries
lenredu_l1 <- length(red1data); lenredu_l2 <- length(red2data); lenredu_l3 <- length(red3data); lenredu_l4 <- length(red4data)
plotx_l1 <- cbind(1:lenredu_l1); plot(plotx_l1, red1data, 'b', main = "Reduced Moving Average Data, Learning Data Set 1", xlab = "", ylab = "Magnitude of Change")
plotx_l2 <- cbind(1:lenredu_l2); plot(plotx_l2, red2data, 'b', main = "Reduced Moving Average Data, Learning Data Set 2", xlab = "", ylab = "Magnitude of Change")
plotx_l3 <- cbind(1:lenredu_l3); plot(plotx_l3, red3data, 'b', main = "Reduced Moving Average Data, Learning Data Set 3", xlab = "", ylab = "Magnitude of Change")
plotx_l4 <- cbind(1:lenredu_l4); plot(plotx_l4, red4data, 'b', main = "Reduced Moving Average Data, Learning Data Set 4", xlab = "", ylab = "Magnitude of Change")
# Methodology for Testing
max_l1 <- red1data[15]; maxtest_l1 <- 0; maxdiff_l1 <- red1data[15] - red1data[21]; maxdifftest_l1 <- 0; fall_l1 <- 0; for (i in 1:lenredu_l1) fall_l1[i] <- 0
for (i in 2:(lenredu_l1 - 5)) { if(red1data[i] > max_l1) {
  maxtest_l1 <- red1data[i];
  maxdifftest_l1 <- red1data[i] - red1data[i + 6]
  if(maxdifftest_l1 > maxdiff_l1) {
    fall_l1[i] <- 1;
    max_l1 <- maxtest_l1;
    maxdiff_l1 <- maxdifftest_l1
  }
}
}
fall_l1
max_l2 <- red2data[15]; maxtest_l2 <- 0; maxdiff_l2 <- red2data[15] - red2data[21]; maxdifftest_l2 <- 0; fall_l2 <- 0; for (i in 1:lenredu_l2) fall_l2[i] <- 0
for (i in 2:(lenredu_l2 - 5)) {
  if(red2data[i] > max_l2) {
    maxtest_l2 <- red2data[i];
    maxdifftest_l2 <- red2data[i] - red2data[i + 6]
    if(maxdifftest_l2 > maxdiff_l2) {
      fall_l2[i] <- 1;
      max_l2 <- maxtest_l2;
      maxdiff_l2 <- maxdifftest_l2
    }
  }
}
fall_l2
max_l3 <- red3data[15]; maxtest_l3 <- 0; maxdiff_l3 <- red3data[15] - red3data[21]; maxdifftest_l3 <- 0; fall_l3 <- 0; for (i in 1:lenredu_l3) fall_l3[i] <- 0
for (i in 2:(lenredu_l3 - 5)) {
  if(red3data[i] > max_l3) {
    maxtest_l3 <- red3data[i];
    maxdifftest_l3 <- red3data[i] - red3data[i + 6]
    if(maxdifftest_l3 > maxdiff_l3) {
      fall_l3[i] <- 1;
      max_l3 <- maxtest_l3;
      maxdiff_l3 <- maxdifftest_l3
    }
  }
}
fall_l3
max_l4 <- red4data[15]; maxtest_l4 <- 0; maxdiff_l4 <- red4data[15] - red4data[21]; maxdifftest_l4 <- 0; fall_l4 <- 0; for (i in 1:lenredu_l4) fall_l4[i] <- 0
for (i in 2:(lenredu_l4 - 5)) {
  if(red4data[i] > max_l4) {
    maxtest_l4 <- red4data[i];
    maxdifftest_l4 <- red4data[i] - red4data[i + 6]
    if(maxdifftest_l4 > maxdiff_l4) {
      fall_l4[i] <- 1;
      max_l4 <- maxtest_l4;
      maxdiff_l4 <- maxdifftest_l4
    }
  }
}
fall_l4

# Testing
# Local Maximum Followed by Large Difference at Index Maximum + 6
# # Moving Average
test1mvavg <- rollapply(data = testseg_t1, width = 10, FUN = 'mean')
test2mvavg <- rollapply(data = testseg_t2, width = 10, FUN = 'mean')
test3mvavg <- rollapply(data = testseg_t3, width = 10, FUN = 'mean')
lenavg_t1 <- length(test1mvavg); lenavg_t2 <- length(test2mvavg); lenavg_t3 <- length(test3mvavg)
# # Remove Duplicates
red1test <- 0; red2test <- 0; red3test <- 0
red1test[1] <- test1mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_t1) if(abs(test1mvavg[i] - test1mvavg[i-1]) > 0) { red1test[j] <- test1mvavg[i]; j = j + 1 }
red2test[1] <- test2mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_t2) if(abs(test2mvavg[i] - test2mvavg[i-1]) > 0) { red2test[j] <- test2mvavg[i]; j = j + 1 }
red3test[1] <- test3mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_t3) if(abs(test3mvavg[i] - test3mvavg[i-1]) > 0) { red3test[j] <- test3mvavg[i]; j = j + 1 }
lenredu_t1 <- length(red1test); lenredu_t2 <- length(red2test); lenredu_t3 <- length(red3test)
# # Testing Methodology
max_t1 <- red1test[15]; maxtest_t1 <- 0; maxdiff_t1 <- red1test[15] - red1test[21]; maxdifftest_t1 <- 0; fall_t1<- 0; for (i in 1:lenredu_t1) fall_t1[i] <- 0
for (i in 2:(lenredu_t1 - 10)) {
  if(red1test[i] > max_t1) {
    maxtest_t1 <- red1test[i];
    maxdifftest_t1 <- red1test[i] - red1test[i + 6]
    if(maxdifftest_t1 > maxdiff_t1) {
      fall_t1[i] <- 1;
      max_t1 <- maxtest_t1;
      maxdiff_t1 <- maxdifftest_t1
    }
  }
}
fall_t1
max_t2 <- red2test[15]; maxtest_t2 <- 0; maxdiff_t2 <- red2test[15] - red2test[21]; maxdifftest_t2 <- 0; fall_t2 <- 0; for (i in 1:lenredu_t2) fall_t2[i] <- 0
for (i in 2:(lenredu_t2 - 10)) {
  if(red2test[i] > max_t2) {
    maxtest_t2 <- red2test[i];
    maxdifftest_t2 <- red2test[i] - red2test[i + 6]
    if(maxdifftest_t2 > maxdiff_t2) {
      fall_t2[i] <- 1;
      max_t2 <- maxtest_t2;
      maxdiff_t2 <- maxdifftest_t2
    }
  }
}
fall_t2
max_t3 <- red3test[15]; maxtest_t3 <- 0; maxdiff_t3 <- red3test[15] - red3test[21]; maxdifftest_t3 <- 0; fall_t3 <- 0; for (i in 1:lenredu_t3) fall_t3[i] <- 0
for (i in 2:(lenredu_t3 - 10)) {
  if(red3test[i] > max_t3) {
    maxtest_t3 <- red3test[i];
    maxdifftest_t3 <- red3test[i] - red3test[i + 6]
    if(maxdifftest_t3 > maxdiff_t3) {
      fall_t3[i] <- 1;
      max_t3 <- maxtest_t3;
      maxdiff_t3 <- maxdifftest_t3
    }
  }
}
fall_t3
# # Plots
plotx_t1 <- cbind(1:lenredu_t1); plot(plotx_t1, red1test, 'b', main = "Reduced Moving Average Data, First-Round Testing Data Set 1", xlab = "", ylab = "Magnitude of Change")
plotx_t2 <- cbind(1:lenredu_t2); plot(plotx_t2, red2test, 'b', main = "Reduced Moving Average Data, First-Round Testing Data Set 2", xlab = "", ylab = "Magnitude of Change")
plotx_t3 <- cbind(1:lenredu_t3); plot(plotx_t3, red3test, 'b', main = "Reduced Moving Average Data, First-Round Testing Data Set 3", xlab = "", ylab = "Magnitude of Change")

# Second-Round Testing; Different Subject
# Access Excel files
learn1data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Jahangir\\person 1 event 2.csv", header=TRUE, sep=",")
learn2data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Jahangir\\s1e3.csv", header=TRUE, sep=",")
learn3data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Jahangir\\s1e4.csv", header=TRUE, sep=",")
learn4data <- read.table("C:\\Users\\Kate\\Documents\\MU\\MSCS 6050\\data\\Jahangir\\s1e5.csv", header=TRUE, sep=",")
# Select data columns
# ERROR BELOW WITH FOURTH PART
a_l1 <- learn1data[,15]; a_l2 <- learn2data[,12]; a_l3 <- learn3data[,12]; a_l4 <- learn4data[,12]
# Set missing first alpha value to zero
a_l1[1] <- 0; a_l2[1] <- 0; a_l3[1] <- 0; a_l4[1] <- 0
# Assign walking and falling index ranges
normstart_l1 <- 271; fallstop_l1 <- 683
normstart_l2 <- 164; fallstop_l2 <- 463  
normstart_l3 <- 63; fallstop_l3 <- 331
normstart_l4 <- 47; fallstop_l4 <- 337 
# Useful segments of data set
learnseg_l1 <- a_l1[normstart_l1:fallstop_l1]; learnseg_l2 <- a_l2[normstart_l2:fallstop_l2]; learnseg_l3 <- a_l3[normstart_l3:fallstop_l3]; learnseg_l4 <- a_l4[normstart_l4:fallstop_l4]

# Moving average 
install.packages("zoo")
library(zoo)
# Learning moving average
learn1mvavg <- rollapply(data = learnseg_l1, width = 10, FUN = 'mean')
learn2mvavg <- rollapply(data = learnseg_l2, width = 10, FUN = 'mean')
learn3mvavg <- rollapply(data = learnseg_l3, width = 10, FUN = 'mean')
learn4mvavg <- rollapply(data = learnseg_l4, width = 10, FUN = 'mean')
lenavg_l1 <- length(learn1mvavg); lenavg_l2 <- length(learn2mvavg); lenavg_l3 <- length(learn3mvavg); lenavg_l4 <- length(learn4mvavg)
# # Value frequencies in subsets
red1data <- 0; red2data <- 0; red3data <- 0; red4data <- 0
red1data[1] <- learn1mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_l1) if(abs(learn1mvavg[i] - learn1mvavg[i-1]) > 0) { red1data[j] <- learn1mvavg[i]; j = j + 1 }
red2data[1] <- learn2mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_l2) if(abs(learn2mvavg[i] - learn2mvavg[i-1]) > 0) { red2data[j] <- learn2mvavg[i]; j = j + 1 }
red3data[1] <- learn3mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_l3) if(abs(learn3mvavg[i] - learn3mvavg[i-1]) > 0) { red3data[j] <- learn3mvavg[i]; j = j + 1 }
red4data[1] <- learn4mvavg[1]; j <- 1; k <- 2; for (i in 2: lenavg_l4) if(abs(learn4mvavg[i] - learn4mvavg[i-1]) > 0) { red4data[j] <- learn4mvavg[i]; j = j + 1 }
# # Plot concatenated subsets cleaned of duplicated entries
lenredu_l1 <- length(red1data); lenredu_l2 <- length(red2data); lenredu_l3 <- length(red3data); lenredu_l4 <- length(red4data)
plotx_l1 <- cbind(1:lenredu_l1); plot(plotx_l1, red1data, 'b', main = "Reduced Moving Average Data, Second-Round Testing Data Set 1", xlab = "", ylab = "Magnitude of Change")
plotx_l2 <- cbind(1:lenredu_l2); plot(plotx_l2, red2data, 'b', main = "Reduced Moving Average Data, Second-Round Testing Data Set 2", xlab = "", ylab = "Magnitude of Change")
plotx_l3 <- cbind(1:lenredu_l3); plot(plotx_l3, red3data, 'b', main = "Reduced Moving Average Data, Second-Round Testing Data Set 3", xlab = "", ylab = "Magnitude of Change")
plotx_l4 <- cbind(1:lenredu_l4); plot(plotx_l4, red4data, 'b', main = "Reduced Moving Average Data, Second-Round Testing Data Set 4", xlab = "", ylab = "Magnitude of Change")
# # Methodology for Testing
max_l1 <- red1data[15]; maxtest_l1 <- 0; maxdiff_l1 <- red1data[15] - red1data[21]; maxdifftest_l1 <- 0; fall_l1 <- 0; for (i in 1:lenredu_l1) fall_l1[i] <- 0
for (i in 2:(lenredu_l1 - 5)) { if(red1data[i] > max_l1) {
  maxtest_l1 <- red1data[i];
  maxdifftest_l1 <- red1data[i] - red1data[i + 6]
  if(maxdifftest_l1 > maxdiff_l1) {
    fall_l1[i] <- 1;
    max_l1 <- maxtest_l1;
    maxdiff_l1 <- maxdifftest_l1
  }
}
}
fall_l1
max_l2 <- red2data[15]; maxtest_l2 <- 0; maxdiff_l2 <- red2data[15] - red2data[21]; maxdifftest_l2 <- 0; fall_l2 <- 0; for (i in 1:lenredu_l2) fall_l2[i] <- 0
for (i in 2:(lenredu_l2 - 5)) {
  if(red2data[i] > max_l2) {
    maxtest_l2 <- red2data[i];
    maxdifftest_l2 <- red2data[i] - red2data[i + 6]
    if(maxdifftest_l2 > maxdiff_l2) {
      fall_l2[i] <- 1;
      max_l2 <- maxtest_l2;
      maxdiff_l2 <- maxdifftest_l2
    }
  }
}
fall_l2
max_l3 <- red3data[15]; maxtest_l3 <- 0; maxdiff_l3 <- red3data[15] - red3data[21]; maxdifftest_l3 <- 0; fall_l3 <- 0; for (i in 1:lenredu_l3) fall_l3[i] <- 0
for (i in 2:(lenredu_l3 - 5)) {
  if(red3data[i] > max_l3) {
    maxtest_l3 <- red3data[i];
    maxdifftest_l3 <- red3data[i] - red3data[i + 6]
    if(maxdifftest_l3 > maxdiff_l3) {
      fall_l3[i] <- 1;
      max_l3 <- maxtest_l3;
      maxdiff_l3 <- maxdifftest_l3
    }
  }
}
fall_l3
max_l4 <- red4data[15]; maxtest_l4 <- 0; maxdiff_l4 <- red4data[15] - red4data[21]; maxdifftest_l4 <- 0; fall_l4 <- 0; for (i in 1:lenredu_l4) fall_l4[i] <- 0
for (i in 2:(lenredu_l4 - 5)) {
  if(red4data[i] > max_l4) {
    maxtest_l4 <- red4data[i];
    maxdifftest_l4 <- red4data[i] - red4data[i + 6]
    if(maxdifftest_l4 > maxdiff_l4) {
      fall_l4[i] <- 1;
      max_l4 <- maxtest_l4;
      maxdiff_l4 <- maxdifftest_l4
    }
  }
}
fall_l4

