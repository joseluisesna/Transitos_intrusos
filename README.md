# "Tránsitos Intrusos", el blog de Juan Irigoyen

A comienzos de septiembre de 2024, Juan Gervás hizo oficial el [fallecimiento del sociólogo Juan Irigoyen](https://diario16plus.com/sociedad/obituario/murio-juan-irigoyen-profesor-sociologo-marginado-academico-social-bella-persona-mejor-sociologia-salud_501587_102.html), acontecido el 31 de mayo del mismo año.

Dado el desconcierto existente acerca de la posibilidad de que su blog, ["Tránsitos Intrusos"](http://www.juanirigoyen.es/), pueda desaparecer de la red, he extraído todas las publicaciones y las he almacenado en este repositorio para garantizar su futura preservación.

Este [enlace](https://github.com/joseluisesna/Transitos_intrusos/blob/main/1_Data_retrieval.R) conduce al código utilizado para realizar el "data scraping".
El blog mismo puede ser descargardo directamente aquí: [exported_posts.7z ](https://github.com/joseluisesna/Transitos_intrusos/blob/main/exported_posts.7z).
Este archivo contiene 802 textos en formato .txt, correspondientes a las 802 entradas que Juan Irigoyen realizó desde diciembre de 2012 hasta mayo de 2024, organizadas cronológicamente.

Ocasionalmente, Juan Irigoyen incluye imágenes y vídeos en sus publicaciones.
- Los enlaces a vídeos han sido incluidos al final de cada texto y, si continúan activos, pueden ser accedidos utilizando un navegador.
- Del mismo modo, los enlaces a imágenes también se indican al final de cada texto. En este caso, las imágenes han sido almacenadas en subcarpetas, indicando el post al que corresponden. Para la fecha de la extracción (3 de enero de 2025), no obstante, algunas imágenes se encontraban inaccesibles, como se indica más abajo.

```
Warning messages:
1: In download.file(img_url, img_file, mode = "wb") :
  downloaded length 0 != reported length 250
2: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://www.eduforics.com:443/wp-content/uploads/2018/07/9789871622535-196x304.jpg': HTTP status was '404 Not Found'
3: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i1.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSim_portada-e1597305430369.jpg?resize=634%2C419&ssl=1': HTTP status was '404 Not Found'
4: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i1.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSims_room.jpg?resize=600%2C435&ssl=1': HTTP status was '404 Not Found'
5: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i2.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSims_Famicom.jpg?w=600&ssl=1': HTTP status was '404 Not Found'
6: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i2.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSims_tokimemo.jpg?resize=600%2C338&ssl=1': HTTP status was '404 Not Found'
7: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i2.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSims_HisashiEguchi.jpg?resize=600%2C920&ssl=1': HTTP status was '404 Not Found'
8: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i0.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSims_SakuraWars.jpg?resize=600%2C338&ssl=1': HTTP status was '404 Not Found'
9: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i1.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSims_Persona5.jpg?resize=600%2C338&ssl=1': HTTP status was '404 Not Found'
10: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i0.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSims_TokimemoGirls.jpg?resize=600%2C285&ssl=1': HTTP status was '404 Not Found'
11: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i0.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSims_LovePlus.jpg?resize=600%2C375&ssl=1': HTTP status was '404 Not Found'
12: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i0.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSims_Atami.jpg?w=600&ssl=1': HTTP status was '404 Not Found'
13: In download.file(img_url, img_file, mode = "wb") :
  cannot open URL 'https://i2.wp.com/www.caninomag.es/wp-content/uploads/2020/08/CANINO_DatingSims_Judgment.jpeg?resize=600%2C338&ssl=1': HTTP status was '404 Not Found'
```
