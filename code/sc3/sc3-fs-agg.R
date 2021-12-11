library("msaenet")

if (FALSE) {
  # inspect a model
  print(sc3_fs_fit)
  cat(colnames(sc3_x2_train)[msaenet.nzv(sc3_fs_fit)], sep = "\n")
  coef(sc3_fs_fit)[msaenet.nzv(sc3_fs_fit)]
  msaenet.nzv(sc3_fs_fit)
  msaenet.nzv.all(sc3_fs_fit)
  sapply(msaenet.nzv.all(sc3_fs_fit), length)

  # plot estimation path
  plot(sc3_fs_fit, label = TRUE, label.vars = colnames(sc3_x2_train))
  plot(sc3_fs_fit, type = "criterion")

  # plot coef
  plot(sc3_fs_fit, type = "dotplot", label = TRUE, label.vars = colnames(sc3_x2_train))
}

# load models
for (i in 1:100) assign(paste0("sc3_fs_fit_", i), readRDS(paste0("model-fs/sc3/sc3_fs_fit_", i, ".rds")))

# count stable features
lst_feature <- vector("list", 100)
for (i in 1:length(lst_feature)) lst_feature[[i]] <- msaenet.nzv(get(paste0("sc3_fs_fit_", i)))

# feature index and frequency table
sort(table(unlist(lst_feature)), decreasing = TRUE)

# average degree of freedom of the 100 models
round(mean(sapply(lst_feature, length)))

# how the selection frequency and cutoff look like
plot(1:length(unique(unlist(lst_feature))), sort(table(unlist(lst_feature)), decreasing = TRUE), type = "b")
abline(v = 13.5)
abline(h = 50)

# # Plot for slides
# x = seq(20, 100, 20)
# png("sc3.png", width = 2560, height = 1920, res = 300)
# par(mar = c(7, 5, 2, 2), bg = NA)
# plot(
#   1:length(unique(unlist(lst_feature))), sort(table(unlist(lst_feature)), decreasing = TRUE), type = "b",
#   xaxt="n",
#   xlab = "",
#   ylab = "Selection Frequency")
# axis(2, at = x, labels = x, las=2)
# axis(1, at = 1:19, las = 3, labels = colnames(sc3_x2_train)[as.integer(names(sort(table(unlist(lst_feature)), decreasing = TRUE)))])
# abline(v = 13, col = "darkred", lty = 2, lwd = 1.5)
# dev.off()

# select the top 13 features
sc3_fs_idx <- as.integer(names(sort(table(unlist(lst_feature)), decreasing = TRUE)[1:13]))

# names of the selected features
cat(colnames(sc3_x2_train)[sc3_fs_idx], sep = ", ")

# clean up loaded msaenet models
rm(list = paste0("sc3_fs_fit_", 1:100))

# selected features
sc3_x2_train_fs <- sc3_x2_train[, sc3_fs_idx, drop = FALSE]
sc3_x_train <- cbind(sc3_x1_train, sc3_x2_train_fs)

# save the df for training
saveRDS(sc3_x_train, file = "data-fs/sc3_x_train.rds")
