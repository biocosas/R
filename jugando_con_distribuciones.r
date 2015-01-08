##' # Juagando con las distribuciones en R 
##' [Francisco García García](http://bioinfo.cipf.es/ "webpage of department") _(2014-10-29)_  
##'
##' 
##' 
##' ----------------------------------------------------------------------------

##' ### 0. Introducción 
##' ### 1. Representación gráfica de una variable cuantitativa 
##' ### 2. Representación gráfica de una variable categórica 
##' ### 3. Representación gráfica de dos variables cuantitativas
##' ### 4. ¿Cómo importamos en R datos desde un fichero txt?
##' ### 5. ¿Cómo guardamos los gráficos generados en R?
##' ### 6. Ejercicios 
##' ----------------------------------------------------------------------------

##'<br />
##'<br />
##'<br />


pnorm
qnorm
rnorm
dnorm

quantile

#calculando la función de probabilidad acumulada
x  <- c(1,5,8,20,23,2,5,1)
Fx <- ecdf 
Fx(10) #a partir de un valor puedo determinar su probabilidad

