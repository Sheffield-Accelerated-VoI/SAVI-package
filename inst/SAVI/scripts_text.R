# Copyright (c) 2014, 2015 SAVI authors (see AUTHORS.txt).
# Licensed under the BSD 3-clause license (see LICENSE.txt)

# this file holds functions that help generate reactive text
# widespread changes made 17/11/14 so that options could be chosen for the CE plane

# # 1) Incremental costs
# incCost <- function (costs){
#   incCost <- (costs[, 2] - costs[, 1])
#   incCost
# }
#
# # 2) Incremental effects
# incBen <- function (effects){
#   incBen <- (effects[, 2] - effects[, 1])
#   incBen
# }

# 3) Mean Incremental Cost/Benefit
incValue <- function(samples, int, comp, cache) {
  int <- which(cache$namesDecisions%in%int)
  comp <- which(cache$namesDecisions%in%comp)
  if(int==comp) return(NULL)
  data <- samples[, int] - samples[, comp]
  incValue <- format(mean(data), digits = 2, nsmall = 2)
  incValue
}

# 4) More/Less Detector (for costs and benefits)

moreLess <- function(samples, int, comp, cache) {
  int <- which(cache$namesDecisions%in%int)
  comp <- which(cache$namesDecisions%in%comp)
  if(int==comp) return(NULL)
  data <- samples[, int] - samples[, comp]
  moreLess <- if (mean(data) > 0) {"more"}
                else {"less"}
  moreLess
}

# 5) Confidence intervals for cost effectiveness (value = e.g. 0.025 for 2.5th CI, 0.975 for 97.5th CI)
confIntCE <- function(samples, int, comp, value, cache) {
  int <- which(cache$namesDecisions%in%int)
  comp <- which(cache$namesDecisions%in%comp)
  if(int==comp) return(NULL)
  data <- samples[, int] - samples[, comp]
  confIntCE <- format(quantile(data, value), digits = 2,  nsmall = 2)
  confIntCE
}

# 6) Probability cost saving
pCostsaving <- function(samples, int, comp, cache) {
  int <- which(cache$namesDecisions%in%int)
  comp <- which(cache$namesDecisions%in%comp)
  if(int==comp) return(NULL)
  data <- samples[, int] - samples[, comp]
  pCostsaving <- format(length(which(data < 0)) / length(data), digits = 2, nsmall = 3)
  pCostsaving
}

# 7) Probability provides more benefits
pMoreben <- function(samples, int, comp, cache) {
  int <- which(cache$namesDecisions%in%int)
  comp <- which(cache$namesDecisions%in%comp)
  if(int==comp) return(NULL)
  data <- samples[, int] - samples[, comp]
  pMoreben <- format(length(which(data > 0)) / length(data), digits = 2, nsmall = 3)
  pMoreben
}

# 8) ICER
iCER <- function(costs, bens, int, comp, cache) {
  int <- which(cache$namesDecisions%in%int)
  comp <- which(cache$namesDecisions%in%comp)
  if(int==comp) return(NULL)
  iCER <- format(mean(costs[, int] - costs[, comp]) / mean(bens[, int] - bens[, comp]), digits = 2, nsmall = 2)
  iCER
}

# 9) Above/Below Detector (for ICER)
aboveBelow <- function(costs, bens, int, comp, lambda, cache) {
  int <- which(cache$namesDecisions%in%int)
  comp <- which(cache$namesDecisions%in%comp)
  if(int==comp) return(NULL)
  aboveBelow <- if ((mean(costs[, int] - costs[, comp]) / mean(bens[, int] - bens[, comp])) > lambda) {"above"}
  else {"below"}
  aboveBelow
}

# 10) Would/Would not Detector (for ICER)
wouldNot <- function(costs, bens, int, comp, lambda, cache) {
  int <- which(cache$namesDecisions%in%int)
  comp <- which(cache$namesDecisions%in%comp)
  if(int==comp) return(NULL)
  wouldNot <- if ((mean(costs[, int] - costs[, comp]) / mean(bens[, int] - bens[, comp])) > lambda) {"would not"}
  else {"would"}
  wouldNot
}


# 11) Probability cost-effective for int versus comp at lambda WTP
pCE <- function(int, comp, lambda, cache) {
  int <- which(cache$namesDecisions%in%int)
  comp <- which(cache$namesDecisions%in%comp)
  if(int==comp) return(NULL)
  costs <- cache$costs
  effects <- cache$effects
  sum((effects[, int] * lambda - costs[, int]) > (effects[, comp] * lambda - costs[, comp])) / NROW(costs)
}


# 12) Which has highest probability cost effective?
bestCE <- function(costs, bens, lambda, nInt) {
  nb <- bens * lambda - costs
  best <- which.max(as.vector(tabulate(apply(nb, 1, which.max), nbins = nInt)))
  colnames(costs)[best]
}

# 12a) What is the porbability for the option which has highest probability of being cost effective?
highestCE <- function(costs, bens, lambda) {
  nb <- bens * lambda - costs
  max(table(apply(nb, 1, which.max))) / NROW(costs)
}

# 13) Net Benefit costs
netBencosts <- function(costs, bens, lambda, nInt) {
  nb <- bens * lambda - costs
  maxnb <- max(colMeans(nb))
  format(maxnb, digits = 2, nsmall = 2)
}

# 14) Net Benefit effects
netBeneffects <- function(costs, bens, lambda, nInt) {
  nb <- bens - costs / lambda
  maxnb <- max(colMeans(nb))
  format(maxnb, digits = 2, nsmall = 2)
}

# 15) Which best strategy?
bestnetBen <- function(costs, bens, lambda, nInt) {
  nb <- bens * lambda - costs
  colnames(costs)[which.max(colMeans(nb))]
}
