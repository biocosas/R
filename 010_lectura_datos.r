##' # Lectura de datos en R 
##' [Francisco García García](http://bioinfo.cipf.es/ "webpage of department") _(2014-12-14)_  
##'
##' 
##' 
##' ----------------------------------------------------------------------------

##' ### 0. Introducción 
##' ### 1. ¿Cómo leemos los datos de ficheros procedentes de EXCEL?
##' ### 2. ¿Cómo leemos los datos con formato txt?
##' ### 3. Lectura de otro tipo de formatos desde R.
##' ### 4. Ejercicios complementarios
##' ### 5. Enlaces de interés
##' ----------------------------------------------------------------------------

##'<br />
##'<br />

##' ## 0. Introducción 
##' Para introducir nuestros datos en R disponemos de dos formas generales:
##'  
##' - **Introducción manual**: transcribimos los datos en el editor de R
altura <- c(150,157, 160,130, 158, 157)

##' - **Importamos los datos de distintos formatos** (EXCEL, txt, csv....) utilizando funciones específicas de R: 
##' read.table, read.csv... Un ejemplo:
#  datos <- read.table("misdatos.txt", header = T)

##'<br />
##'<br />
##' 
##' ## 1. ¿Cómo leemos los datos de ficheros procedentes de EXCEL?
##' Existen varias funciones de lectura de datos en R según el formato del archivo.
##' Cuando tenemos un fichero en excel, es aconsejable 
##' guardarlo previamente en formato [csv] (http://es.wikipedia.org/wiki/CSV/)
##' y posteriormente lo leemos desde R con la función **read.csv**:
datos <- read.csv("riesgos.csv", header = T, sep = "\t")
##' Para obtener información detallada de esta función de lectura:
?read.csv
##' Algunos comentarios:
##' - **header = T** indica que la primera línea de nuestros datos contien el nombre de las variables
##' - **sep = "\t"** advierte que la separación entre los valores es una **tabulación** (en otras ocasiones puede ser
##' otro carácter como un **;**, **,** o cualquier otro)
##' - Con el símbolo **<-** asignamos al objeto que hemos llamado en R **datos**, los datos incluidos en nuestro 
##' fichero original.
##' - Es posible indicar otros detalles como cuál es el separador decimal que preferimos (**dec = "."**), si queremos  
##' leer un número n de líneas (**nrows = n**)...
##' 
##' A continuación es conveniente explorar los datos para conocerlos con más detalle y también comprobar
##' que el proceso de lectura ha sido correcto o bien si debemos realizar algún ajuste:
head(datos)
tail(datos)
colnames(datos)
dim(datos)
summary(datos)
attach(datos)
##'<br />
##'<br />

##' ## 2. ¿Cómo leemos los datos con formato txt?
##' La lectura de datos en formato **txt** es similar a la de los ficheros **csv**. Se utiliza la función
##' **read.table**:
datos <- read.table("estres.txt", header = T, sep = "\t")
##' Para obtener información detallada de esta función de lectura:
?read.table
##'<br />
##'<br />

##' ## 3. Lectura de otro tipo de formatos desde R.
##' Es posible leer datos de formatos procedentes de otras herramientas estadísticas como SPSS, STATA, SAS, 
##' Epi-Info,.. Para ello se pueden utilizar las funciones de lecturas incluidas en el paquete de R **foreign**.
##' Un ejemplo:
# library(foreign)  #cargamos esta librería en nuestra sesión de R
# datos <- read.spss( file= "misdatos.sav", to.data.frame = TRUE)
# str(datos)
##' 
##'<br />
##'<br />

##' ## 4. Ejercicios complementarios
##'
##' La base de datos **estres.txt** contiene información sobre los niveles de estrés de 90 trabajadores,
##' así como variables relacionadas con su puesto de trabajo. La primera línea del archivo incluye los nombres
##' de las variables. 
##' - Lee la información correspondiente a los primeros 50 sujetos y almacena la información con el nombre **datos1**.
##' Comprueba la dimensión de la nueva base (**dim**). ¿Qué tipo de objeto es **datos1**? (**class**)
##' 
##'<br />
##'<br />

##'
##' ## 5.  Enlaces interesantes:
##' 

##' - [Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'

##' - [r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'

##' ----------------------------------------------------------------------------
