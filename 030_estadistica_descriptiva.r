##' # Estadística Descriptiva con R 
##' [Francisco García García](http://bioinfo.cipf.es/ "webpage of department") _(2014-12-08)_  
##'
##' 
##' 
##' ----------------------------------------------------------------------------

##' ### 0. Introducción 
##' ### 1. ¿Cómo leemos los datos en R?
##' ### 2. Descripción numérica de una variable
##' ### 3. Descripción gráfica de una variable 
##' ### 4. Descripción de relaciones entre parejas de variables 
##' ### 5. Ejercicios complementarios
##' ### 6. Bibliografía y enlaces de interés
##' ----------------------------------------------------------------------------

##'<br />
##'<br />

##' ## 0. Introducción 
##' En cualquier análisis estadístico siempre debemos realizar un descriptivo de la muestra  con un doble objetivo:
##' 
##' 1. Comprobar la calidad de los datos
##' 
##' 2. Conocer detalladamente los datos. Esto nos ayudará a decidir la estrategia de análisis más adecuada.
##'<br />
##'<br />
##' 
##' ## 1. ¿Cómo leemos los datos en R?
##' Existen varias funciones de lectura de datos en R según el formato del archivo. Cuando tenemos un fichero en excel, es aconsejable 
##' guardarlo previamente en formato csv y posteriormente lo leemos desde R con la función **read.csv**:
datos <- read.csv("riesgos.csv", header = T, sep = "\t")
##' Para obtener información detallada de esta función de lectura:
?read.csv

##' Algunas funciones para explorar los datos:
head(datos)
tail(datos)
colnames(datos)
dim(datos)
summary(datos)
attach(datos)
##'<br />
##'<br />



##' ## 2. Descripción numérica de una variable
##' ### 2.1. Variables cuantitativas:
summary(edad)
sd(edad)
sum(edad)
is.na(edad)
##' También es posible pedir un descriptivo de varias variables cuantitativas al mismo tiempo:
summary(datos[, c("edad","peso","talla")])
##'
##' ### 2.2. Variables categóricas:
##' Obtenemos tablas de frecuencias absolutas con el comando **table**:
table(jornada)
##' También es posible obtener tablas de frecuencias relativas combinando los comandos **table** con **margin.table**:
table(jornada)   / margin.table(table(jornada))
##'
##' ### 2.3. Ejercicios:
##' Tenemos una base de datos llamada **estrés** que incluye información sobre 90 trabajadores acerca de su nivel
##' de estrés y diversas variables relacionadas con el puesto de trabajo. 
##' 
##' **A**. Lee los datos en R utilizando la función **read.csv**. 
##' 
##' **B**. ¿Qué variables contiene esta base de datos? (utiliza la función **head**)
##' 
##' **C**. Clasifica las variables según sean cuantitativas o categóricas. A continuación descríbelas utilizando los 
##' procedimientos que hemos visto anteriormente: tablas de frecuencias y descriptivos (en función del tipo de 
##' variable) 
##' 
##' 
##'<br />
##'<br />

##' ## 3. Descripción gráfica de una variable
##' ### Introducción a los gráficos en R:
##' Los comandos de R son funciones que incluyen un conjunto de argumentos separados por comas
##'  y todos ellos entre paréntesis:
##'
# boxplot(datos, main = "primer gráfico", xlab = "nivel de colesterol")
##'  
# hist(datos, main = "primer gráfico", xlab = "nivel de colesterol") 
##' 
##' Argumentos generales que utilizaremos en los gráficos:
##'* **main**: _Título principal del gráfico_
##'
##'* **xlab**: _Etiqueta para el eje X_
##'
##'* **ylab**: _Etiqueta para el eje Y_
##'
##'* **col**: _vector de colores_ 
##'
##'
##' ### 3.1. Variables cuantitativas:
##' Hay varias opciones: box-plots, histogramas,...
##' Con un interrogante delante del nombre de la función obtenemos ayuda sobre su uso:  **?boxplot**   
##' 
##' Es posible incluir o modificar elementos en el gráfico:
##' 
##' Incluimos color en la caja
boxplot(edad, col = "red")
##' Añadimos un título principal y subtítulo para el eje X
boxplot(edad, col = "red", main = "Evaluación de riesgos laborales", xlab = "Edad")  
##' Modificamos la escala del eje Y
boxplot(edad, col = "red", main = "Evaluación de riesgos laborales", xlab = "Edad",
        ylimit = c(0,45)) 

##'
##' ### 3.2. Variables categóricas:
##'
##' Comandos en R:
##'* **table(x)** para obtener la tabla de frecuencias
##'* **pie(table(x))** genera un gráfico de sectores
##'* **barplot(table(x))** genera un diagrama de barras
##'
##' Los diagramas de barras son preferibles a los diagramas de sectores.
##'  
##' **3.2.1 Gráficos circulares o de sectores**:
##' La variable **contrato** indica el tipo de contrato de cada trabajador:  1, 2, 3, 4, 5, 6
##' 
##' Preparamos una tabla de frecuencias
table(contrato)
##' Generamos el diagrama de sectores
pie(table(contrato)) 
##' Seleccionamos colores que nos gusten más para cada sector del gráfico:
pie(table(contrato), col = c("red", "blue", "pink", "green", "grey", "yellow"))  
##' Además incluimos un título 
pie(table(contrato),  col = c("red", "blue", "pink", "green", "grey", "yellow"),
    main = "Tipos de contratos") 
##'
##'
##' **3.2.2. Gráficos de barras:**
##' Este tipo de gráficos son útiles para representar variables categóricas o variables cuantitativas discretas
##' 
##' La variable **contrato** indica el tipo de contrato de cada trabajador:  1, 2, 3, 4, 5, 6
##' 
##' Preparamos una tabla de frecuencias
table(contrato)
##' Generamos el diagrama de barras
barplot(table(contrato)) 
##' Incluimos título del gráfico  y títulos para los ejes X,Y.
barplot(table(contrato), xlab = "contratos", ylab = "frecuencias",
        main = "Evaluación de riesgos")
##' Cambiamos el modo de visualización y añadimos color a las barras
barplot(table(contrato), horiz = TRUE, 
        ylab = "contratos", xlab = "frecuencias", 
        main = "Evaluación de riesgos", 
        col = "green")  


##'
##' ### 3.3. Ejercicios:
##' Continuamos con  la base de datos llamada **estrés**:
##' 
##' **A**. Describe gráficamente la variable **nivel de estrés** utilizando un **diagrama de barras**. 
##' - Incluye un título principal para el gráfico y también subtítulos para los ejes X e Y.
##' - Las barras las colorearemos en verde (pista:   col = "green") 
##' 
##' **B**. Describe gráficamente la variable **sueldo** utilizando un diagrama de cajas (**boxplot**). 
##' - Colorea la caja en azul.
##' - Incluye como título príncipal "Salario de trabajadores del Hospital Dr. Peset". El nombre del eje Y será
##' "euros brutos / año".
##' - Comenta cada uno de los elementos del gráfico: cuartiles, rango de la variable, presencia de valores anómalos.
##' - ¿La variable tiene una distribución normal?
##' 
##' 
##' **C**. Describe gráficamente la variable **jornada** utilizando un **diagrama pastel o de sectores**.
##' - ¿Cuántas tipos de jornadas presenta esta variable? Escoge un color para cada una de ellas en el gráfico. 
##' - Incluye un título para el gráfico.
##' 
##'<br />
##'<br />

##' ## 4. Descripción de relaciones entre parejas de variables 
##' ### 4.1.  Varias variables categóricas
##' Obtenemos **tablas de contingencia** para dos variables categóricas utilizando comando **table**:
table(jornada, carfisi)
##' También es posible estratificar la información anterior por una tercera variable:
table(jornada, carfisi, carpsiqui)
##' 
##' La relación entre **jornada** y **carga física** se puede representar gráficamente:
plot(jornada, carfisi)
##' ### 4.2.  Variable categórica vs. variable cuantitativa
##' _¿Qué relación hay entre la edad y la jornada?_ Lo vemos gráficamente:
boxplot(edad ~ jornada) 
##' _¿Qué relación hay entre la edad y la carfisi?_
boxplot(edad ~ carfisi) 
##' 
##' ### 4.3.  Variable cuantitativa  vs. variable cuantitativa
##' _¿Qué relación hay entre el peso y la talla?_ 
plot(peso, talla)
##' representamos cada sujeto con triángulos azules 
plot(peso, talla, pch = 2, col = "blue", main = "peso vs. talla")     
##' un poco más grandes! 
plot(peso, talla, pch = 2, col = "blue", main = "peso vs. talla", cex=2)    
##' _¿Se podría cuantificar la relación entre estas dos variables cuantitativas?_ Sí, mediante un coeficiente
##' de correlación:
cor.test(peso,talla)
##'
##' ### 4.4. Ejercicios:
##' Continuamos con  la base de datos llamada **estrés**:
##' 
##' **A**. ¿Qué relación hay entre las variables **sueldo** y **edad**? Primero utiliza un gráfico que nos 
##' informe de la relación entre ambas variables y luego cuantifícala mediante un coeficiente de correlación.
##' 
##' **B**. **Salario vs. género**.  ¿Quién cobra más en promedio, los hombres o las mujeres? Representa gráficamente ambas variables para
##' describir la distribución de los salarios en cada uno de estos dos grupos.
##' 
##' **C**. **Exposición a riesgos vs. género**. ¿La exposición de riesgos laborales (carga física, psíquica y ruido) es igual para hombres que para 
##' mujeres?
##' 
##' **D**. **Estrés vs. género**. ¿El nivel de estrés es igual en hombres que en mujeres?
##' 
##'<br />
##'<br />

##' ## 5. Ejercicios complementarios
##'
##' En la base de datos **exposiciones** se incluye información sobre la exposición a determinados riesgos laborales en 
##' un grupo de trabajadores. 
##' - Realiza una descripción detallada de cada una de las variables incluidas en la base
##' - Describe la relación de las siguientes variables por parejas: **carfisica, carpsiquica, ruido, 
##' jornada, sueldo, tipo de contrato, edad y grupo de trabajo**.
##' 
##'<br />
##'<br />

##'
##' ## 6.  Bibliografía y enlaces interesantes:
##' 
##' - [David S. Moore. Estadística aplicada básica. Editorial Antoni Bosch.]  (http://www.antonibosch.com/system/downloads/487/original/EC-MOORE2_Contenido.pdf?1358332517)  Manual de Estadística Básica.
##' 

##' - [Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'

##' - [r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'

##' ----------------------------------------------------------------------------
