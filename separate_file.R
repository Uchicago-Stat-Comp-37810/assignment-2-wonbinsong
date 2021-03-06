likelihood <- function(param){  # creating a function with a parameter "para"
  a = param[1]  # "a" takes the value of 1st element in vector "para"
  b = param[2]  # "b" takes the value of 2nd element in vector "para"
  sd = param[3]  # "sd" takes the value of 3rd element in vector "para"
  
  pred = a*x + b  # calculate the value of pred
  singlelikelihoods = dnorm(y, mean = pred, sd = sd, log = T)  # calculate the normal density
  sumll = sum(singlelikelihoods)  # sum of "singlelikelihoods"
  return(sumll)    # the function returns the value sumll
}


slopevalues <- function(x){return(likelihood(c(x, trueB, trueSd)))} # create a function

prior <- function(param){  # creating a function with a parameter "param"
  a = param[1]  # "a" takes the value of 1st element in vector "para"
  b = param[2]  # "b" takes the value of 2nd element in vector "para"
  sd = param[3]  # "sd" takes the value of 3rd element in vector "para"
  aprior = dunif(a, min=0, max=10, log = T)  # aprior=uniform density
  bprior = dnorm(b, sd = 5, log = T)  # bprior=normal density
  sdprior = dunif(sd, min=0, max=30, log = T) # sdprior=uniform density
  return(aprior+bprior+sdprior)  # the function returns the value "aprior"+"bprior"+"sdprior"
}

posterior <- function(param){  # creating a function with a parameter "param"
  return (likelihood(param) + prior(param))  # the function returns the value likelihood(param)+prior(param)
}

proposalfunction <- function(param){  # creating a function with a parameter "param"
  return(rnorm(3,mean = param, sd= c(0.1,0.5,0.3)))  # the function returns the normal random numbers
}


run_metropolis_MCMC <- function(startvalue, iterations){  # creating a function with parameters "startvalue" and "iterations"
  chain = array(dim = c(iterations+1,3))  # create an array
  chain[1,] = startvalue  # first row of "chain" = "startvalue"
  for (i in 1:iterations){  # for loop starting from 1 to "iterations"
    proposal = proposalfunction(chain[i,])  # compute the "proposal" from the function "proposalfunction"
    probab = exp(posterior(proposal) - posterior(chain[i,])) # compute the "probab" from the function "posterior" 
    if (runif(1) < probab){  # if the uniform random number is less than "probab", then (i+1)th row of "chain" = "proposal"
      chain[i+1,] = proposal
    }else{  # if the unifrom random number is greater than or equal to proposal, then the (i+1)th row of "chain" = ith row of "chain"
      chain[i+1,] = chain[i,]
    }
  }
  return(chain)  # the function returns the value "chain"
}


summary.plot <- function(chain, burnIn,trueA,trueB,trueSd){
  par(mfrow = c(2,3))  # create a matrix of 2x3 plots
  hist(chain[-(1:burnIn),1],nclass=30, , main="Posterior of a", xlab="True value = red line" )  # create a histogram of Posterior of a
  abline(v = mean(chain[-(1:burnIn),1]))  # add a vertical line indicating mean of a
  abline(v = trueA, col="red" )  # add a vertical line indicating trueA
  hist(chain[-(1:burnIn),2],nclass=30, main="Posterior of b", xlab="True value = red line")  # create a histogram of Posterior of b
  abline(v = mean(chain[-(1:burnIn),2]))  # add a vertical line indicating mean of b
  abline(v = trueB, col="red" )  # add a vertical line indicating trueB
  hist(chain[-(1:burnIn),3],nclass=30, main="Posterior of sd", xlab="True value = red line")  # create a histogram of Posterior of sd
  abline(v = mean(chain[-(1:burnIn),3]) )  # add a vertical line
  abline(v = trueSd, col="red" )  # add a vertical line indicating trueSd
  plot(chain[-(1:burnIn),1], type = "l", xlab="True value = red line" , main = "Chain values of a", )  # plot chain values of a 
  abline(h = trueA, col="red" )  # add a horizontal line indicating trueA
  plot(chain[-(1:burnIn),2], type = "l", xlab="True value = red line" , main = "Chain values of b", )  # plot chain values of b
  abline(h = trueB, col="red" )  # add a horizontal line indicating trueB
  plot(chain[-(1:burnIn),3], type = "l", xlab="True value = red line" , main = "Chain values of sd", )  # plot chain values of sd
  abline(h = trueSd, col="red" )  # add a horizontal line indicating trueSd
}
