# select a model for each subchallenge from single xgboost,
# single lightgbm, single catboost, or a stacked model of the three.

source("code/sc3/sc3-fit-load.R")
source("code/include/stacking.R")
source("code/include/model-selection.R")

sc3_params_xgb <- readRDS("model-pm/sc3_params_xgb.rds")
sc3_params_lgb <- readRDS("model-pm/sc3_params_lgb.rds")
sc3_params_cat <- readRDS("model-pm/sc3_params_cat.rds")

set.seed(1001)
idx_tr <- sample(1:166, round(166 * 0.8))
idx_te <- setdiff(1:166, idx_tr)
x_train <- sc3_x_train[idx_tr, ]
y_train <- sc3_y_train[idx_tr]
x_test <- sc3_x_train[idx_te, ]
y_test <- sc3_y_train[idx_te]

model_selection(x_train, y_train, sc3_params_xgb, sc3_params_lgb, sc3_params_cat, 1002)

# from below we decide to use the lightgbm model - it's consistently top 1

# 0.8
# xgboost  : 0.8626374
# lightgbm : 0.9340659
# catboost : 0.7967033
# stacked  : 0.8681319

# 0.7
# xgboost  : 0.8728070
# lightgbm : 0.9057018
# catboost : 0.9013158
# stacked  : 0.8903509

# 0.6
# xgboost  : 0.8355342
# lightgbm : 0.8583433
# catboost : 0.7815126
# stacked  : 0.8523409

# 0.5
# xgboost  : 0.8119048
# lightgbm : 0.8658730
# catboost : 0.7634921
# stacked  : 0.7944444
