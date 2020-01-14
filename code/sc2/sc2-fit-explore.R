if (FALSE) {
  library("catboost")
  library("pROC")

  sc2_x1_train <- sc2_x_train[, 1:4]
  sc2_x2_train_fs <- sc2_x_train[, -c(1:4)]

  # fit a boosting tree model with pheno + geno combined data
  train_pool <- catboost.load_pool(data = sc2_x_train, label = sc2_y_train)
  model <- catboost.train(
    train_pool, NULL,
    params = list(
      loss_function = "Logloss",
      iterations = 500,
      metric_period = 100,
      depth = 3
    )
  )

  sc2_pred <- catboost.predict(model, train_pool, prediction_type = "Probability")
  pROC::auc(sc2_y_train, sc2_pred)
  plot(pROC::roc(sc2_y_train, sc2_pred))

  # combined features are better than a single type of feature
  # only phenotypic
  train_pool <- catboost.load_pool(data = sc2_x1_train, label = sc2_y_train)
  model <- catboost.train(
    train_pool, NULL,
    params = list(
      loss_function = "Logloss",
      iterations = 500,
      metric_period = 100,
      depth = 3
    )
  )
  sc2_pred <- catboost.predict(model, train_pool, prediction_type = "Probability")
  pROC::auc(sc2_y_train, sc2_pred)
  plot(pROC::roc(sc2_y_train, sc2_pred))

  # only genomic
  train_pool <- catboost.load_pool(data = sc2_x2_train_fs, label = sc2_y_train)
  model <- catboost.train(
    train_pool, NULL,
    params = list(
      loss_function = "Logloss",
      iterations = 500,
      metric_period = 100,
      depth = 3
    )
  )
  sc2_pred <- catboost.predict(model, train_pool, prediction_type = "Probability")
  pROC::auc(sc2_y_train, sc2_pred)
  plot(pROC::roc(sc2_y_train, sc2_pred))

  # boosting trees look better than linear models (on genomic features only)
  df <- data.frame(cbind(sc2_y_train, sc2_x2_train_fs))
  fit <- glm(sc2_y_train ~ ., data = df, family = binomial)
  summary(fit)
  glm_pred <- unname(predict(fit, data.frame(sc2_x2_train_fs), type = "response"))
  pROC::auc(sc2_y_train, glm_pred)
  plot(pROC::roc(sc2_y_train, glm_pred))
}
