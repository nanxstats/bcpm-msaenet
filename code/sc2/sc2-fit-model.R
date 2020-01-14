source("code/sc2/sc2-fit-load.R")
source("code/include/stacking.R")

sc2_params_xgb <- readRDS("model-pm/sc2_params_xgb.rds")
sc2_params_lgb <- readRDS("model-pm/sc2_params_lgb.rds")
sc2_params_cat <- readRDS("model-pm/sc2_params_cat.rds")

xtrain <- xgb.DMatrix(as.matrix(convert_num(sc2_x_train)), label = sc2_y_train)
xtrain_nolabel <- xgb.DMatrix(as.matrix(convert_num(sc2_x_train)))

sc2_model <- xgb.train(
  params = list(
    objective = "binary:logistic",
    eval_metric = "auc",
    max_depth = sc2_params_xgb$max_depth,
    eta = sc2_params_xgb$learning_rate
  ),
  data = xtrain,
  nrounds = sc2_params_xgb$nrounds
)

# phase 1 model summary
sc2_p1_pred_prob <- predict(sc2_model, xtrain_nolabel)
sc2_p1_pred_resp <- ifelse(sc2_p1_pred_prob > 0.5, 1L, 0L)
caret::confusionMatrix(table(as.factor(sc2_p1_pred_resp), sc2_y_train))
pROC::auc(sc2_y_train, sc2_p1_pred_prob)

# write the data used for submission
write_tsv(sc2_x_train, "submission/subchallenge_2_data_used_x.tsv")
write_tsv(data.frame("SURVIVAL_STATUS" = sc2_y_train), "submission/subchallenge_2_data_used_y.tsv")
