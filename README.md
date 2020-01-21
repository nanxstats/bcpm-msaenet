# Brain Cancer Predictive Modeling <img src="https://i.imgur.com/pDHoFo7.png" align="right" alt="logo" height="180" width="180" />

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
![License: MIT](https://img.shields.io/github/license/nanxstats/bcpm-msaenet.svg)

Solution for the [precisionFDA Brain Cancer Predictive Modeling and Biomarker Discovery Challenge](https://precision.fda.gov/challenges/8) using [msaenet](https://nanx.me/msaenet/).

This solution features the following modeling flow:

- Feature selection with the multi-step adaptive SCAD-net method ([Xiao and Xu, 2015](https://www.tandfonline.com/doi/full/10.1080/00949655.2015.1016944)).
- A relaxed version of the "Stability Selection" procedure ([Meinshausen and Bühlmann, 2010](https://doi.org/10.1111/j.1467-9868.2010.00740.x)) was used to aggregate the selected features from 100 perturbated models and only keep the consistently selected features.
- Gradient boosting decision tree (GBDT) models for predictive modeling with the selected genomic features and all four clinical features. The tree models include xgboost ([Chen and Guestrin, 2016](https://doi.org/10.1145/2939672.2939785)), lightgbm ([Ke et al., 2017](https://papers.nips.cc/paper/6907-lightgbm-a-highly-efficient-gradient-boosting-decision)), catboost ([Prokhorenkova et al., 2018](https://papers.nips.cc/paper/7898-catboost-unbiased-boosting-with-categorical-features)), and a two-layer stacking tree model ([Wolpert, 1992](https://doi.org/10.1016/S0893-6080(05)80023-1)).
