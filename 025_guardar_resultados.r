##' # Guardar resultados en R 
##' [Francisco García García](http://bioinfo.cipf.es/ "webpage of department") _(2014-12-16)_  
##'
##' 
##' 
##' ----------------------------------------------------------------------------

##' ### 0. Introducción 
##' ### 1. Guardando toda la información NO gráfica en un fichero de texto
##' ### 2. Guardando una base de datos (data.frame o matrix) en un fichero de texto
##' ### 3. Salvamos los objetos generados en la sesión de R en un fichero .RData
##' ### 4. Guardar todos los resultados tras ejecutar un script de R desde la consola
##' ### 5. Enlaces de interés
##' ----------------------------------------------------------------------------

##'<br />
##'<br />
##'<br />
  

##' ## 0. Introducción 
##' R genera diversos tipos de resultados: tablas, gráficos.... ¿cómo podemos guardar estos resultados?
##' 
##' Existen varias opciones. Escogeremos aquella que mejor se ajuste a lo que queremos realizar después con los resultados. 
##'
##'<br />
##'<br />

##' ## 1. Guardamos información NO gráfica en un fichero de texto.
##'
##' En ocasiones sólo queremos salvar los resultados no gráficos. En ese caso utilizaremos las función **sink** y
##' especificaremos un fichero de texto donde se guardarán los resultados obtenidos.
##' 
##' Primero comprobamos cuál es el **working directory**:
getwd() 
##' Es posible cambiar el **working directory** con la función **setwd()**
##' Con la función **sink** decimos que la salida de R será el fichero de texto que indiquemos:
sink("resultados.txt") 
a <- c(1, 2, 3, 5)
summary(a)
print(a) 
##' Si ya hemos terminado de guardar resultados, redirigimos otra vez la salida a la pantalla (como estaba al principio)
sink() 
print(a)
##'<br />
##'<br />

##' ## 2. Guardando una base de datos (data.frame o matrix) 
##' Tras generar una base de datos (data.frame o matrix) es posible guardar ese objeto específico 
##' con varias funciones como **write.table**, **write.csv** o **write.matrix**:
talla <- c(150, 156, 166, 175, 175)
peso <- c(75, 70, 72, 80, 55)
provincia <- c("Alicante", "Castellon", "Valencia", "Valencia", "Alicante")
datos <- as.data.frame(cbind(talla, peso, provincia))
datos
write.table(datos, "misdatos.txt", sep = "\t", quote = F, row.names = F)
##'<br />
##'<br />

##' ## 3. Salvamos los objetos generados en la sesión de R en un fichero .RData
##' Con las funciones **save** y **save.image** es posible guardar todos o algunos específicos objetos generados 
##' en la sesión de R. Luego los volveremos a cargar en la sesión con la función **load**. Vemos un ejemplo:
##' 
talla <- c(150, 156, 166, 175, 175)
peso <- c(75, 70, 72, 80, 55)
provincia <- c("Alicante", "Castellon", "Valencia", "Valencia", "Alicante")
datos <- as.data.frame(cbind(talla, peso, provincia))
datos
##' Más objetos:
datos2 <- datos[, 1:2]
head(datos2)
##' ¿Qué objetos tenemos en la sesión?
ls()
##' Guardamos todos los objetos en un único fichero específico de R:
save.image(file = "resultados.RData")
##' Cargamos todos los objetos en la sesión de R:
load("resultados.RData")
##' Si sólo queremos guardar alguno o algunos objetos, se puede salvar con la función **save**:
save(datos, datos2, file = "dosresultados.RData")
##'<br />
##'<br />

##' ## 4. Guardar todos los resultadostras ejecutar un script de R desde la consola
##' Si tenemos acceso a una consola, se podría ejecutar un script con la línea de comando
##' **R CMD BATCH**, generándose un fichero con todos los resultados:
#R CMD BATCH script.R
##' <br />
##' <br />

##' ## 5. Enlaces de interés
##'
##' - [Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'

##' - [r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'

##' ----------------------------------------------------------------------------
