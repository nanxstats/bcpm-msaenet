if (FALSE) {
  library("catboost")
  library("pROC")

  sc3_x1_train <- sc3_x_train[, 1:4]
  sc3_x2_train_fs <- sc3_x_train[, -c(1:4)]

  # fit a boosting tree model with pheno + geno combined data
  train_pool <- catboost.load_pool(data = sc3_x_train, label = sc3_y_train)
  model <- catboost.train(
    train_pool, NULL,
    params = list(
      loss_function = "Logloss",
      iterations = 500,
      metric_period = 100,
      depth = 3
    )
  )

  sc3_pred <- catboost.predict(model, train_pool, prediction_type = "Probability")
  pROC::auc(sc3_y_train, sc3_pred)
  plot(pROC::roc(sc3_y_train, sc3_pred))

  # combined features are better than a single type of feature
  # only phenotypic
  train_pool <- catboost.load_pool(data = sc3_x1_train, label = sc3_y_train)
  model <- catboost.train(
    train_pool, NULL,
    params = list(
      loss_function = "Logloss",
      iterations = 500,
      metric_period = 100,
      depth = 3
    )
  )
  sc3_pred <- catboost.predict(model, train_pool, prediction_type = "Probability")
  pROC::auc(sc3_y_train, sc3_pred)
  plot(pROC::roc(sc3_y_train, sc3_pred))

  # only genomic
  train_pool <- catboost.load_pool(data = sc3_x2_train_fs, label = sc3_y_train)
  model <- catboost.train(
    train_pool, NULL,
    params = list(
      loss_function = "Logloss",
      iterations = 500,
      metric_period = 100,
      depth = 3
    )
  )
  sc3_pred <- catboost.predict(model, train_pool, prediction_type = "Probability")
  pROC::auc(sc3_y_train, sc3_pred)
  plot(pROC::roc(sc3_y_train, sc3_pred))

  # boosting trees look better than linear models (on genomic features only)
  df <- data.frame(cbind(sc3_y_train, sc3_x2_train_fs))
  fit <- glm(sc3_y_train ~ ., data = df, family = binomial)
  summary(fit)
  glm_pred <- unname(predict(fit, data.frame(sc3_x2_train_fs), type = "response"))
  pROC::auc(sc3_y_train, glm_pred)
  plot(pROC::roc(sc3_y_train, glm_pred))
}
