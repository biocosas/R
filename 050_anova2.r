##' # Análisis de la Varianza (ANOVA) con R 
##' [Francisco García García](http://bioinfo.cipf.es/ "webpage of department") _(2014-12-01)_  
##'
##' 
##' 
##' ----------------------------------------------------------------------------

##' ### 0. Introducción 
##' ### 1. Organización de los datos
##' ### 2. ANOVA y pruebas post-hoc
##' ### 3. Validación del modelo ANOVA 
##' ### 4. Kruskal-Wallis y pruebas post-hoc 
##' ### 5. Bibliografía y enlaces de interés
##' ----------------------------------------------------------------------------

##'<br />
##'<br />
##'<br />
  

##' ## 0. Introducción 
##' Los **procedimientos t de dos muestras permiten comparar las medias de dos poblaciones** o las respuestas medias a dos tratamientos de un 
##' experimento. Sin embargo, **en ocasiones necesitamos comparar más de 2 grupos. El modelo del Análisis de la Varianza (ANOVA)**, nos permitirá
##' abordar este tipo de situaciones. Lo vemos con un ejemplo:
##' 
 
##' Estamos interesados en conocer si hay colores más atractivos para los insectos. Para ello se diseñaron trampas con los siguientes
##' colores: amarillo, azul, blanco y verde. Se cuantificó el número de insectos que quedaban atrapados:
##' 
##' **Azul**: 16 11 20 21 14 7
##' 
##' **Verde**: 37 32 15 25 39 41
##' 
##' **Blanco**: 21 12 14 17 13 17
##' 
##' **Amarillo**: 45 59 48 46 38 47
##' 
##'<br />


##' ## 1. Organización de los datos
##' Generamos dos variables: **insectos** es  la variable respuesta y **colores** es la variable factor (establece los grupos de interés): 
insectos <- c(16,11,20,21,14,7,37,32,15,25,39,41,21,12,14,17,13,17,45,59,48,46,38,47)
colores <- as.factor(c(rep(c("azul", "verde", "blanco", "amarillo"), each =6)))
##' Exploramos los datos de la muestra:
boxplot(insectos ~ colores, col = c("yellow", "blue", "white","green"), ylab = "Número de insectos atrapados")
tapply(insectos, colores, mean)
##'<br />

##' ## 2. ANOVA y pruebas post-hoc
##'Esta es la forma de pedir un ANOVA en R:
fm = aov( lm(insectos ~ colores) )
##'Pedimos un resumen de la tabla del ANOVA
summary(fm)
##'Elementos generados en el ANOVA:
names(fm)
##' 
##' _Identifica en la tabla ANOVA los grados de libertad del factor, los grados de libertad residuales, la suma de cuadrados de los grupos, 
##' la suma de cuadrados del error, las medias correspondientes de las sumas de cuadrados de los grupos y del error, el valor del estadístico F.
##' Describe cómo obtenemos cada uno de ellos._ 
##' 
##'  _¿Cuál es el valor crítico de F bajo la hipótesis nula con un nivel de significación alfa = 0.05? (Este valor nos delimitará la 
##'  región de aceptación y rechazo)_
##'  
##' Bajo la Ho el estadístico de contraste F se distribuye como una F de grados de libertad (I-1), (n-I) 
##' donde I es el número de grupos que disponemos
##' y n el tamaño total de la muestral. Así obtenemos el cuantil buscado:
qf(0.05, 3-1, 18-3, lower.tail = F)
##' Valores del estadístico > 3.68232 estarán incluidos en la región de rechazo. En nuetro caso 30.55 es mucho mayor que el valor crítico obtenido.
##' 
##' _¿Qué valor de la tabla ANOVA nos proporciona la **varianza muestral común** (pooled variance en inglés)? ¿Para qué es útil?_
##' 
##' La raíz cuadrada de la media de los cuadrados del error, además de proporcionarnos una estimación de la varianza muestral de todos los 
##' datos, se utiliza en la obtención de los intervalos de confianza de 
##' las medias en cada uno de los grupos de interés.
##' 
##' Por ejemplo, este sería el intervalo de confianza de la media de los insectos capturados
##' para las trampas amarillas, con un nivel de confianza del 95%:
##' 
media <- mean(insectos[colores =="amarillo"]) 
valor_t <- pt(0.05/2, 18 - 3) 
sp <- sqrt(46)  #desviación típica de la varianza muestral común
ee  <- valor_t * (sp/ sqrt(6))  #error de estimación 
media
##' límite superior del intervalo de confianza de la media de insectos capturados para las trampas amarillas
media + ee 
##' límite inferior del intervalo de confianza de la media de insectos capturados para las trampas amarillas
media - ee 
##'
##'
##' Si hemos detectado **diferencias significativas** entre las medias de las poblaciones.
##'  _¿Sería posible saber cuáles son los grupos que generan estas diferencias?_
intervals = TukeyHSD(fm)
intervals
plot(intervals)
##' _Explica las diferencias existentes por parejas de trampas según el color. ¿Algunas de estas diferencias son significativas? Si 
##' el objetivo es atrapar un mayor número de insectos, ¿con qué tipo de trampas te quedarías?_
##' 
##' 
##'<br />

##' ## 3. Validación del modelo ANOVA
##' A partir de los residuos del modelo comprobaremos si el modelo ANOVA es adecuado. Los supuestos que se deben 
##' cumplir son tres: independencia, homocedasticidad y normalidad.
##' 
##' 
##' ### 3.1. Independencia
plot(fm$residuals)
##' ### 3.2.normalidad
##' 
##' Los gráficos y descriptivos nos informan si se verifica la igualdad de varianzas en los grupos descritos:
summary(fm$residuals)
boxplot(fm$residuals)
hist(fm$residuals)
qqnorm(fm$residuals) 
qqline(fm$residuals)
##' El test de Shapiro-Wilk indica que no tenemos evidencia suficiente para rechazar la hipótesis nula (normalidad de los residuos)
shapiro.test(fm$residuals)
##' ### 3.3.homocedasticidad
##' 
##'Los gráficos y descriptivos nos informan si se verifica la igualdad de varianzas en los grupos descritos:
boxplot(fm$residuals~colores, col = c("yellow", "blue", "white","green"))  
desviaciones <- tapply(fm$residuals, colores, sd)
##'Comparando la desviación máxima con la mínima obtenemos una orientación sobre la falta de homocedasticidad  (>2 aproximadamente)
max(desviaciones) / min(desviaciones)    
##'El test de Bartlett indica que no tenemos evidencia suficiente para rechazar la hipótesis nula (las varianzas son iguales)
bartlett.test(fm$residuals ~ colores)
##'<br />

##' ## 4. Kruskal-Wallis y pruebas post-hoc 
##' ### ¿Qué hipótesis contrasta el test ANOVA?
##' 
##'Ho: las medias son iguales en todas las poblaciones
##'
##'Ha: hay alguna media distinta
##'
##' ### ¿Qué hipótesis contrasta la prueba de Kruskal-Wallis?
##'
##'Ho: la variable respuesta es la misma en todas las poblaciones valoradas
##'
##'Ha: la variable respuesta es mayor en alguna de las poblaciones
##'
##'

##' Cuando  no se cumplen las hipótesis exigidas por el modelo ANOVA, es posible utilizar la prueba no paramétrica Kruskal-Wallis: 

##' ¿hay diferencias significativas entre las poblaciones?
kruskal.test(insectos, colores)

##' _Indica cuál es el estadístico de contraste, los grados de libertad, el p-valor correspondiente y cuál sería el valor crítico que definiría
##' las regiones de aceptación y rechazo con un nivel de significación alfa = 0.05._
##' 
##' Bajo la Ho el estadístico de contraste H del test de Kruskal-Wallis se distribuye como una Chi-cuadrado de grados de libertad (I-1)
##' (donde I es el número de grupos que disponemos).  Así obtenemos el cuantil buscado:
qchisq(0.05, 3-1, lower.tail = F)
##' Valores del estadístico > 5.991465 estarán incluidos en la región de rechazo. En nuetro caso 16.9755 es mucho mayor que el
##'  valor crítico obtenido.
##'  
##' _Si **transformáramos los datos de la variable respuesta**, utilizando logaritmos y después aplicáramos el test de KrusKal-Wallis al 
##' logaritmo del número de insectos atrapados, ¿variarían los resultados del test estadístico?_
##' 
kruskal.test(log(insectos), colores) 
##' Los resultados son exactamente los mismos. No se producen variaciones porque el test de Kruskal-Wallis trabaja sobre rangos, es decir, 
##' sobre ordenaciones de los valores de la variable en cada uno de los grupos. Aunque realicemos una transformación logarítmica, el orden entre
##' los valores de la variable se mantiene y por lo tanto la transformación no afecta a los resultados del test.
##' 
##' _Si hemos detectado **diferencias significativas** en la variable respuesta para las distintas poblaciones.
##'  ¿Sería posible saber cuáles son los grupos que generan estas diferencias?_
library(PMCMR)
posthoc.kruskal.nemenyi.test(insectos, colores, method = "Chisq")

#otra opción:
#library(pgirmess)
#kruskalmc(insectos, colores)
##'<br />
##'<br />

##' ## 5. Bibliografía y enlaces de interés:
##' 
##' - [David S. Moore. Estadística aplicada básica. Editorial Antoni Bosch.]  (http://www.antonibosch.com/system/downloads/487/original/EC-MOORE2_Contenido.pdf?1358332517)  Manual de Estadística Básica.
##' 

##' - [Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'

##' - [r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'

##' ----------------------------------------------------------------------------
