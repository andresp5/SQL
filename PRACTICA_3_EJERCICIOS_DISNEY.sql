/* EJERCICIOS DISNEY */

SELECT *
FROM disney.credits;

SELECT * 
FROM disney.titles;

/* EJERCICIO 1
Devuelve un listado con todos los directores y el total de peliculas y shows que han hecho cada uno?*/

SELECT c.name, COUNT(t.id) AS "Total peliculas y shows"
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
 WHERE c.role = "DIRECTOR"
 GROUP BY c.name;
 
 /* EJERCICIO 2
A que pelicula pertenece el Id tm74391? Cuales fueron sus directores y en que año se estrenó?
*/

SELECT t.title, t.release_year, c.name
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
  WHERE t.id = 'tm74391'
 GROUP BY t.title, t.release_year, c.name;
 
  /* EJERCICIO 3
   Devuelve un listado con todos los actores y cuantas peliculas ha hecho cada uno.
*/

SELECT c.name, COUNT(t.id) AS "Total peliculas"
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
 WHERE c.role = "ACTOR" AND t.id LIKE "tm%"
 GROUP BY c.name;
 
 
   /* EJERCICIO 4
   Devuelve un listado con los directores que han realizado shows. 
*/

SELECT c.name, COUNT(t.id) AS "Total shows"
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
  WHERE c.role = "DIRECTOR" AND t.id LIKE "ts%"
  GROUP BY c.name;
  
   /* EJERCICIO 5
     Devuelve un listado con los directores que han realizado peliculas entre el 1950 y 1960. Ordenado de menor a mayor por año
*/

SELECT c.name, t.release_year
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
 WHERE c.role = "DIRECTOR" AND t.id LIKE "tm%" 
	AND (t.release_year BETWEEN "1950" AND "1960")
 GROUP BY c.name, t.release_year
 ORDER BY 2 ASC;
  
  
   /* EJERCICIO 6
  Muestra el top 10 de peliculas y su popularidad, ordenado de mayor a menor.
*/

SELECT title, MAX(tmdb_popularity)
  FROM disney.titles
  GROUP BY title
  ORDER BY 2 DESC
  LIMIT 10;
  
   /* EJERCICIO 7
   La media de duracion de las peliculas hechas por el director Hamilton Luske.
*/

SELECT ROUND(AVG(t.runtime),2) AS "Duración media peliculas "
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
  WHERE c.name = "Hamilton Luske" AND t.id LIKE "tm%";
  
   /* EJERCICIO 8
   Dime el numero total de actores que hicieron el show ''Schoolhouse Rock!''.
*/

SELECT COUNT(c.name) AS "Numero de actores"
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
  WHERE t.title = 'Schoolhouse Rock!';
  
  
   /* EJERCICIO 9
   Muestra un listado con todas las ceritificaciones existentes y el número de peliculas que las tienen.
*/

SELECT  DISTINCT age_certification, COUNT(title) AS "Numero películas"
  FROM disney.titles
 GROUP BY age_certification;
  
  
   /* EJERCICIO 10
Lista de mayor a menor las 5 peliculas con mayor numero de votos del 2022.
*/

SELECT title, release_year, MAX(imdb_votes)
  FROM disney.titles
  WHERE release_year LIKE "%2022%" AND id LIKE "tm%" 
 GROUP BY title, release_year
 ORDER BY 3 DESC
 LIMIT 5;
  
   /* EJERCICIO 11
  Listado de todos los actores que tengan un imdb_score mayor de 8.6. 
*/

SELECT c.name, t.imdb_score
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
  WHERE c.role = "ACTOR" AND t.imdb_score > "8.6"
  GROUP BY c.name, t.imdb_score;
  
  
   /* EJERCICIO 12
Los shows con una más de 10 temporadas
*/

SELECT title, type, seasons
  FROM disney.titles
  WHERE seasons > 10 AND id LIKE "ts%"
  GROUP BY title, type, seasons;
  
   /* EJERCICIO 13
  Muestra las peliculas con un tmdb_score superior a 7 en 2022.
*/

SELECT title, release_year, tmdb_score
  FROM disney.titles
  WHERE release_year LIKE "%2022%" AND tmdb_score >= 7
  GROUP BY title, release_year, tmdb_score;

  
   /* EJERCICIO 14
Devuelve los años en los que la media de puntucación(imdb_score) es inferior 7.6.
*/

SELECT release_year, round(AVG(imdb_score),2) AS "Media puntuación"
  FROM disney.titles
  GROUP BY release_year
  HAVING AVG(imdb_score) < 7.6;

  
   /* EJERCICIO 15
Devuelve los años que se han realizado mas de 15 peliculas.
*/

SELECT release_year, COUNT(type) AS "Número de peliculas"
  FROM disney.titles
  WHERE type = "MOVIE"
  GROUP BY release_year
  HAVING COUNT(type) > 15;
  
   /* EJERCICIO 16
   Devuelve los actores que han realizado al menos 15 peliculas
*/

SELECT c.name, COUNT(t.id) AS "Total peliculas"
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
 WHERE c.role = "ACTOR" AND t.type = "MOVIE"
 GROUP BY c.name
 HAVING COUNT(t.id) >= 15;
  
  
   /* EJERCICIO 17
   Devuelve los directores y peliculas para mayores de 13 años. Ordenados por año de mayor a menor
*/

SELECT c.name, t.title, t.release_year
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
  WHERE t.age_certification = 'PG-13' AND c.role = "DIRECTOR" AND t.type = "MOVIE"
  ORDER BY 3 DESC;
  
  
  
   /* EJERCICIO 18
   Listar la media anual de popularidad de todas las peliculas. Devolver solo las que el valor sea mayor que 61.
*/

SELECT release_year, ROUND(AVG(tmdb_popularity),2) AS "Media popularidad"
  FROM disney.titles
 WHERE type = "MOVIE"
  GROUP BY release_year
  HAVING ROUND(AVG(tmdb_popularity),2) > 61;
 
    /* EJERCICIO 19 
Devuelve todos los shows con una media votos superior a 50000.
*/

SELECT title, AVG(imdb_votes) AS "Media de votos"
  FROM disney.titles
  WHERE type = "SHOW"
GROUP BY title
HAVING AVG(imdb_votes) > 50000;
  
     /* EJERCICIO 20
Devuelve las peliculas de Carrie Fisher  junto con su popularidad, año y puntuación
*/

SELECT t.title, t.imdb_score, t.tmdb_popularity, t.release_year
  FROM disney.credits c
  JOIN disney.titles t
  ON c.id = t.id
  WHERE c.name = "Carrie Fisher"
  ORDER BY t.title, t.imdb_score, t.tmdb_popularity, t.release_year;
  
  