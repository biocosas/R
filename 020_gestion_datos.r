##' # Gestión de datos con R 
##' [Francisco García García](http://bioinfo.cipf.es/ "webpage of department") _(2014-12-16)_  
##'
##' 
##' 
##' ----------------------------------------------------------------------------

##' ### 0. Introducción 
##' ### 1. Ordenación 
##' ### 2. Filtrado 
##' ### 3. Recodificación de variables
##' ### 4. Transformación de variables
##' ### 5. Categorizar una variable cuantitativa en una cualitativa
##' ### 6. Ejercicios
##' ### 7. Enlaces de interés
##' ----------------------------------------------------------------------------

##'<br />
##'<br />
##'<br />
  

##' ## 0. Introducción 
##' R nos permite realizar operaciones de gestión de datos como son la ordenación, la selección o exclusión de grupos de registros o variables, 
##' recodificación de variables, transformación de variables, categorización de variables cuantitativas en categóricas....
##' 
##' A continuación se detalla cada una de estas acciones.
##'<br />
##'<br />

##' ## 1. Ordenación
##'
##' Comenzamos leyendo la base de datos **riesgos**  sobre la que realizaremos diversas gestiones de manejo de datos:
datos <- read.csv("riesgos.csv", header = T, sep = "\t")
##' Echamos un vistazo a la estructura de los datos:
str(datos)
head(datos)
tail(datos)
##' Con la función **attach** hacemos accesible la base de datos seleccionada:
attach(datos)
##' Ordenamos los datos por la variable **edad** y guardamos esta nueva información en **datos2**:
datos2 <- datos[order(edad), ]
head(datos2)
##' Ordenamos los datos por la variable **edad** en sentido decreciente y guardamos esta nueva información en **datos2**:
datos2 <- datos[order(-edad), ]
head(datos2)
##' Ordenamos los datos: primero por la variable **edad** en sentido decreciente y en segundo lugar por la
##' variable **peso** en sentido creciente y guardamos esta nueva información en **datos2**:
datos2 <- datos[order(-edad,peso), ]
head(datos2)
##'<br />
##'<br />


##' ## 2. Filtrado
##' En ocasiones necesitamos seleccionar un determinado grupo de variables o un determinado grupo de registros. O ambas cosas a la vez.
##' **¿Cómo realizamos este filtrado desde R?** Vemos algunos ejemplos con la base de datos **riesgos.csv**:
##'
head(datos) 
##'  Seleccionamos las variables id, contrato y carfisi (son **columnas** en la base de datos). Guardamos la nueva información en **datos2**:
datos2 <- datos[, c("id", "contrato", "carfisi")]
head(datos2)
##'  
##'  Ahora seleccionamos los 3 primeros registros de la base **riesgos** y los guardaremos en **datos2**:
datos2 <- datos[1:3, ]
head(datos2)
##'  
##'  También podemos seleccionar registros (**filas** en la base de datos) que verifiquen algún criterio de selección. Por ejemplo,
##'  estamos interesamos en realizar una subselección de la base de datos **riesgos** que incluya sólo personas con **jornada completa**:
datos2 <- datos[jornada=="completa",  ] 
head(datos2)
table(datos2$jornada)
##' Por último queremos realizar la siguiente subselección: sólo nos quedaremos con las variables  id, contrato y carfisi (**columnas**).
##' Al mismo tiempo,  seleccionaremos los registros con **jornada completa** (**filas**):
datos2 <- datos[jornada=="completa", c("id", "contrato", "carfisi")]
head(datos2)
##'<br />
##'<br />


##' ## 3. Recodificación de variables
##' Hay varias situaciones en las que nos interesará la recodificación de las variables:
##' 
##' **3.1. Recodificamos los valores de una variable por otros valores en esa misma variable.**
##'  Ejemplo: queremos cambiar los valores de la **talla > 165** por **180**: 
talla
talla[talla > 165] <- 200 
talla
##' **3.2. O bien realizamos una recodificación de valores pero en otra variable distinta de la inicial:**
peso2 <- peso
peso2[peso > 75] <- 99 
peso
peso2
##' 
##'<br />
##'<br />
##'
##'

##' ## 4. Transformación de variables
##' **¿Cómo podemos incorporar nuevas variables en nuestra base de datos?** Veamos algunos ejemplos:
##' 
##' Queremos crear una variable en la base de datos **riesgos.csv** que se llame **índice de masa corporal** que se obtiene dividiendo
##' el peso en kg. entre el cuadrado de la altura en metros. Veamos como lo hacemos en R:
datos[, "IMC"]  <- peso / (talla/100)^2
head(datos)
##' 
##'<br />
##'<br />
##' ## 5. Categorizar una variable cuantitativa en una cualitativa
##' Esta opción suele ser muy habitual. Disponemos de la información detallada para una variable pero en ocasiones
##' nos interesa trabajar con esta variable en su versión categórica.
##' 
##' Por ejemplo, categorizaremos la variable cuantitativa **IMC** en cuatro grupos:  
##' - **bajo peso**:  IMC <= 18.50
##' - **normal**:  18.5 < IMC <=25
##' - **sobrepeso**:  25 < IMC <= 30
##' - **obesidad**:     IMC >30
##' En realidad buscamos los siguientes tramos de edad:  (minimo, 18.5], (18.5, 25], (25, 30], (30, máximo]
summary(datos[,"IMC"])
datos[,"IMC_grupos"] <- cut(datos$IMC, breaks = c(14,18.5,25,30,34), labels = c("bajo peso", "normal", "sobrepreso", "obesidad"))
head(datos)
##' ¿Cuántas personas tenemos en cada uno de las categorías de IMC?
table(datos[,"IMC_grupos"])
##'<br />
##'<br />



##' ## 6. Ejercicios
##'
##' En la base de datos **estres.csv** se incluye información sobre los niveles de estrés de un grupo de trabajadores, así
##' como otras variables de interés.
##' 
##' Realiza las siguientes actividades en R:
##' - **A**. Lee la base de datos _estres_,  examina la estructura de los datos (_str_) y utiliza la función _attach_ 
##' para hacerla accesible y trabajar más cómodamente con sus variables. ¿Qué variables son _factor_? ¿Y qué variables son _integer_?
##' - **B**. ¿Qué ID tiene la persona con mejor salario? Una opción podría ser la ordenación de la base de datos 
##' por la variable _salario_ en sentido decreciente. 
##' - **C**. Realiza una _subselección_ en  _datos_ que guardaremos en _datos2_, 
##' con los trabajadores que tengan un nivel de estrés mayor de 5. 
##' - **D**. También nos gustaría seleccionar los trabajadores  que presenten simultáneamente  carga física > 3, carga psíquica > 4 y ruido > 4. 
##' Salvaremos la subselección en _datos3_.
##' - **E**. Nos hemos equivocado en la introducción de datos y para todos los valores _2_ de carga física, queríamos haber puesto 
##' un _3_. _Recodifica_ esta variable en ella misma incluyendo este cambio.
##' - **F**. Crea una nueva variable llamada _expo_total_ que se obtenga como suma de los valores de exposición en _carga física_,
##' _carga psíquica_ y _ruido_.
##' - **G**. _Categoriza_ la variable _estres_ en otra nueva variable que llamaremos _estres_grupo_ que incluya tres categorías:
##' _bajo_: 1 a 2;  _medio_: 3 a 7;  _alto_; 8 a 10. ¿Cuántas personas hay en cada categoría de la nueva variable.
##' <br />
##' <br />
##'
##' ## 7. Enlaces de interés
##'
##' - [Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'

##' - [r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'

##' ----------------------------------------------------------------------------
