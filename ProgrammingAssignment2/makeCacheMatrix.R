## 'makeCacheMatrix' function creates a special matrix object, and then
## 'cacheSolve' function calculates the inverse of the matrix.
## If the matrix inverse has already been calculated, it will instead
## find it in the cache and return it, and is not calculated again.

makeCacheMatrix <- function(x = matrix()) {
    inv_x <- NULL
    set <- function(y) {
        x <<- y
        inv_x <<- NULL
    }
    get <- function() x
    setinverse<- function(inverse) inv_x <<-inverse
    getinverse <- function() inv_x
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}
