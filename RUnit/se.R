se <- function(x, column="x") { 
    sd(x) / length(x) 

}

test.se <- function() { 
    x <- 1:10
    checkEquals(sd(x) / sqrt(length(x)), se(x))
}

 
