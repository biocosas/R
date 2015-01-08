##' # Inferencia de medias con R 
##' [Francisco García García](http://bioinfo.cipf.es/ "webpage of department") _(2014-12-01)_  
##'
##' 
##' 
##' ----------------------------------------------------------------------------

##' ### 0. Introducción 
##' ### 1. Intervalo de confianza de una media poblacional  
##' ### 2. Test t  para una media poblacional
##' ### 3. Intervalo de confianza de la diferencia de dos medias poblacionales
##' ### 4. Test t para dos medias poblacionales 
##' ### 5. Pruebas no paramétricas: Wilcoxon 
##' ### 6. Ejercicios
##' ### 7. Bibliografía
##' ----------------------------------------------------------------------------

##'<br />
##'<br />
##'<br />
  

##' ## 0. Introducción 
##' Los **procedimientos t** son pruebas **paramétricas** que permiten realizar inferencia a partir de 1 ó 2 muestras:
##' - Nos proporcionan **intervalos de confianza** de una media poblacional  o bien la media de la diferencia de 2 medias poblaciones.
##' - También incluyen los **contrastes de hipótesis de comparación de medias**.
##' 
##' Cuando no se verifica la **normalidad** en la variable respuesta, es aconsejable el uso de una prueba no paramétrica: **Wilcoxon**, cuyas 
##' hipótesis nula y alternativa no se basan en el parámetro de la  **media** sino en la **mediana**.
##' 
##'<br />
##'<br />
##'
##' ## 1. Intervalo de confianza de una media poblacional 
##' 
##' Comenzamos leyendo la base de datos **riesgos**:
datos <- read.csv("riesgos.csv", header = T, sep = "\t")
##' Echamos un vistazo a la estructura de los datos:
str(datos)
head(datos)
tail(datos)
##' Con la función **attach** hacemos accesible la base de datos seleccionada:
attach(datos) 
##' Describimos la variable **peso** en nuestra muestra:
summary(peso)
boxplot(peso, col="pink", main ="Peso")
##' _¿Cómo determinamos un intervalo de confianza del 95% para la media poblacional del salario?_
t.test(peso, conf.level = 0.95)$conf.int 
##' ¿Los datos deben cumplir algún requisito para poder obtener el intervalo de confianza anterior?
##' 
##' Redondea el intervalo de confianza a dos decimales:
round(t.test(peso, conf.level = 0.95)$conf.int,2) 
##'<br />
##'<br />
##' 
##' ## 2. Test t  para una media poblacional 
##' La base de datos **riesgos.csv** es una muestra aleatoria de la población de trabajadores de un centro hospitalario de Valencia.
##' 
##' Se ha publicado un informe donde se indica que la media de la talla de todos los trabajadores en la Comunidad Valenciana es de 160 cm.
##' Sin embargo, nosotros creemos que no es cierto y por ello nos gustaría utilizar los datos de nuestro estudio. Realizaremos 
##' los siguientes pasos: 
##' 1. Describimos la variable **talla** de forma numérica y gráfica.
boxplot(talla, col = "red", main = "talla en población de trabjadores")
hist(talla)
##' 2. Plantea el contraste de hipótesis correspondiente. ¿Dos colas o una sola?
##' 
##' 3. Resuelve el contraste  en R considerando un nivel de significación de 0.05:
t.test(peso, mu = 160, alt = "two.sided", conf.level = 0.95)
##'<br />
##'<br />

##' ## 3. Intervalo de confianza de la diferencia de dos medias poblacionales
##' 
##' Sospechamos que la **edad** de las personas que tienen **exposición a carga física** es menor que la edad de las personas no expuestas a
##' este riesgo. Nos gustaría obtener un intervalo de confianza de la diferencia de estas medias:
##' 
##' Primero exploramos la muestra:
mean(edad[carfisi == "sí"])
mean(edad[carfisi == "no"])
plot(edad ~ carfisi, col = c("red", "green"))
mean(edad[carfisi == "sí"]) - mean(edad[carfisi == "no"])
##' A partir de los datos de la muestra, ¿crees que hay diferencia de edad entre ambos grupos?
##' 
##' Determinamos el intervalo de confianza del 95% para la diferencia de estas dos medias:
t.test(edad ~ carfisi, data = datos, conf.level = 0.95)$conf.int 
## Otra opción para obtener el mismo intervalo de confianza:
grupo1 <- edad[carfisi == "no"]
grupo2 <- edad[carfisi == "sí"]
t.test(grupo1, grupo2, conf.level = 0.95)$conf.int 
##' ¿El valor 0 está incluido en este intervalo de confianza? ¿Qué significa esto?
##'<br />
##'<br />

##' ## 4. Test t para dos medias poblacionales  
##' 
##' En ocasiones nos gustaría comparar  dos poblaciones. Una opción sería comparar las **medias** de ambos grupos pero
##' antes debemos tener claro si las muestras son **relacionadas** o **independientes**. Comenta un ejemplo de cada tipo.
##' 
##' ¿Hay diferencias de **peso** entre las personas que tienen **carga psíquica** y las que no están expuestas?
##' 
##' Vemos que ocurre en nuestra muestra:
summary(peso[carpsiqui == "sí"]) 
summary(peso[carpsiqui == "no"]) 
boxplot(peso ~ carpsiqui,  col= c("pink", "red"), main = "peso vs. carga psíquica")
##' Con esta información, ¿crees que hay diferencias entre ambos grupos? Comprueba si estas diferencias estadísticamente
##' son estadísticamente significativas mediante la utilización del correspondiente test estadístico.
##' t de comparación de 2 medias:
t.test(peso ~ carpsiqui, data = datos, conf.level = 0.95) 
##' Comenta los resultados obtenidos.
##'<br />
##'<br />

##' ## 5. Pruebas no paramétricas: Wilcoxon  
##' Los procedimientos t exigen el cumplimiento de normalidad de la variable de estudio. 
##' Sin embargo, si no se verifican los requisitos exigidos, no será aconsejable el uso de estas pruebas paramétricas y
##' utilizaremos procedimientos no paramétricos, que no suelen exigir ningún requerimiento a nuestros datos. 
##' 
##' El test de **Wilcoxon** es una opción no paramétrica que nos permite comparar dos poblaciones.
##' 
##' Vamos a evaluar si hay diferencias de **peso** entre las personas que presentan exposición a  **carga física**
##'  y las que no están expuestas, utilizando el **test de Wilcoxon**:
##' 
summary(peso[carfisi == "sí"]) 
summary(peso[carfisi == "no"]) 
boxplot(peso ~ carfisi,  col= c("blue", "red"), main = "peso vs. carga psíquica")
wilcox.test(peso ~ carfisi, data = datos, paired = F)
##' - Comenta cuáles son las hipótesis nula y alternativa del contraste.  
##' - ¿Qué información nos proporciona el estadístico de contraste?
##' - ¿Qué nos indica el p-valor?
##' - ¿Qué podemos concluir en el contexto del problema?
##' 
##' 
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
##' - **B**. Describe la variable sueldo. ¿Parece una distribución normal?. Determina un intervalo de confianza del 90% para la media 
##' poblacional del sueldo de los trabajadores.
##' - **C**. Hace unos años se publicó un informe donde se indicaba que el colectivo de estos trabajadores presentaba una media del nivel de
##' estrés de 5 puntos, aunque tenemos nuestras dudas.... Plantea un contraste de hipótesis sobre la media poblacional del nivel de estrés
##' y considerando la información de nuestra muestra, resuelve el contraste en R.  ¿Qué conclusiones obtenemos?
##' - **D**. ¿Hay diferencias de sueldo por género? Primero explora gráfica y numéricamente qué nos dice nuestra muestra respecto esta 
##' relación del sueldo y género. A continuación plantea el contraste correspondiente, resuélvelo con R y comenta los resultados obtenidos
##' - **E**. La variable _carga física_ NO  se distribuye como una variable normal. Nos gustaría confirmar si hay diferencias entre la
##' exposición de _carga física_ entre hombres y mujeres. ¿Qué procedimiento estadístico podríamos utilizar? Indica cuál es la hipótesis 
##' nula y la alternativa. Resuélve el contrate utilizando R y comenta los resultados obtenidos. 
##'<br />
##'<br />

##'
##' ## 7. Bibliografía y enlaces interesantes:
##' 
##' - [David S. Moore. Estadística aplicada básica. Editorial Antoni Bosch.]  (http://www.antonibosch.com/system/downloads/487/original/EC-MOORE2_Contenido.pdf?1358332517)  Manual de Estadística Básica.
##' 

##' - [Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'

##' - [r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'

##' ----------------------------------------------------------------------------
