# Tuxtale coding style guidelines

## Indentation
Use tabs for indentation, most text editors has option to use tabs for indentation

## Naming conventions
Use lower camel case for variable and function names, example: `::myFunction <- function()`, `local myVariable = 1`  
Use upper camel case for class names, example `::MyClass <- class`  
For in-game releated variables, the `gm` prefix should be used in front of the variable's name.  
Global variables should be prefixed with `gv`, example `gvMyVariable`. This mustn't be applied to functions, though.

## Brackets
Brackets go to the same line as `if`, `while`, etc. Example:
```
::func <- function() {
	// function code here
}
```
