##' # Bootstrap con R 
##' [Francisco García García](http://bioinfo.cipf.es/ "webpage of department") _(2014-10-12)_  
##'
##' 
##' 
##' ----------------------------------------------------------------------------

##' ### 0. Introducción 
##' ### 1. Ejemplos
##' ### 2. Cálculo de intervalos de confianza
##' ### 3. Ejercicios
##' ### 4. Bibliografía y enlaces interesantes
##' ----------------------------------------------------------------------------

##'<br />
##'<br />
##'<br />
  

##' ## 0. Introducción 
##' - La inferencia estadística se basa en la distribución de los diferentes estadísticos. Esta distribución la conocemos al seleccionar diferentes muestras de tamaño n de la misma población.
##'
##' - La distribución de un estadístico se obtiene al observar sus valores en muchas muestras de la población. 
##' 
##' - La técnica de bootstrap consiste en obtener la distribución de un estadístico (al menos de forma aproximada) 
##' utilizando la información que se deriva de una sola muestra (y sus réplicas).
##' 
##' ### Procedimiento:
##' **Replicación**: en lugar de tomar muchas muestras de la población, obtener réplicas (muestras con reemplazamiento) de la muestra original. Todas las
##' réplicas deben tener el mismo tamaño que la muestra original: n.
##' 
##' La **distribución bootstrap del estadístico** se obtiene a partir de estas muestras y sirve para _estimar_ la distribución del estadístico.
##'<br />
##'<br />
##'<br />

##' ## 1. Ejemplos
##' ### 1.1. ¿Cuál es el error típico de la media muestral? 
##' Generamos una muestra de 50 valores que siguen una distribución normal de media 10 y desviación típica 2:
x = rnorm(50, mean=10, sd=2) 
x
##' A continuación creamos un vector vacío (en realidad está formado por 1000 ceros) donde almacenaremos los resultados que obtenemos:
medias=numeric(1000) 
head(medias)
length(medias)
##' Mediante este código repetiremos 1000 veces las siguientes acciones: extracción de una muestra con reemplazamiento desde x, cálculo de la media muestral de esta nueva réplica y 
##' almacenamiento de la media muestral obtenida en el vector **medias** que hemos generado anteriormente:  
for(i in 1:1000)
{
  muestra=sample(x, replace=T)
  medias[i]=mean(muestra)
}

##' Evaluamos los resultados obtenidos:
hist(medias) #un histograma de las medias
qqnorm(medias, datax=T) #papel probabilistico normal
mean(medias) # el centro de la distribucion de las medias
sd(medias) # la desviacion tipica de las medias
##' 
##' 
##'
##' ### 1.2. ¿Cuál es el error típico de la mediana muestral? 
##' Generamos una muestra de 70 valores que siguen una distribución normal de media 5 y desviación típica 1:
x = rnorm(70, mean=5, sd=1) 
x
##' A continuación creamos un vector vacío (en realidad está formado por 1000 ceros) donde almacenaremos los resultados que obtenemos:
medianas=numeric(1000) 
head(medianas)
length(medianas)
##' Mediante este código repetiremos 1000 veces las siguientes acciones: extracción de una muestra con reemplazamiento desde x, cálculo de la mediana muestral de esta nueva réplica y 
##' almacenamiento de la mediana muestral obtenida en el vector **mediana** que hemos generado anteriormente:  
for(i in 1:1000)
{
  muestra=sample(x, replace=T)
  medianas[i]=median(muestra)
}

##' Evaluamos los resultados obtenidos:
hist(medianas) #un histograma de las medianas
qqnorm(medianas, datax=T) #papel probabilistico normal
mean(medianas) # el centro de la distribucion de las medianas
sd(medianas) # la desviacion tipica de las medianas
##' 
##' 
##' ### Ventajas de los procedimientos bootstrap 
##'
##' 1. No necesitamos la condición de normalidad en la que se basan las técnicas de inferencia paramétricas.
##' 
##' 2. En la mayoría de casos, la distribución bootstrap de un estadístico tiene aproximadamente la misma forma y dispersión que la distribución del estadístico
##' que se obtiene al seleccionar muchas muestras de la población, pero su centro es el valor que toma el estadístico en la muestra original, en lugar
##' del verdadero valor del parámetro que intentamos estimar.
##' 
##' 3. La técnica bootstrap nos permite calcular el error típico de cualquier estadístico sin necesidad de recurrir a la teoría estadística.
##'<br />
##'<br />
##'<br />
##'
##' ## 2. Cálculo de intervalos de confianza
##' ### 2.1. Intervalos de confianza bootstrap usando t
##' Suponemos que la distribución bootstrap de un estadístico, obtenida  a partir de una muestra aleatoria simple de tamaño n es aproximadamente **normal** y que el **sesgo** es pequeño.
##' El **sesgo** es la diferencia entre el estadístico de interés en la muestra original y el estadístico obtenido a partir de la distribución bootstrat).
##' Un intervalo de confianzan del (1 - alfa)*100% para el parámetro poblacional se obtiene mediante la expresión :
##' 
##' **valor del estadístico +- t(alfa/2, n-1) *Sb**,  donde Sb es el error típico obtenido de la distribución bootstrap.
##' 
##' 
##' ### 2.2. Intervalos de confianza bootstrap basados en percentiles
##' Cuando no se verifica la normalidad no es posible utilizar el procedimiento anterior para el cálculo de los intervalos de confianza bootstrap. Existen otros procedimientos:
##' 
##' El intervalo formado por los percentiles 2.5% y 97.5% de la distribución bootstrap de un estadístico, permiten calcular un intervalo de confianza del 95% para el parámetro poblacional. 
##' utilizaremos este método si la distribución bootstrap presenta un sesgo reducido. 
##' 
##' Continuamos con los 2 ejemplos anteriores. De esta forma obtenemos los intervalos de confianza del 95% de los parámetros poblaciones media y mediana, a partir de la distribución bootstrap:
quantile(medias, c(0.025, 0.975))
quantile(medianas, c(0.025, 0.975))
##' 
##' ### 2.3. Comparación de los intervalos de confianza bootstrap basados en t y  en percentiles
##' - Las condiciones para utilizar estos intervalos no están perfectamente definidas (son muy generales).
##'
##' - Comprueba que los intervalos obtenidos son razonables comparándolos.
##'
##' - Si el sesgo de la distribución bootstrap es pequeño y la distribución es normal, ambos intervalos deberían ser muy similares.
##' 
##' - Los intervalos basados en percentiles son preferibles a los basados en t si la distribución bootstrap no es normal. Son más precisos que los basados en t cuando el sesgo es pequeño.
##' 
##' - Si los intervalos t y los basados en percentiles no coinciden, un buen consejo es no fiarse de ninguno.
##' 
##' ### 2.4. Intervalos de confianza bootstrap más precisos: BCa
##' - Existen métodos más elaborados basados en la técnica de bootstrap que mejoran sustancialmente su fiabilidad al aumentar el tamaño de la muestra. 
##' 
##' - Los intervalos BCa  (bias-corrected accelerated) basados en la técnica de bootstrap son una modificación de los intervalos basados en percentiles que realizan los ajustes necesarios para corregir el sesgo
##'  y la asimetría.
##'  
##'  
##' ### 2.5. Bootstrap en R
##'  Vemos un ejemplo de uso de bootstrap en R: **la media muestral** 
##'  
##'  Cargamos el paquete **boot** en nuestra sesión de R. Incluye algunas funciones de utilidad para el cálculo de la distribución bootstrap:
library(boot) 
##' Generamos una muestra de 50 valores que siguen una distribución normal de media 10 y desviación típica 2:
x = rnorm(50, mean=10, sd=2) 
x # es la muestra original
datos=data.frame(x) # requiere un data.frame
media=function(datos, indices)
{
  d=datos[indices,]
  mean(d)
}
replicas =boot(data=datos, statistic =media, R=5000)
##' Exploramos los elementos que contiene el objeto **replicas** que acabamos de generar:
names(replicas)
##' Vemos como es la distribución bootstrap de la media que hemos obtenido:
hist(replicas$t)
qqnorm(replicas$t, datax=T)
##' Centro de la distribución bootstrap:
mean(replicas$t)
##' Desviación típica de la distribución  bootstrap:
sd( replicas $t)
##' Valor del estadístico en la muestra original:
replicas$t0
##' Calculamos el sesgo:
sesgo=abs(mean(replicas$t)- (replicas$t0))
sesgo
##' **Por último calculamos el intervalo de confianza de la media poblacional** utilizando los 3 métodos comentados anteriormente:
##' 
##' Si la distribución del estadístico es normal y el sesgo pequeño, determinaremos el **intervalo basado en la distribucion t**:
replicas $t0-qt(0.975,df=length(x)-1)*sd(replicas$t)
replicas $t0+qt(0.975,df=length(x)-1)*sd(replicas$t)
##' Si la distribución del estadístico no es normal pero el sesgo es pequeño, usaremos el **intervalo basado en percentiles**:
quantile(replicas$t, c(0.025,0.975))
##' Cuando hay un gran sesgo utilizaremos  el **intervalo BCa**:
boot.ci ( replicas , type="bca")
##'<br />
##'<br />
##'<br />

##' ## 3. Ejercicios
##'<br />
##'<br />
##'<br />

##'
##' ## 4. Bibliografía y enlaces interesantes:
##' 
##' - [Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'
##' - [r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'
##' - Jeffrey R. Harring Andrew S. Zieffler y Jeffrey D. Long. Comparing groups - Randomization and bootstrap methods using R. 1st Ed. JohnWiley y Sons, 2011.
##' - George P. McCabe David S. Moore y Bruce A. Craig. Introduction to the practice of statistics. 7th. New York: W.H. Freeman y Company, 2012.
##' 

##' ----------------------------------------------------------------------------
