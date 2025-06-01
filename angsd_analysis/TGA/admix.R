##PCAngsd Admixture Results##

install.packages("devtools")
devtools::install_github("royfrancis/pophelper")

library(pophelper) #v.2.3.1

#K=2

k2_angsd_not <- read.table("/home/tburris/TGA/angsd_admix_notrans.admix.2.Q")
k2_angsd_not <- as.data.frame(k2_angsd_not)

##Add in pop labels

#meta.data <- data.frame(loc=pop_label_angsd)
meta.data <- data.frame(matrix(ncol=1,nrow=111))
colnames(meta.data)="loc"
meta.data$loc <- c(rep("Albatross",47),rep("Contemporary",64))

q2_not <- list(k2_angsd_not)
plotQ(as.qlist(q2_not), imgoutput = "sep", returnplot = TRUE, exportpath=getwd(), dpi=1000,
      clustercol = c("#00BFC4", "#F8766D"),
      showsp = TRUE, spbgcol = "white", splab = "K = 2", splabsize = 6,
      showyaxis = TRUE, showticks = FALSE, indlabsize = 4, ticksize = 0.5,
      grplab = meta.data, linesize = 0.2, pointsize = 2, showgrplab = FALSE, grplabspacer = 0.1)
