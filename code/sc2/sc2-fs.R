library("msaenet")
library("doParallel")
registerDoParallel(detectCores())

for (i in 1:100) {
  cat("Fitting msasnet model", i, "\n")
  try(sc2_fs_fit <-
    msaenet::msasnet(
      sc2_x2_train, sc2_y_train,
      family = "binomial", init = "ridge",
      gammas = c(2.01, 2.5, 3, 3.5, 3.7),
      alphas = seq(0.05, 0.95, 0.05),
      tune = "cv", nfolds = 5,
      nsteps = 20, tune.nsteps = "ebic",
      seed = 2020 + i, parallel = TRUE, verbose = FALSE
    ),
  silent = TRUE
  )
  if ("msaenet" %in% class(sc2_fs_fit)) {
    saveRDS(sc2_fs_fit, file = paste0("model-fs/sc2/sc2_fs_fit_", i, ".rds"))
  }
}
