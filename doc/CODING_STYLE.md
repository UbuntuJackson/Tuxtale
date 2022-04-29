# Tuxtale coding style guidelines
## Indentation
Use tabs for indentation, most text editors has option to use tabs for indentation
## Naming conventions
Use lower camel case for variable and function names, example: `::myFunction <- function()`, `local myVariable = 1`  
Use upper camel case for class names, example `::MyClass <- class`
Class member variables should be prefixed with `m_`, example `m_myVariable`
Global variables should be prefixed with `g_`, example `g_myVariable`
## Brackets
Brackets go to the same line as `if`, `while`, etc. Example:
```
::func <- function() {
	// function code here
}
```
