##' # Gráficos estadísticos con R 
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
  

##' ## 0. Introducción 
#esto es una linea comentada
##' Los comandos de R son funciones que incluyen un conjunto de argumentos separados por comas y todos ellos entre paréntesis:
##'
# boxplot(datos, main = "primer gráfico", xlab = "nivel de colesterol")
##'  
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
 

##'<br />
##' ## 1. Representación gráfica de una variable cuantitativa 
##' Comandos en R:
##'* **boxplot(x)**: diagramas de caja
##'
##'* **hist(x)**: histograma
##'
##' Queremos representar gráficamente los valores de la variable colesterol. Utilizaremos los **diagramas de cajas** o **boxplots**:
#incluimos los datos de nuestra variable
colesterol <- c(150,125,138,144,150,201,225,233,200,190, 250,150,180,240,235)  
boxplot(colesterol)


##' Con un interrogante delante del nombre de la función obtenemos ayuda sobre su uso:  **?boxplot**   
##' 
##' Es posible incluir o modificar elementos en el gráfico:
# incluimos color en la caja
boxplot(colesterol, col = "red")
# añadimos un título principal y subtítulo para el eje X
boxplot(colesterol, col = "red", main = "Exp. 53", xlab = "Colesterol")  
# modificamos la escala del eje Y
boxplot(colesterol, col = "red", main = "Exp. 53",xlab = "Colesterol",
        ylimit = c(0,250)) 


##' Estos 15 valores corresponden a 3 grupos de ratones, que fueron sometidos a distintos tratamientos. 
##' **¿Observamos diferencias a partir de su representación gráfica?**
colesterol <- c(150,125,138,144,150,201,225,233,200,190, 250,150,180,240,235)
tratamientos <- c("A","A","A","A","A","B","B","B","B","B","C","C","C","C","C")
##'
# así sería más rápido:
tratamientos <- c(rep("A",5), rep("B",5), rep("C",5))

##' Representamos la variable colesterol para cada uno de los tres grupos descritos:
boxplot(colesterol ~ tratamientos)
# coloreamos las cajas de cada representación:
boxplot(colesterol ~ tratamientos, col= c("red", "blue", "pink")) 

##' **Valores de colesterol superiores a 175 pueden ser peligrosos**. Incluimos una línea horizontal que señalice este límite:
boxplot(colesterol ~ tratamientos, col= c("red", "blue", "pink")) 
abline(h = 175)
#indicamos que sea una línea gruesa y de color verde
boxplot(colesterol ~ tratamientos, col= c("red", "blue", "pink")) 
abline(h = 175, col = "green", lwd = 2)   
# nos gustan más las distribuciones horizontales de estos plots, las cambiamos:
boxplot(colesterol ~ tratamientos, col= c("red", "blue", "pink"), horizontal = TRUE) 
abline(v = 175, col = "green", lwd = 2) 
##'<br />



##' ## 2. Representación gráfica de una variable categórica o cualitativa
##'
##' Comandos en R:
##'* **table(x)** para obtener la tabla de frecuencias
##'* **pie(table(x))** genera un gráfico de sectores
##'* **barplot(table(x))** genera un diagrama de barras
##'
##' Los diagramas de barras son preferibles a los diagramas de sectores.
##'  
##' ### 2.1. Gráficos circulares o de sectores:
##' La variable **mut** indica el número de mutaciones encontradas en varios genes de interés (varía entre 1 y 5)
# introducimos los datos
mut <- c(1,3,5,2,4,4,4,1,1,1,1,3,5,2) 
# preparamos una tabla de frecuencias
table(mut)
# generamos el diagrama de sectores
pie(table(mut)) 
# seleccionamos colores que nos gusten más para cada sector del gráfico:
pie(table(mut), col = c("red", "blue", "pink", "green", "grey"))  
# además incluimos un título 
pie(table(mut),  col = c("red", "blue", "pink", "green", "grey"),
    main = "Tipos de variantes genómicas") 

 
##' ### 2.2. Gráficos de barras:
##' Este tipo de gráficos son útiles para representar variables categóricas o variables cuantitativas discretas
##' 
##' La variable **mut** indica el número de mutaciones encontradas en varios genes de interés (varía entre 1 y 5)

# introducimos los datos
mut <- c(1,3,5,2,4,4,4,1,1,1,1,3,5,2) 
# preparamos una tabla de frecuencias
table(mut)
# generamos el diagrama de barras
barplot(table(mut)) 
# incluimos título del gráfico  y títulos para los ejes X,Y.
barplot(table(mut), xlab = "número de mutaciones", ylab = "frecuencias",
        main = "Mutaciones detectadas en genes OPITZ")
# cambiamos el modo de visualización y añadimos color a las barras
barplot(table(mut), horiz = TRUE, 
        ylab = "número de mutaciones", xlab = "frecuencias", 
        main = "Mutaciones detectadas en genes OPITZ", 
        col = "green")  



##'<br />
##' ## 3. Representación gráfica de dos variables cuantitativas
##' 
##' Queremos conocer la relacion entre el nivel de cuantificación de varios metabolitos

##' introducimos los datos de 3 metabolitos:
glutamato <- c(143, 90, 100, 119,  98,  87,  84,  99, 101,  99)
colina <- c(146, 97, 106, 123, 103,  90,  90, 106, 108, 101)  
HLDL <-   c(100, 107, 105, 89, 88, 102, 122, 105, 93, 145)

##' **¿Qué relación hay entre la colina y el HLDL?** Utilizaremos los gráficos de dispersión o de puntos
plot(colina, HLDL)
# representamos cada metabolito con triángulos azules 
plot(colina, HLDL, pch = 2, col = "blue", main = "colina vs. HLDL")     
# un poco más grandes! 
plot(colina, HLDL, pch = 2, col = "blue", cex =2, main = "colina vs. HLDL")  
# añadimos la recta de regresión 
abline(lm(colina ~ HLDL), col = "red", main = "colina vs. HLDL") 

##' ¿Y entre la colina y el glutamato?
plot(colina, glutamato, main = "colina vs. glutamato")
#puntos más pequeños y con color
plot(colina, glutamato, main = "colina vs. glutamato", cex=0.5, col = "blue") 

##' Estos metabolitos corresponden a dos grupos de ratas y queremos saber si el comportamiento entre colina y glutamato
##' es diferente en cada grupo. ¿Es posible visualizar esta información gráficamente?

grupos <-  c(1,1,1,1,1,2,2,2,2,2)
plot(colina, glutamato, main = "colina vs. glutamato", col = c("red", "blue"), pch = grupos, cex = 2) 
legend(130,100, legend=c("1","2"), pch= c(1:2), col = c("red", "blue") )



##' ¿Podemos ver las relaciones de los tres metabolitos por parejas?
pairs(~glutamato + colina + HLDL)
#incluyendo nuevos elementos en el gráfico
pairs(~glutamato + colina + HLDL, col = "blue", main = "Correlación lineal entre metabolitos")



##'<br />
##' ## 4.  ¿Cómo importamos en R datos desde un fichero txt?
##' 
# datos de las cuantificaciones de los metabolitos, separados por tabulaciones 
datos <- read.delim("datos.txt", header = TRUE, sep = "\t")
datos



##'<br />
##' ## 5. ¿Cómo guardamos los gráficos generados en R?
##' 
##' **5.1.** Es posible generar varios gráficos y que aparezcan en la misma ventana, antes de guardarlos. Lo vemos con un ejemplo:
# a. Definimos  el número de filas y columnas que tendrá esa ventana, por ejemplo: 2 filas y 1 columna:
par(mfrow=c(2,1))
# b. Generamos los dos gráficos que queremos incluir en la misma imagen:
boxplot(colesterol)
hist(colesterol)
# c. Para finalizar, dejamos la región del dibujo como estaba inicialmente: 1 fila y 1 columna
par(mfrow=c(1,1))

##'
##' **5.2.** Los gráficos que hemos creado en la sesión de R se pueden crear en diferentes formatos BMP, JPEG, PNG, TIFF, PDF...
##' 
##' Desde R o Rstudio es posible guardarlos directamente, pero también podemos ajustar las características de la resolución, utilizando 
##' los siguientes comandos:
##' 
##' Vemos algunos ejemplos con el gráfico de dispersión de los metabolitos
pairs(~glutamato + colina + HLDL, col = "blue", main = "Correlación lineal entre metabolitos")
#guardamos el gráfico en formato PNG:
png(file="cor_metabolitos.png", height = 600, width = 600)  # avisa a R que queremos un fichero PNG 
pairs(~glutamato + colina + HLDL, col = "blue", main = "Correlación lineal entre metabolitos")
dev.off()  #cierra el dispositivo gráfico
#guardamos el gráfico en formato JPEG:
jpeg(file="cor_metabolitos.jpeg", height = 600, width = 600)  # avisa a R que queremos un fichero PNG 
pairs(~glutamato + colina + HLDL, col = "blue", main = "Correlación lineal entre metabolitos")
dev.off()  #cierra el dispositivo gráfico
#guardamos el gráfico en formato PDF:
pdf(file="cor_metabolitos.pdf")  # avisa a R que queremos un fichero PNG 
pairs(~glutamato + colina + HLDL, col = "blue", main = "Correlación lineal entre metabolitos")
dev.off()  #cierra el dispositivo gráfico


##' Obtenemos información detallada sobre como exportar en diferentes formatos con **?png** o **?pdf**





##'<br />
##'<br />
##'<br />
##' ## 6. Ejercicios
##' 
##' ### 6.1.  Tiempo de recuperación en ratas con lesión medular
##' 
##' Tenemos un grupo de 16 ratas con lesión medular. Tras aplicar un tratamiento hemos medido el tiempo de recuperación en días.
##' Estos son los datos: 14 15 16 19 11 15 13 13 15 21 18 18 16 16 15 21
##' 
##' 1. Describe la variable tiempo utilizando un **diagrama de caja** o box-plot
##' 1. **Incluye o modifica elementos** como el título del gráfico, título del eje x, color verde para la caja. 
##' 1. **Cambia la escala del eje Y**, de modo que se visualice un rango entre 0 y 25 días.
##' 1. **Exporta** el gráfico en formato **pdf**.
##'
##'
##' ### 6.2.  Tiempo de recuperación en ratas con lesión medular: dos tratamientos
##' 
##' De las 16 ratas anteriores, distinguimos dos grupos: a las 8 primeras se les aplicó el tratamiento **A** y a las 8 últimas
##' el tratamiento **B**.
##' 
##' 1. **¿Qué grupo se recupera antes?**.  Puedes utilizar un gráfico que incluya un **diagrama de cajas** para cada grupo.
##' 1. **Incluye o modifica elementos** como el título del gráfico, título del eje x, color verde para la caja. 
##' 1. **Cambia la escala del eje Y**, de modo que se visualice un rango entre 0 y 25 días.
##' 1. **Exporta** el gráfico en formato **png**.


##'<br />
##'<br />
##'<br />
##'<br />

##'
##' ## Links interesantes:
##' 
##' -[Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'
##' -[ggplot2] (http://ggplot2.org/)  Paquete de funciones que personalizan cualquier tipo de gráfico.
##' 
##' -[r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'

##' ----------------------------------------------------------------------------
