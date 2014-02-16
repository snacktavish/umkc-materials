ci <- function(x) {
# Place your implimentation of calculating bootstrapped confidence intervals here.
    
}

args <- commandArgs(T) # read command line args
filename <- args[1] # select the first argument
data <- read.csv(filename)
ci(data$Height) # Specify which column to operate on


