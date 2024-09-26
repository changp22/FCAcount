library(SCopeLoomR)
library(xlsx)

#Read counts data from loom file
loom_path <- file.path('s_fca_biohub_head_10x.loom')
loom <- open_loom(loom_path, mode="r+")
dgem <- get_dgem(loom)
close_loom(loom)

#filter Lk and CrzR coexpressed cell and process
cell <- dgem[,which(dgem['Lk',]!=0 & dgem['CrzR',]!=0)]
cell <- cell[which(rowSums(cell)>0),]
cell <- scale(cell)
male <- rowMeans(cell[,c(1,6)])
female <- rowMeans(cell[,c(2:5)])
data <- data.frame(male = male, female = female)
write.xlsx(data,'LkCrzR.xlsx')
