################################################################################
########################### Controlling the exceptions #########################
################################################################################


# List of mostly used exception controlling functions. Quick overview of:
# - stop(),
# - warning(),
# - supressWarnings(),
# - error(),
# - on.exit(),
# - warn(),
# - Try,
# - TryCatch,
# - withCallingHandlers


#######################
### stop() function ###
#######################

test_stop <- function(min, max) {
  if (max < min) stop('max < min')  # break out the function at stop
  
  print('We are good: max > min')
}

test_stop(22, 10)

test_stop(10, 22)


############################
### stopifnot() function ###
############################

input_numbers <- c(23, 22, 25)
stopifnot(is.numeric(input_numbers)) # all TRUE

input_statements <- c(10==10, 22 > 10)
stopifnot(input_statements)          # all TRUE

input_pi <- 3.15                    # this is not a PI number!
stopifnot(all.equal(pi, input_pi))  # Error returned


#################################################
### warning() and supressWarnings() functions ###
#################################################


test_warning <- function(min, max){
  if(max < min) {
    warning("Warning, warning. Max < Min")
  }
  if(max > min) {
    message("Well, max > min")
  }
}

test_warning(10,20)

test_warning(20,10)

suppressWarnings(test_warning(20,10)) # skip the warning message without any return
suppressWarnings(test_warning(10,12))



####################################
### Using Try and TryCatch block ###
####################################

# using list, instead of vector of character
# so output control is better
#input_list <- c(1, 2, 3, 'R Rules', 10, -500, 1.23, 0, 1024)

input_list <- list(1, 2, 3, 'R Rules', 10, -500, 1.23, 0, 1024)

# sample loop
for(inp in input_list) {
  print(paste("Power to the 2 of", inp, "is: ", inp**2))
}

# Try() with silent ON
for(inp in input_list) {
  try(print(paste("Power to the 2 of", inp, "is: ", inp**2)), silent = TRUE) # skip the error to next code
}

# Try() without silent
for(inp in input_list) {
  try(print(paste("Power to the 2 of", inp, "is: ", inp**2))) # skip the error to next code with an error message left 
}



TC_fun = function(x) {
  tryCatch(x**2,
           warning = function(x) 
             {print(paste("negative argument", x)); -inp**x},
           
           error = function(e) 
             {print(paste("non-numeric argument", x)); NaN}
           ) 
}


for(input in input_list) {
  print(paste("TryCatch function of", input, "=", TC_fun(input)))
}



















