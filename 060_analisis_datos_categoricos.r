##' # Análisis de variables categóricas con R 
##' [Francisco García García](http://bioinfo.cipf.es/ "webpage of department") _(2014-17-12)_  
##'
##' 
##' 
##' ----------------------------------------------------------------------------

##' ### 0. Introducción 
##' ### 1. Tablas de contingencia
##' ### 2. Prueba chi-cuadrado
##' ### 3. Ejercicios
##' ### 4. Bibliografía y enlaces de interés
##' ----------------------------------------------------------------------------

##'<br />
##'<br />
##'<br />
  

##' ## 0. Introducción 
##' Para conocer la relación entre dos variables categóricas utilizaremos:
##' - **Tablas de contingencia** para describir esta relación a nivel muestral.
##' - **Test de chi-cuadrado** para hacer inferencia sobre la relación entre ambas variables.  
##' 
##'<br />
##'<br />
##'
##' ## 1. Tablas de contingencia
##' 
##' Comenzamos leyendo la base de datos **riesgos**:
datos <- read.csv("riesgos.csv", header = T, sep = "\t")
##' Echamos un vistazo a la estructura de los datos:
str(datos)
head(datos)
tail(datos)
##' Con la función **attach** hacemos accesible la base de datos seleccionada:
attach(datos) 
##' Describimos cada una de las variables categóricas: **jornada**, **carfisi** y **expquímica**:
table(jornada)
table(carfisi)
table(expquímica)
##' Nos interesa describir la relación entre **jornada** y cada uno de los dos riesgos mencionados anteriormente. 
##' Utilizaremos el comando **table** para dos variables que nos proporciona una **tabla de contingencia**:
tabla1 <- table(jornada,carfisi)
tabla1
##' También nos gustaría visualizar esta relación: 
plot(tabla1, col = c("red", "blue"), main = "jornada vs. carga física")
tabla2 <- table(jornada, expquímica)
tabla2
plot(tabla2, col = c("red", "blue"), main = "jornada vs. exposición química")
##'  A partir de los datos que nos ofrece la muestra, ¿crees que hay una relación entre el tipo de **jornada** y estar expuesto a **carga física**? 
##'  ¿Qué opinas de la relación entre el tipo de **jornada** y  **exposición química**?
##'<br />
##'<br />
##' 
##' ## 2. Prueba chi-cuadrado 
##' ### 2.1. Independencia de dos variables categóricas.
##' En el apartado anterior detectamos que parece existir una relación entre ambas variables. Las personas con jornada completa tienen
##' una mayor exposición a carga física y menor exposición química que las personas con jornada parcial. 
##' 
##' ¿Estas diferencias serán estadísticamente significativas? Utilizaremos la prueba de **chi-cuadrado**:
chisq.test(tabla1)
chisq.test(tabla2)
##' Con un nivel de significación de 0.05, no podríamos rechazar en ninguno de los dos escenarios la hipótesis nula, 
##' luego consideraremos que hay independencia entre ambas variables, es decir, el tipo de contrato no está asociado a una
##' mayor exposición química o carga física.
##' 
##' ### 2.2. Contraste de homogeneidad de proporciones.
##' Si queremos comparar dos proporciones poblaciones, es posible el tes de comparar proporciones basado en los procedimiento **z**. 
##' ¿Y si disponemos de más de 2 proporciones? Para esta situación, también es posible utilizar el test de chi-cuadrado. Lo vemos con un ejemplo:
##' 
##' Queremos comparar si las proporciones de presencia de **carga física** en tres poblaciones de trabajadores (A, B, C) son iguales 
##' o diferentes.  Para ello, se seleccionaron 3 muestras aleatorias, cada una correspondiente a estas poblaciones. Se obtuvieron 
##' los siguiente resultados:
##' - Población A:  400 personas manifestaron **carga física** de un total de 1380.
##' - Población B:  416 personas manifestaron **carga física** de un total de 1823.
##' - Población A:  188 personas manifestaron **carga física** de un total de 1168.
##' 
##' Calculamos las proporciones de personas con **carga física** en cada uno de los grupos:
400/1780
416/2239
188/1356
##' ¿Observamos diferencias entre las proporcionales a nivel muestral?
##' 
##' Comprobaremos si esas diferencias son estadísticamente significativas utilizando el test de chi-cuadrado. El primer paso
##' será generar una  tabla de contingencia:
fila1 <- c(400,1380)
fila2 <- c(416,1823)
fila3 <- c(188,1168)
tabla=rbind(fila1,fila2,fila3)
colnames(tabla) <- c("con carfisica", "sin carfisica")
tabla  
##' Resolvemos el contraste en R:
resultados <- chisq.test(tabla)
names(resultados)
resultados$observed
resultados$expected
resultados
##' Interpreta los resultados obtenidos:
##' - ¿Cuál es el estadístico de contraste?, ¿cómo se calcula?, ¿cuál sería el rango del estadístico chi-cuadrado?
##' - ¿Qué p-valor obtenemos? 
##' - En el contexto del problema, ¿cómo interpretaríamos los resultados obtenidos en el test estadístico?
##' 
##'<br />
##'<br />
##'
##' ## 3. Ejercicios
##' 
##' En la base de datos **estres.csv** se incluye información sobre los niveles de estrés de un grupo de trabajadores, así
##' como otras variables de interés.
##' 
##' Realiza las siguientes actividades en R:
##' - **A**. Lee la base de datos _estres_,  examina la estructura de los datos (_str_) y utiliza la función _attach_ 
##' para hacerla accesible y trabajar más cómodamente con sus variables. ¿Qué variables son _factor_? ¿Y qué variables son _integer_?
##' - **B**. Describe la relación entre las variables **jornada** y **genero** utilizando una **tabla de contingencia** y un gráfico.
##' ¿Se observa una relación de dependencia entre ambas?.
##'  Aplica el test de chi-cuadrado para valorar si esta relación es estadísticamente significativa.
##'<br />
##'<br />
##'
##' ## 4. Bibliografía y enlaces de interés:
##' 
##' - [David S. Moore. Estadística aplicada básica. Editorial Antoni Bosch.]  (http://www.antonibosch.com/system/downloads/487/original/EC-MOORE2_Contenido.pdf?1358332517)  Manual de Estadística Básica.
##' 

##' - [Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'

##' - [r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'

##' ----------------------------------------------------------------------------
