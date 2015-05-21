cat("Analysis in progress...")

#Preprocessing
header <- read.table("features.txt")
header2 <- header[,2]
data_te_x <- read.table("test/X_test.txt")
data_tr_x <- read.table("train/X_train.txt")
data_x <- rbind(data_te_x, data_tr_x)
data_te_y <- read.table("test/y_test.txt", col.names = "activity_code")
data_tr_y <- read.table("train/y_train.txt", col.names = "activity_code")
data_y <- rbind(data_te_y,data_tr_y)
data_te_su <- read.table("test/subject_test.txt", col.names = "subject_code")
data_tr_su <- read.table("train/subject_train.txt", col.names = "subject_code")
data_su <- rbind(data_te_su,data_tr_su)
colnames(data_x) <- header2
datafull <- cbind(data_su,data_y,data_x)

#Filtering relevant columns
data_means <- grep("mean", names(datafull), value = TRUE)
data_stds <- grep("std", names(datafull), value = TRUE)
data_scope <- data.frame(datafull[,1:2], datafull[,c(data_means,data_stds)])

#Aggregation
stat <- aggregate(data_scope, by=list(data_scope[,1], data_scope[,2]), FUN = mean)
labels <- read.table("activity_labels.txt", col.names = c("activity_code", "activity_name"))
stat2 <- merge(x = stat, y = labels, by = "activity_code")

#Slicing
stat3 <- stat2[,c(4,84,5:83)]

#Creating output
write.table(stat3,"output.txt",quote = FALSE, sep = " " , eol = "\n", row.names = FALSE, col.names = TRUE)
end_message <- paste("Output is ready in ",getwd(),"/output.txt", sep ="")
writeLines("\n")
cat(end_message)
