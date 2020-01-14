if (FALSE) {
  library("catboost")
  library("pROC")

  sc1_x1_train <- sc1_x_train[, 1:4]
  sc1_x2_train_fs <- sc1_x_train[, -c(1:4)]

  # fit a boosting tree model with pheno + geno combined data
  train_pool <- catboost.load_pool(data = sc1_x_train, label = sc1_y_train)
  model <- catboost.train(
    train_pool, NULL,
    params = list(
      loss_function = "Logloss",
      iterations = 500,
      metric_period = 100,
      depth = 3
    )
  )

  sc1_pred <- catboost.predict(model, train_pool, prediction_type = "Probability")
  pROC::auc(sc1_y_train, sc1_pred)
  plot(pROC::roc(sc1_y_train, sc1_pred))

  # combined features are better than a single type of feature
  # only phenotypic
  train_pool <- catboost.load_pool(data = sc1_x1_train, label = sc1_y_train)
  model <- catboost.train(
    train_pool, NULL,
    params = list(
      loss_function = "Logloss",
      iterations = 500,
      metric_period = 100,
      depth = 3
    )
  )
  sc1_pred <- catboost.predict(model, train_pool, prediction_type = "Probability")
  pROC::auc(sc1_y_train, sc1_pred)
  plot(pROC::roc(sc1_y_train, sc1_pred))

  # only genomic
  train_pool <- catboost.load_pool(data = sc1_x2_train_fs, label = sc1_y_train)
  model <- catboost.train(
    train_pool, NULL,
    params = list(
      loss_function = "Logloss",
      iterations = 500,
      metric_period = 100,
      depth = 3
    )
  )
  sc1_pred <- catboost.predict(model, train_pool, prediction_type = "Probability")
  pROC::auc(sc1_y_train, sc1_pred)
  plot(pROC::roc(sc1_y_train, sc1_pred))

  # boosting trees look better than linear models (on genomic features only)
  df <- data.frame(cbind(sc1_y_train, sc1_x2_train_fs))
  fit <- glm(sc1_y_train ~ ., data = df, family = binomial)
  summary(fit)
  glm_pred <- unname(predict(fit, data.frame(sc1_x2_train_fs), type = "response"))
  pROC::auc(sc1_y_train, glm_pred)
  plot(pROC::roc(sc1_y_train, glm_pred))
}
