library("msaenet")

if (FALSE) {
  # inspect a model
  print(sc2_fs_fit)
  cat(colnames(sc2_x2_train)[msaenet.nzv(sc2_fs_fit)], sep = "\n")
  coef(sc2_fs_fit)[msaenet.nzv(sc2_fs_fit)]
  msaenet.nzv(sc2_fs_fit)
  msaenet.nzv.all(sc2_fs_fit)
  sapply(msaenet.nzv.all(sc2_fs_fit), length)

  # plot estimation path
  plot(sc2_fs_fit, label = TRUE, label.vars = colnames(sc2_x2_train))
  plot(sc2_fs_fit, type = "criterion")

  # plot coef
  plot(sc2_fs_fit, type = "dotplot", label = TRUE, label.vars = colnames(sc2_x2_train))
}

# load models
for (i in 1:100) assign(paste0("sc2_fs_fit_", i), readRDS(paste0("model-fs/sc2/sc2_fs_fit_", i, ".rds")))

# count stable features
lst_feature <- vector("list", 100)
for (i in 1:length(lst_feature)) lst_feature[[i]] <- msaenet.nzv(get(paste0("sc2_fs_fit_", i)))

# feature index and frequency table
sort(table(unlist(lst_feature)), decreasing = TRUE)

# average degree of freedom of the 100 models
round(mean(sapply(lst_feature, length)))

# how the selection frequency and cutoff look like
plot(1:length(unique(unlist(lst_feature))), sort(table(unlist(lst_feature)), decreasing = TRUE), type = "b")
abline(v = 6.5)
abline(h = 50)

# select the top 6 features
sc2_fs_idx <- as.integer(names(sort(table(unlist(lst_feature)), decreasing = TRUE)[1:6]))

# names of the selected features
cat(colnames(sc2_x2_train)[sc2_fs_idx], sep = ", ")

# clean up loaded msaenet models
rm(list = paste0("sc2_fs_fit_", 1:100))

# selected features
sc2_x2_train_fs <- sc2_x2_train[, sc2_fs_idx, drop = FALSE]
sc2_x_train <- cbind(sc2_x1_train, sc2_x2_train_fs)

# save the df for training
saveRDS(sc2_x_train, file = "data-fs/sc2_x_train.rds")
