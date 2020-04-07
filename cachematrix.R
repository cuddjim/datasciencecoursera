## THe function does exactly the same as the example supplied in the assignment, only difference is the functions used in
# the computation and the fact that you have to a pass a matrix to the makeCacheMatrix function, not a numeric vector

## The first function, makeCacheMatrix creates a special "matrix", which is really a list containing a function to

# 1. set the value of the matrix
# 2. get the value of the matrix
# 3. set the value of the inverse
# 4. get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setsolve <- function(solve) inv <<- solve
  getsolve <- function() inv
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
}


# The following function calculates the inverse of the special "matrix"
# created with the above function. However, it first checks to see
# if the inverse has already been calculated. If so, it gets the inverse
# from the cache and skips the computation. Otherwise, it calculates
# the inverse of the data and sets the value of the inverse in the cache
# via the setsolve function.

cacheSolve <- function(x, ...) {
       
  inv <- x$getsolve()
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setsolve(inv)
  inv
}


test = matrix(c(4,3,3,2),2)
cache_test <- makeCacheMatrix(test)
cacheSolve(cache_test) #inverse returned from computation (not cached yet)
cacheSolve(cache_test) #inverse returted from cache if reran without changing matrix