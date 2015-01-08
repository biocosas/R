##' # Introduccion a R: vectores
##' [David Montaner](http://www.dmontaner.com "my home page") _(2014-03-31)_  
##'
##' Script que introduce los comandos mas basicos de `R` relacionados con __vectores__.
##' 
##' ----------------------------------------------------------------------------

# rm (list = ls ())





##' ## Preliminares

#esto es una linea comentada

##' Para salir de R escribir: q ()

##' R se puede utilizar como calculadora
2+2
2*3

##' La asignacion de valores se hace utilizando: `<-` 
variableA <- 3
variableA
variableA * 2

##' Todas las funciones en R van siempre seguidas de parentesis
##' que envuelven los argumentos de la funcion
sqrt (3)
sqrt (variableA)
SQRT (variableA)   #R es _case sensitive_ no funciona en mayusculas
variableA
VARIABLEA
sqrt ("variableA") #cada funcion esta definida para un tipo o clase de argumentos





##' ## Clases de variables; la FUNCION class
class (1)
class ("adjgfagkjg")
class ("1")
class (TRUE); class (FALSE)
class (factor (1))

##' Las funciones tambien son 'objetos' accesibles en la sesion
class (ls)
ls () # llamada a la funcion: con parentesis, aunque no tenga argumentos
ls    # llamada a la funcion sin parentesis: muestra el objeto, es decir, el codigo de la función.





##' ## VECTORES

##' Varios elementos se pueden concatenar en un vector utilizando el operador o funcion: `c ()`
c (1,2,3)
c ("a","b","c")
c ("a","b","c", 1,2,3) #OBS: todos los elementos del vector son del mismo tipo


##' Todos los elementos del vector tienen la misma clase
class (c (1,2,3))
class (c ("a","b","c"))
class (c ("a","b","c", 1,2,3)) #Si no R cambia el tipo de alguno de ellos.


##' La longitud es una caracteristica de los vectores que se podemos
##' conocer utilizando la funcion length
length (c (1,2,3))
length (c ("a","b","c"))
length (c ("a","b","c", 1,2,3))


##' Todas las variables en R son vectores de longitud 1
is.vector (1)
class (1)
length (1)

is.vector ("adjgfagkjg")
class ("adjgfagkjg")
length ("adjgfagkjg")

is.vector (TRUE)
class (TRUE)
length (TRUE)


##' Son lo mismo:
1
c (1)

1 == c (1)
identical (1, c (1))


##' Asignacion de valores a variables
a <- 4
a
b <- c (1,2,3)
b
c <- c (5,4,3,2,1)
c
d <- c ("a","b","c", "d", "e", "f")
d

length (a)
length (b)
length (c)
length (d)


##' Se puede reasignar valores
a
a <- 7
a
a <- c ("a","b","c",)
a


##' Los vectores pueden ser de varias CLASES
class (1:10)               #"integer"
class (c (1.0, 2.0, 3.0))  #"numeric"
class (c ("A", "B", "C"))  #"character"
class (c (TRUE, FALSE))    #"logical"


##' Se puede acceder a los elementos del vector por su poscion
d
d[1]
d[3]


##' Varias posiciones del vector se indican, a su vez, como un vector numerico
d[c (1,2,3)]
d[c (3,2,1)]  #sigue siendo un vector en otro orden


##' quizas sea mas claro asi presentado
v <- c (3,2,1)
class (v)  ##es un vector
d[v]       ##que 'indexa' a otro vector

class (d[c (1,2,3)])  #es un vector nuevo
length (d[c (1,2,3)]) #con longitud diferente


##' Se puede acceder a todo el vector menos algunas posiciones 
d
d[-1]

d[c (-1,-3,-5)]
d[ - c (1,3,5)] # el operador - se aplica a todos los elementos del vector
d[c (1, 3, -5)] # no se pueden mezclar las dos formas de acceso


##' El operador ':' indica una secuencia de enteros
10:15
c (10, 11, 12 ,13 ,14, 15)

identical (10:15, c(10, 11, 12 ,13 ,14, 15))

class (10:15)
class (c(10, 11, 12 ,13 ,14, 15))

##' Al ser un vector, se puede usar para indexar las posiciones de otros
d[3:1]


##' OBS: los vectores tambien se pueden nombrar
v <- 101:103
v
names (v)
names (v) <- c ("n1", "n2", "n3")
v
names (v)

##' de hecho se pueden nombrar al definirlos
c (N1 = "primer valor", N2 = "segundo valor")


##' Podemos acceder a las posiciones de los vectores por sus nombres si las tienen
v[2]
v["n2"]

v[3:2]
v[c("n3", "n2")]

##' Tambien se puede acceder a los elementos de un vector indexando con vectores 'logicos'
v

logico <- c(TRUE, FALSE, TRUE)
is.vector (logico)
class (logico)

v[logico]


##' ## Operaciones entre vectores

##' Las operaciones entre vectores se realizan entre los elementos de vectores segun la posicion

c (1,1,2,3) + c (4,5,6,9)

A <- c (1,1,2,3)
B <- c (4,5,6,9)

A + B
A * B
B / A

##' potencias
A^2
A^3

##' potencias (forma alternativa)
A**2


3*A ##' es tambien una operacion entre elementos de vectores
    ##' el vector c(3) se extiende automaticamente

1/A
1/B


##' Generalmente, vectores de diferente longitud se _reciclan_ en las operaciones
A
c (2,3) * A

c (3,3) * c (1,2,3,4)

c (1,2) * c (1,2,3,4) #es lo mismo que:
c (1,2,1,2) * c (1,2,3,4)


##' La longitud de uno de los vectores ha de ser multiplo de la longitud del otro vector.
##' Este tipo de repeticiones suele funcionar con todas las operaciones entre vectores.
c (1,2,1) * c (1,2,3,4) 


##' Missing values: NA (_not available_)
m <- c (1:2, NA, 4:6)
m
class (m)
class (m[3])
m[3]

n <- c ("a", NA, "b")
n
class (n)
class (n[2])
n[2]

is.na (m)
is.na (n)

m
m+1 #los NA se propagan en las operaciones



##' No todas las _operaciones_ entre vectores son _numericas_.
##' Por ejemplo la funcion para concatenar textos:
paste ("texto primero", "texto segundo", sep = " ")

paste ("texto primero", "texto segundo", sep = "_")
paste ("texto primero", "texto segundo", sep = " Y ")

paste ( c("texto1", "texto2"), c("TEXTO1", "TEXTO2", "TEXTO3", "TEXTO4"), sep = " ")



##' Tambien hay operaciones _logicas_ definidas para los vectores logicos
vectorlogico <- is.na (m)
vectorlogico
class (vectorlogico)
length (vectorlogico)
vectorlogico[1:3]


##' Operadres logicos: NEGACION
!TRUE
!FALSE
!vectorlogico       ##afectan a todos los elementos del vector


##' Operadres logicos: Y
TRUE  & TRUE
TRUE  & FALSE
FALSE & FALSE
c (TRUE, TRUE) & c (TRUE, FALSE)


##' Operadres logicos: O
TRUE | TRUE
TRUE | FALSE
FALSE | FALSE
c (TRUE, TRUE) | c (TRUE, FALSE)






##' ## LOOPS con vectores
v

##' Iteramos sobre las posiciones:
posiciones <- 1:3
posiciones
for (i in posiciones) {
  cat ("\n") #linea nueva
  ##
  print (i)
  dato <- v[i]
  print (dato)
}

##' Iteramos sobre los nombres del vector:
nombres <- names (v) 
nombres
for (i in nombres) {
  cat ("\n") #linea nueva
  print (i)
  dato <- v[i]
  print (dato)
}

##' Iteramos __sobre los propios elementos__ del vector.
##' Es una forma particular de R (no esta en algunos otros lenguajes)
for (i in v) {
  cat ("\n") #linea nueva
  print (i)
  dato <- i
  print (dato)
}


##' Funciones que leen y escriben vectores:
##' - readLines
##' - writeLines
##' 

##' ----------------------------------------------------------------------------
