# select a model for each subchallenge from single xgboost,
# single lightgbm, single catboost, or a stacked model of the three.

source("code/sc1/sc1-fit-load.R")
source("code/include/stacking.R")
source("code/include/model-selection.R")

sc1_params_xgb <- readRDS("model-pm/sc1_params_xgb.rds")
sc1_params_lgb <- readRDS("model-pm/sc1_params_lgb.rds")
sc1_params_cat <- readRDS("model-pm/sc1_params_cat.rds")

set.seed(1001)
idx_tr <- sample(1:377, round(377 * 0.8))
idx_te <- setdiff(1:377, idx_tr)
x_train <- sc1_x_train[idx_tr, ]
y_train <- sc1_y_train[idx_tr]
x_test <- sc1_x_train[idx_te, ]
y_test <- sc1_y_train[idx_te]

model_selection(x_train, y_train, sc1_params_xgb, sc1_params_lgb, sc1_params_cat, 1003)

# from below we decide to use the stacked model - it's consistently top 1 or 2

# 0.8
# xgboost  : 0.9006734
# lightgbm : 0.8973064
# catboost : 0.9309764
# stacked  : 0.9343434

# 0.7
# xgboost  : 0.9112554
# lightgbm : 0.8823954
# catboost : 0.9090909
# stacked  : 0.9372294

# 0.6
# xgboost  : 0.8834586
# lightgbm : 0.8830409
# catboost : 0.9147870
# stacked  : 0.8997494

# 0.5
# xgboost  : 0.8884615
# lightgbm : 0.8940828
# catboost : 0.8961538
# stacked  : 0.8976331
