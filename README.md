# Tránsitos Intrusos, el blog de Juan Irigoyen

A comienzos de septiembre de 2024, Juan Gervás hacía oficial el [fallecimiento del sociólogo Juan Irigoyen](https://diario16plus.com/sociedad/obituario/murio-juan-irigoyen-profesor-sociologo-marginado-academico-social-bella-persona-mejor-sociologia-salud_501587_102.html), acontecido el 31 de mayo del mismo año.

Dado el desconcierto existente acerca de la posibilidad de que su blog, ["Tránsitos Intrusos"](http://www.juanirigoyen.es/), pueda desapacecer de la red, he extraído todos los posts del blog y los he almacenado en este repositorio para garantizar su futura preservación. 

Este [enlace](https://github.com/joseluisesna/Transitos_intrusos/blob/main/1_Data_retrieval.R) conduce al código utilizado para realizar el "data scraping".
Los datos mismos, [Irigoyen_blog.RData](https://github.com/joseluisesna/Transitos_intrusos/blob/main/Irigoyen_blog.RData), se encuentran almacenados en formato [R](https://www.r-project.org/).
Dentro de dicho objecto, se pueden encontrar 2 elementos: `all_posts_links` (con todas las URLs en el blog) y `data`. 
Este último elemento es una lista con 802 elementos, correspondientes a las 802 entradas que Juan Irigoyen realizó entre desde diciembre de 2012 hasta mayo de 2024. 
Los elementos están organizados cronológicamente.
