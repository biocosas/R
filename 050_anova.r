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
##' ### 5. Ejercicios
##' ### 6. Bibliografía y enlaces de interés
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



##' ## 5. Ejercicios
##' 
##' ### 5.1. Relaciones sexuales entre universitarios
##' El departamento de Psicología de una Universidad de Castilla-La Mancha ha realizado
##' un estudio sobre hábitos, preferencias y satisfacción sexual en estudiantes universitarios.
##' Hemos utilizado los datos que recogieron en sus encuestas y queremos
##' conocer si existen diferencias entre la frecuencia mensual de relaciones sexuales de
##' estudiantes universitarios pertenecientes a tres titulaciones universitarias diferentes:
##' 
##' **T1**: 11 14  7 15 11 13 11 16 10 15 18 12  9  9 10 10 15 10 14 10 10 12 14 12 15  7 13  6 10 15 20 10 13 10  6 14  8 10  8 11
##' 
##' **T2**: 13 10 12  7  5 10 10 16  9  7  7  2  6  9  9  8  8 10  3  6  5  2  9  3  4  5 10  8  5  9 10  8 13 10  0  2  1  1  0  4
##' 
##' **T3**: 6  7  3  5  9  6  1  6  0  2  5  6 11  6  7  0  5  7  5  4  7  4  2  8  9  6  1  4  7  7  8  9  7  5  1  6  9  4  7  6
##' 
##'<br />
##'
##' **Contesta las siguientes preguntas**:
##' 
##' **A**. Introduce los datos en R creando las 2 variables: una que incluya las frecuencias de actividad sexual y otra que será un factor, que 
##' nos proporcionará información sobre la titulación universitaria de cada uno de los estudiantes.
##' 
##' **B**. Explora los datos de la muestra mediante gráficos y descriptivos. ¿Observamos diferencias en los valores promedios y de variabilidad por grupos?
##' 
##' **C**. Realiza un test F (ANOVA) para comparar las medias de las 3 poblaciones. ¿Cuáles serían las hipótesis nula y alternativa?
##' 
##' **D**. Describe los resultados obtenidos indicando quién es el valor del estadístico de contraste (F), los grados de libertad del factor, 
##' los grados de libertad residuales y el valor de P.
##' 
##' **E**. También indica quién sería el valor crítico de F bajo la hipótesis nula, que nos proporcionará la definición de una región de 
##' aceptación y rechazo (consideramos un nivel de significación alfa = 0.05). 
##' 
##' **F**. ¿Qué valor obtenemos para la estimación de la varianza común de los datos?
##' 
##' **G**. Tras evaluar la tabla ANOVA, ¿cuál sería tu conclusión en el contexto del problema?
##' 
##' **H**. Determina los intervalos de confianza para las medias de frecuencia sexual en cada uno de las titulaciones descritas.
##' 
##' **I**. Si se han obtenido diferencias significativas entre los grupos, determina dónde se muestran esas diferencias utilizando el test HSD de Tukey.
##' Representa gráficamente las diferencias encontradas e intrepreta los resultados obtenidos.    
##' 
##' **J**.  A partir de los residuos obtenidos y mediante procedimientos gráficos, confirma la validez del modelo comprobando el cumplimiento de las 3 condiciones asumidas al hacer
##' el ANOVA.  ¿Crees que el modelo ANOVA utilizado es válido para estos datos?    
##' 
##' **K**.  Si NO se verificaran estas condiciones, ¿hay alguna prueba no paramétrica para abordar los datos? Pruébalo y 
##' comenta los resultados obtenidos.
##' 
##'<br />
##'<br />
##' ### 5.2. ¿Hay diferencias de salario en función del lugar de trabajo?
##' Nos gustaría saber si el salario varía  en alguna de las 3 provincias de la Comunidad Valenciana. 
##'  Para ello, se realizó un estudio con 50 personas por provincia a las que se preguntó su salario  en euros por semana. 
##' 
##' **Valencia** 299 313 300 321 308 312 300 310 281 308 309 300 303 303 311 308 291 298 276 290 310 308 295 310 286 295 289 293 291 297 297 287 297 302 298 301 313 290 306 313 294 308 295 303 316 299 313 296 290 299
##' 
##' **Castellón**:  252 248 232 229 256 233 240 237 248 232 230 246 236 250 238 243 245 241 235 249 238 231 230 239 261 243 242 245 249 258 245 236 244 242 229 246 244 244 255 247 236 252 237 259 248 237 236 252 236 239
##'
##' **Alicante**: 272 268 285 274 278 287 297 275 269 281 270 284 282 281 280 286 265 283 281 272 269 286 268 288 284 282 304 280 283 281 281 286 287 288 278 272 268 287 269 272 270 271 291 265 280 280 275 294 269 277
##' 
##'<br />
##'
##' **Contesta las siguientes preguntas**:
##' 
##' **A**. Introduce los datos en R creando las 2 variables: una que incluya los salarios y otra que será un factor, que 
##' nos proporcionará información sobre la provincia donde trabajando los sujetos.
##' 
##' **B**. Explora los datos de la muestra mediante gráficos y descriptivos. 
##' ¿Observamos diferencias en los valores promedios y de variabilidad por grupos?
##' 
##' **C**. Realiza un test F (ANOVA) para comparar las medias de las 3 poblaciones. ¿Cuáles serían las hipótesis nula y alternativa?
##' 
##' **D**. Describe los resultados obtenidos indicando quién es el valor del estadístico de contraste (F), los grados de libertad del factor, 
##' los grados de libertad residuales y el valor de P.
##' 
##' **E**. También indica quién sería el valor crítico de F bajo la hipótesis nula, que nos proporcionará la definición de una región de 
##' aceptación y rechazo (consideramos un nivel de significación alfa = 0.05). 
##' 
##' **F**. ¿Qué valor obtenemos para la estimación de la varianza común de los datos?
##' 
##' **G**. Tras evaluar la tabla ANOVA, ¿cuál sería tu conclusión en el contexto del problema?
##' 
##' **H**. Determina los intervalos de confianza para las medias de salario  en cada una de las provincias  descritas.
##' 
##' **I**. Si se han obtenido diferencias significativas entre los grupos, determina dónde se muestran esas diferencias utilizando el test HSD de Tukey.
##' Representa gráficamente las diferencias encontradas e intrepreta los resultados obtenidos.    
##' 
##' **J**.  A partir de los residuos obtenidos y mediante procedimientos gráficos, confirma la validez del modelo comprobando el cumplimiento de las 3 condiciones asumidas al hacer
##' el ANOVA.  ¿Crees que el modelo ANOVA utilizado es válido para estos datos?    
##' 
##' **K**.  Si NO se verificaran estas condiciones, ¿hay alguna prueba no paramétrica para abordar los datos? Pruébalo y 
##' comenta los resultados obtenidos.
##' 
##'<br />
##'<br />
##'<br />
##'
##' ## 6. Bibliografía y enlaces de interés:
##' 
##' - [David S. Moore. Estadística aplicada básica. Editorial Antoni Bosch.]  (http://www.antonibosch.com/system/downloads/487/original/EC-MOORE2_Contenido.pdf?1358332517)  Manual de Estadística Básica.
##' 

##' - [Quick-R] (http://www.statmethods.net/)   Web con recursos para trabajar con R.
##'

##' - [r-tutor] (http://www.r-tutor.com/)  An R Introduction to Statistics.
##'

##' ----------------------------------------------------------------------------
