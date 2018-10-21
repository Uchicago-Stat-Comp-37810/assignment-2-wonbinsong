source('separate_file.R')

# Creating test data

trueA <- 5 # slope
trueB <- 0   # intercept
trueSd <- 10  # standard deviation of error 
sampleSize <- 31  # sample size

# create independent x-values 
x <- (-(sampleSize-1)/2):((sampleSize-1)/2)  # create a vector x
# create dependent values according to ax + b + N(0,sd)
y <-  trueA * x + trueB + rnorm(n=sampleSize,mean=0,sd=trueSd)  # create a vector y 

plot(x,y, main="Test Data") # plot x,y


# Derive the likelihood function from the model


# Example: plot the likelihood profile of the slope a

slopelikelihoods <- lapply(seq(3, 7, by=.05), slopevalues )  # apply the function slopevalues to the corresponding element of vector x=seq(3, 7, by=.05)
plot (seq(3, 7, by=.05), slopelikelihoods , type="l", xlab = "values of slope parameter a", ylab = "Log likelihood")  # plot x,slopelikelihoods


# Defining the prior

# Prior distribution

# The posterior

# The MCMC

######## Metropolis algorithm ################



startvalue = c(4,0,10)  # startvalue = (4,0,10)
chain = run_metropolis_MCMC(startvalue, 10000)  # compute the value "chain" from the funtion "run_metropolis_MCMC"

burnIn = 5000  # burnIn = 5000
acceptance = 1-mean(duplicated(chain[-(1:burnIn),]))  # compute acceptance rates


### Summary: #######################


summary.plot(chain, burnIn,trueA,trueB,trueSd)


# for comparison:
summary(lm(y~x))  # summaries of the results of model fitting