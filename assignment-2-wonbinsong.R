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


slopelikelihoods <- lapply(seq(3, 7, by=.05), slopevalues )  # apply the function slopevalues to the corresponding element of vector x=seq(3, 7, by=.05)
plot (seq(3, 7, by=.05), slopelikelihoods , type="l", xlab = "values of slope parameter a", ylab = "Log likelihood")  # plot x,slopelikelihoods


startvalue = c(4,0,10)  # startvalue = (4,0,10)
chain = run_metropolis_MCMC(startvalue, 10000)  # compute the value "chain" from the funtion "run_metropolis_MCMC"


burnIn = 5000  # burnIn = 5000
acceptance = 1-mean(duplicated(chain[-(1:burnIn),]))  # compute acceptance rates

# plot the results
summary.plot(chain, burnIn,trueA,trueB,trueSd)


# for comparison:
summary(lm(y~x))  # summaries of the results of model fitting



# new function

compare_outcomes <- function(iterations){  # create a function with "iterations" as an input
  a.matrix <- array(dim=c(10,2))  # creat an empty matrix
  colnames(a.matrix) <- c('mean', 'std')  # column names
  for(i in 1:10){  # for loop starting from 1 to 10
    startvalue <- c(runif(1,0,10), rnorm(1,0,5), runif(1,0,30))  # set a starting value
    chain <-  run_metropolis_MCMC(startvalue, iterations)  # use the function "run_metropolis_MCMC" to compute tha value of chain
    a.matrix[i,1] <- mean(chain[,1])  # compute the mean of the values in the chain for a
    a.matrix[i,2] <- sd(chain[,1])  # compute the standard deviation of the values in the chain for a
  }
  return(a.matrix)  # return the computed mean and standard deviation
}

# Test the function for 1,000, 10,000, and 100,000 iterations
compare_outcomes(1000)
compare_outcomes(10000)
compare_outcomes(100000)