# subchallenge 1 ---------------------------------------------------------------

# feature selection (this takes ~12 hours on 12 cores)
source("code/sc1/sc1-load.R")
source("code/sc1/sc1-fs.R")

# inspect and choose from the selected features to use in classification
source("code/sc1/sc1-load.R")
source("code/sc1/sc1-fs-agg.R")

# exploratory model fitting
source("code/sc1/sc1-fit-load.R")
source("code/sc1/sc1-fit-explore.R")

# parameter tuning
source("code/sc1/sc1-fit-tune.R")

# model selection
source("code/sc1/sc1-fit-compare.R")

# fit the model, phase 1 summary, make predictions for phase 2
source("code/sc1/sc1-fit-model.R")
source("code/sc1/sc1-predict.R")

# subchallenge 2 ---------------------------------------------------------------

# feature selection (this takes a few hours on 12 cores)
source("code/sc2/sc2-load.R")
source("code/sc2/sc2-fs.R")

# inspect and choose from the selected features to use in classification
source("code/sc2/sc2-load.R")
source("code/sc2/sc2-fs-agg.R")

# exploratory model fitting
source("code/sc2/sc2-fit-load.R")
source("code/sc2/sc2-fit-explore.R")

# parameter tuning
source("code/sc2/sc2-fit-tune.R")

# model selection
source("code/sc2/sc2-fit-compare.R")

# fit the model, phase 1 summary, make predictions for phase 2
source("code/sc2/sc2-fit-model.R")
source("code/sc2/sc2-predict.R")

# subchallenge 3 ---------------------------------------------------------------

# feature selection (this takes a few hours on 12 cores)
source("code/sc3/sc3-load.R")
source("code/sc3/sc3-fs.R")

# inspect and choose from the selected features to use in classification
source("code/sc3/sc3-load.R")
source("code/sc3/sc3-fs-agg.R")

# exploratory model fitting
source("code/sc3/sc3-fit-load.R")
source("code/sc3/sc3-fit-explore.R")

# parameter tuning
source("code/sc3/sc3-fit-tune.R")

# model selection
source("code/sc3/sc3-fit-compare.R")

# fit the model, phase 1 summary, make predictions for phase 2
source("code/sc3/sc3-fit-model.R")
source("code/sc3/sc3-predict.R")
