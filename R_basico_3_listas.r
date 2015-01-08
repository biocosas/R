##' # Introduccion a R: listas
##' [David Montaner](http://www.dmontaner.com "my home page") _(2014-03-31)_  
##'
##' Script que introduce los comandos mas basicos de `R` relacionados con __listas__.
##' 
##' ----------------------------------------------------------------------------

# rm (list = ls ())

##' ## LISTAS

##' Un grupo de objetos de R

unVector <- 1:10
unVector

otroVector <- LETTERS ##LETTERS es una variable definida internamente en R
otroVector

unaMatriz <- cbind (1:10, 10:1)
rownames (unaMatriz) <- LETTERS[1:10]  #con nombres en las filas
colnames (unaMatriz) <- letters[1:2]   #y en las columnas
unaMatriz


##' se pueden agrupar en una estructura de lista

lista0 <- list (unVector, otroVector, unaMatriz)
class (lista0)
length (lista0)


##' Acceso por orden o posicion
lista0[1]
lista0[1:2]
lista0[c(1,3)]  #reordenaciones

##' OBS: el acceso con un un unico corchete conserva la estructura de lista
class (lista0[1])
length (lista0[1])

##' Hay que usar dos corchetes para obtener el objeto guardado sin la 'envoltura' de lista
lista0[[1]]
class (lista0[[1]])
length (lista0[[1]])


##' Los elementos de la lista se pueden nombrar
names (lista0)
names (lista0) <- c("uno", "dos", "tres")
names (lista0)

##' De hecho se puede generar la lista ya con los nombres
lista1 <- list (uno=unVector, dos=otroVector, tres=unaMatriz)
lista1

##' Entonces se puede acceder por nombre a los elemnetos de la lista
lista1["uno"]
lista1[c("uno", "dos")]

##' Con las mismas consideraciones sobre los corchetes
class  (lista1["uno"])  #corchete unico mantiene la estructura de lista
length (lista1["uno"])  #alrededor del objeto

class  (lista1[["uno"]])  #corchete doble extrae el objeto de la posicion
length (lista1[["uno"]])  #en su propio formato


##' Cuando las listas tiene nombres se puede ademas utilizar la notacion __$__
##' que es equivalente a la del doble corchete
lista1$uno
class  (lista1$uno)
length (lista1$uno)


##' ## Loops sobre listas

##' Loops generales
for (i in lista1) {
  print (class (i))
}


##' Loops especificos para listas. Son mas elegante y eficiente en R
sapply (lista1, class)
lapply (lista1, class)

sapply (lista1, length)
lapply (lista1, length)

sapply (lista1, dim)
lapply (lista1, dim)
