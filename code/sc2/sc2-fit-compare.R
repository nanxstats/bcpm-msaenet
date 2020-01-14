# select a model for each subchallenge from single xgboost,
# single lightgbm, single catboost, or a stacked model of the three.

source("code/sc2/sc2-fit-load.R")
source("code/include/stacking.R")
source("code/include/model-selection.R")

sc2_params_xgb <- readRDS("model-pm/sc2_params_xgb.rds")
sc2_params_lgb <- readRDS("model-pm/sc2_params_lgb.rds")
sc2_params_cat <- readRDS("model-pm/sc2_params_cat.rds")

set.seed(1001)
idx_tr <- sample(1:174, round(174 * 0.8))
idx_te <- setdiff(1:174, idx_tr)
x_train <- sc2_x_train[idx_tr, ]
y_train <- sc2_y_train[idx_tr]
x_test <- sc2_x_train[idx_te, ]
y_test <- sc2_y_train[idx_te]

model_selection(x_train, y_train, sc2_params_xgb, sc2_params_lgb, sc2_params_cat, 1003)

# from below we decide to use the xgboost model - it's consistently top 1 or 2

# 0.8
# xgboost  : 0.6660
# lightgbm : 0.6280
# catboost : 0.6120
# stacked  : 0.6200

# 0.7
# xgboost  : 0.7477477
# lightgbm : 0.7783784
# catboost : 0.7324324
# stacked  : 0.7360360

# 0.6
# xgboost  : 0.7665
# lightgbm : 0.8100
# catboost : 0.7305
# stacked  : 0.7185

# 0.5
# xgboost  : 0.6749685
# lightgbm : 0.6090794
# catboost : 0.7087011
# stacked  : 0.6721311
