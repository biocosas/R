##' # Análisis de la Varianza de Friedman con R 
##' [Francisco García García](http://bioinfo.cipf.es/ "webpage of department") _(2014-12-12)_  
##'
##' 
##' 
##' ----------------------------------------------------------------------------

##' ### 1. Objetivo del estudio  y diseño del experimento
##' ### 2. Organización de los datos en R
##' ### 3. Análisis exploratorio de los datos
##' ### 4. Detección de diferencias significativas: ANOVA de Friedman
##' ### 5. Bibliografía y enlaces de interés
##' ----------------------------------------------------------------------------

##'<br />
##'<br />
##'<br />
  

##' ## 1. Objetivo del estudio  y diseño del experimento
##' El **objetivo** del estudio es evaluar las diferencias del crecimiento celular entre dos grupos 
##' experimentales: Wild Type (WT) y un mutante (KO).
##' 
##' **Diseño del experimento**. Se realizaron un conjunto de experimentos con la misma estructura: 4 puntos de tiempo (24h, 48h, 72h y 96h) donde
##' se cuantificaron el número de células en cada uno de los dos grupos descritos (WT, KO)
##'<br />
##'<br />




##' ## 2. Organización de los datos en R
##'
##' El experimento NE77  se excluyó del estudio por presentar diferentes puntos de tiempos
##' 
##'  Leemos los datos:
setwd("/home/paco/Desktop/\ Dropbox/github/tutorR")
datos <- read.csv("ful.csv",sep = "\t", header = T)
##' Estructura de los datos: 
datos
##' Dimensión de la matriz de datos (número de filas x número de columnas):
dim(datos)
##'<br />
##'<br />


##' ## 3. Análisis exploratorio de los datos
##'
##' ### 3.1. Exploramos la muestra determinando algunos estadísticos descriptivos:
summary(datos)
##' ¿Hay mucha variabilidad entre los 16 experimentos? Sí. Lo comprobamos determianando las desviaciones típicas en cada punto de tiempo y
##' grupo experimental:
desviaciones_wt <- apply(datos[datos$group=="WT",c("t24", "t48", "t72", "t96")], 2, sd)
desviaciones_wt
desviaciones_ko <- apply(datos[datos$group=="KO",c("t24", "t48", "t72", "t96")], 2, sd)
desviaciones_ko
##' Los descriptivos apuntan a que los datos proporcionados en cada experimento tienen una escala muy distinta entre ellos. 
##' Estas diferencias se observan dentro de cada grupo experimental y entre ellos.
##' **Esto dificultará su comparación. De modo que habrá que normalizarlos o estandarizarlos para que puerdan ser comparados**.
##' 
##' ### 3.2. Representamos gráficamente los datos:
##' 
##' Previamente preparamos el input que precisa la función de representación del gráfico: 
library(reshape)
mdata <- melt(datos, id=c("experiment","group"))
colnames(mdata) <- c("experiment", "group", "time", "growth")
dim(mdata)
attach(mdata)
##' Vemos cómo hemos organizado los datos:
head(mdata)
##' El gráfico del crecimiento celular muestra patrones similares en ambos grupos, aunque las medianas (líneas gruesas dentro de cada caja)
##' son mayores en todos los tiempos:
par(mfrow = c(1, 2))
plot(growth ~ time, col = "red",
     varwidth = TRUE, subset = group == "WT", main = "WT", ylim =c(0,3000000))
plot(growth ~ time, col = "green",
     varwidth = TRUE, subset = group == "KO", main = "KO", ylim =c(0,3000000))
par(mfrow = c(1, 1))

##'DUDAS: Aparecen algunos valores anómalos y QUIZAS AQUI HABRIA QUE ELIMINARLOS. TAMBIEN VER CON DETALLE KO EN T96 

##'
##' ### 3.3. Transformación logarítmica de los datos.
##' Una transformación logarítmica, permite visualizar mejor los datos cuando existen grandes diferencias de escala. 
##' Tras la aplicación de log2 sobre los datos, los representamos y se sigue observando el mismo patrón en ambos grupos pero con un incremento
##' del crecimiento celular en KO:
##' 
mdata[, "log2_growth"]  <- log2(mdata$growth)
attach(mdata)
par(mfrow = c(1, 2))
plot(log2_growth ~ time, col = "red",
     varwidth = TRUE, subset = group == "WT", main = "WT", ylim =c(12,22))
plot(log2_growth ~ time, col = "green",
     varwidth = TRUE, subset = group == "KO", main = "KO", ylim =c(12,22))
par(mfrow = c(1, 1))
##' 
##' ### 3.4. Normalización o estandarización de los datos.  
##' Existen diferentes formas de normalizar los datos para que puedan ser comparados entre ellos. Una de ellas sería el cambio de escala 
##' en cada experimento, considerando como referencia el nivel de crecimiento en el tiempo 24 (referencia basal).
##'
##' A continuación dividimos todos los datos de cada experimento por el valor de crecimiento en el tiempo 24:
ndatos  <- datos[,c("t24", "t48", "t72", "t96")] /  datos[,"t24"] 
ndatos <- cbind(datos[,c("experiment", "group")],ndatos)
##' Estos son los datos normalizados considerando como referencia basal el tiempo 24 en cada experimento:
ndatos
##' Describimos los datos normalizados:
mdata <- melt(ndatos, id=c("experiment","group"))
colnames(mdata) <- c("experiment", "group", "time", "growth")
attach(mdata)
summary(mdata)
##' Representamos gráficamente los datos normalizados y las diferencias se aprecian con mayor claridad:
par(mfrow = c(1, 2))
plot(growth ~ time, col = "red",
     varwidth = TRUE, subset = group == "WT", main = "WT", ylim =c(0,40))
plot(growth ~ time, col = "green",
     varwidth = TRUE, subset = group == "KO", main = "KO", ylim =c(0,40))
par(mfrow = c(1, 1))





##'     
##'<br />
##'<br />


##' ## 4. Detección de diferencias significativas: ANOVA de Friedman
##'
##' La muestra presenta diferencias entre WT y KO a lo largo del tiempo. ¿Son diferencias estadísticamente significativas?. Aplicaremos
##' el test de ANOVA de Friedman. Es una prueba no paramétrica que permite abordar este tipo de estudios cuando no podemos garantizar la 
##' normalidad de los datos en los distintos grupos evaluados:
##' 
##' 
##' DUDAS:
##' 1.  ¿pOR QUÉ NO UTILIZO LA MEDIANA EN LUGAR DE LA MEDIA?  (results are the same)
##' 2. I think is better to eliminate outliers before normalization, after normalization the problem doesn't improve
##' 3. Calculate a plot where we have two differnt pattern of growths but showing medians and its confidence interval
resp <- aggregate(mdata$growth,
                  by = list(g = group,
                            t = time),
                  FUN = mean)

resp <- aggregate(mdata$growth,
                  by = list(g = group,
                            t = time),
                  FUN = median)
resp$x[is.na(resp$x)] <- mean(c(1.218182,1.382353,1.608696,1.960000,3.210526,3.318182,3.722222))
#I have to solve how to exclude NA: na.rm=TRUE MAYBe in BY
resp
friedman.test(x ~ g | t, data = resp) 

##'  - Los resultados del test estadístico muestran un p-valor 0.08326. **Si consideramos un nivel de significación alfa de 0.1, 
##' sí podríamos indicar que las diferencias detectadas a nivel muestral son estadísticamente significativas**. 
##'  - Si somos más estrictos, utilizando un nivel de significación alfa de 0.05, entonces no detectaríamos diferencias significativas aunque estamos muy próximos
##' a este nivel de significación. 
##' 
##'<br />
##'<br />
##'<br />
##'
##' ## 5. Bibliografía y enlaces de interés:
##' - [Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'

##' - [r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'


##' ----------------------------------------------------------------------------
