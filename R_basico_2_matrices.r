##' # Introduccion a R: matrices
##' [David Montaner](http://www.dmontaner.com "my home page") _(2014-03-31)_  
##'
##' Script que introduce los comandos mas basicos de `R` relacionados con __matrices__.
##' 
##' ----------------------------------------------------------------------------

# rm (list = ls ())


##' Vectores
vector1 <- 1:4
vector2 <- c (12,34,56,34)

vector1
vector2

##' Se pueden agrupar en estructuras mas complejas
cbind (vector1, vector2) #column bind
rbind (vector1, vector2) #row bind

##' Como en otras operaciones o calculos, vectores de diferentes tamaños se _reciclan_
vector3 <- 1:2

cbind (vector3, vector2) #column bind
rbind (vector3, vector2) #row bind

##' Uniendo por filas o columnas generamos una nueva clase de objetos
class (cbind (vector3, vector2)) #es una matriz




##' ## MATRICES

##' La funcion `matrix` define matrices por columnas (por defecto)
M <- matrix (c (vector1, vector2), nrow = 4)
M
class (M)

##' Funciones utiles definidas sobre matrices
nrow (M) #numero de filas
ncol (M) #numero de columnas
dim (M)  #dimension

##' no estan definidas para otros tipos de objetos
dim (vector1)

##' Operaciones con matrices
M
M*2
M+1
M
M+(0:1)  #reciclado del vector 0:1 por columnas
t (M) #traspuesta


##' Las columnas de las matrices se pueden nombrar
colnames (M) <- c ("v1", "v2")
M

##' y los nombres se pueden recuperar
nombres <- colnames (M)
nombres

##' en un vector de caracteres (colnames devuelve un vector)
class (nombres) 
length (nombres)


##' Tambien estan definidos los nombres de las filas aunque por defecto puedan ser un elemento nulo
rownames (M)

rn <- rownames (M) #es un elemento NULL
rn
length (rn)
class (rn)  #tiene clase propia diferente de la de vector


##' Asignamos estos nombres a las filas de la matriz
c ("row1", "row2", "row3", "row4")
paste ("row", 1:4, sep = "") #otra forma de escribir los nombres

rownames (M) <- c ("row1", "row2", "row3", "row4") #ASIGNANDO nombres a las filas
M
rownames (M)


##' cambiando los nombres
colnames (M) <- c ("col1", "col2")
M

##' R comprueba que las dimensiones son correctas y si no lo son devuelve ERRORES
# colnames (M) <- c ("col1", "col2", "col3") 




##' ## Acceso a los elementos de la matriz segun su posicion
M
M[2, 1] #fila 2, columna 1
M[ , 1] #toda la columna 1
M[2,  ] #toda la fila 2

class (M)
class (M[,1])  ##recuperamos los vectores (columna)
class (M[2,])  ##recuperamos los vectores (fila)

dim (M)         #la matriz tiene dimension
dim (M[,1])     #un vector no tiene dimension
dim (M[2,])

length (M[,1])  #un vector tiene longitud
length (M[2,])


##' Podemos acceder a varias filas  o columnas a la vez
M
M[1:2,]
M[c(1,3),]

M[c(1,3),1]
M[c(1,3),2]

##' El resultado es entonces una matriz
class (M[1:2,])


##' Se puede utilizar este tipo de acceso para __reordenar__ filas y columnas de la matriz
M[,c(2,1)] #reordenar la matriz. Cambiamos las columnas.
M[c(1,3), 2] #es un vector con nombres


##' Podemos acceder a los elementos de las matrices tambien para __modificar__ su valor
M
M[1, 1] <- 1000
M
M[,2] <- M[,2] * 10
M



##' ## Seleccion de filas y columnas utilizando sus nombres

##' Hemos visto como podemos acceder a las posiciones (filas y columnas) de las matrices
##' segun su posicion, pero tambien se puede acceder a ellos utilizando sus nombres, 
##' si los tienen

M
M[2,2]
M["row2","col2"]

M[,c("col2", "col1")]
M[c("row3", "row1"),]

M[c("row3", "row1"), 1] #se pueden combinar las dos notaciones

##' El acceso nos permite no solo obtener el valor sino modificarlo

M[c("row3", "row1"), 1]
M[c("row3", "row1"), 1] <- 0
M[c("row3", "row1"), 1]



##' ## Seleccion de filas y columnas utilizando variables booleanas (o indicadores)

##' Se pueden usar vectores _logicos_ para "recortar" las filas y columnas de una matriz
M
M[c(TRUE, FALSE, FALSE, TRUE), c(FALSE, TRUE)]

##' Se pueden combinar las formas de acceso
M[c(1, 4), c(FALSE, TRUE)]

##' Y se pueden usar para reasignar valores
M[c(1, 4), c(FALSE, TRUE)]
M[c(1, 4), c(FALSE, TRUE)] <- M[c(4, 1), c(FALSE, TRUE)]
M[c(1, 4), c(FALSE, TRUE)]



##' ## Tipo o clase de los elementos de una matriz

##' Todos los elementos de una matriz son de la __misma clase__.
##' Esto la diferencia de un data.frame (ver mas adelante)
class (M)
class (M[1,])
class (M[,1])
class (M[1,1])


##' Se pueden añadir filas o columnas a la matriz sobre escribiendo el objeto
M
M <- cbind (M,c (-5,-10)) 
M

class (M)
class (M[1,])
class (M[,1])
class (M[1,1])


##' Se puede replicar todo el objeto para utilizarlo mas adelante
N <- M


##' R cambia automaticamente el tipo de __toda__ la matriz cuando es necesario
M <- cbind (M, "hola") 

M
class (M)
class (M[1,])
class (M[,1])
class (M[1,1])


##' OBS: las nuevas no tienen nombre
M[,3:4]

##' o mejor dicho, lo tienen vacio
colnames (M)  # "" idica un texto de longitud 0


##' pero podemos incluirlos
colnames (M)[3] <- "COL3"
colnames (M)[4] <- "COL4"


##' o mas rapido
colnames (M)[3:4] <- c ("col3", "col4")






##' # LOOPS con matrices

##' Se puede iterar en las dos dimensiones de la matriz 
##' utilizando indices, o nombres

for (i in 1:nrow (M)) {
  for (j in colnames (M)) {
    cat ("\n") #linea nueva
    ##
    print (i)
    print (j)
    dato <- M[i, j]
    print (dato)
  }
}



##' Aunque existen funciones que simplifican la sintaxis (y la velocidad)
N
apply (N, 1, sum)  #suma de las filas
apply (N, 2, min)  #minimo de las columnas

##' ----------------------------------------------------------------------------
