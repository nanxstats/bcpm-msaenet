library("msaenet")
library("doParallel")
registerDoParallel(detectCores())

# consider sample weight? (class imbalance)
for (i in 1:100) {
  cat("Fitting msasnet model", i, "\n")
  try(sc1_fs_fit <-
    msaenet::msasnet(
      sc1_x2_train, sc1_y_train,
      family = "binomial", init = "ridge",
      gammas = 3.7,
      alphas = seq(0.1, 0.9, 0.1),
      tune = "cv", nfolds = 5,
      nsteps = 20, tune.nsteps = "ebic",
      seed = 2020 + i, parallel = TRUE, verbose = FALSE
    ),
  silent = TRUE
  )

  # to save some space on disk
  sc1_fs_fit$model.list <- NULL
  sc1_fs_fit$adapen.list <- NULL

  if ("msaenet" %in% class(sc1_fs_fit)) {
    saveRDS(sc1_fs_fit, file = paste0("model-fs/sc1/sc1_fs_fit_", i, ".rds"))
  }
}
