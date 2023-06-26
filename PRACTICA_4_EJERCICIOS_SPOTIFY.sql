
    /*        EJERCICIOS SPOTIFY       */
    
    SELECT *
		FROM spotify.sp_artista;
    
	SELECT *
		FROM spotify.sp_artista_estadisticas;
    
    
    
    
        /* EJERCICIO 1

Dime el nombre del artista con mas seguidores.
*/

SELECT a.nombre, e.num_followers 
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
	GROUP BY a.nombre, e.num_followers
    ORDER BY 2 DESC
    LIMIT 1;

        /* EJERCICIO 2
Dime todos los artistas con seguidores por encima de la media
*/

SELECT DISTINCT a.nombre, e.num_followers
	FROM spotify.sp_artista_estadisticas e
	JOIN spotify.sp_artista a
	ON e.artist_id = a.artist_id
  WHERE e.num_followers >= (
		SELECT AVG(num_followers)
        FROM spotify.sp_artista_estadisticas
        );

        /* EJERCICIO 3
Dime el artista mas popular el 21/04/20
*/

SELECT a.nombre
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
  WHERE e.fecha LIKE '21/04/20' AND e.popularity = (
		SELECT MAX(popularity)
        FROM spotify.sp_artista_estadisticas
        );

        /* EJERCICIO 4
Dime el nombre de los artistas que no aparecen el 25/04/20
*/

SELECT nombre
	FROM spotify.sp_artista
  WHERE artist_id NOT IN (
		SELECT artist_id
		FROM spotify.sp_artista_estadisticas
        WHERE fecha LIKE '25/04/20'
        );



        /* EJERCICIO 5
Dime el nombre de los artistas que no aparecen el 24/04/20 y su nombre empieza por "A"
*/

SELECT nombre
	FROM spotify.sp_artista
  WHERE nombre LIKE 'A%' AND artist_id NOT IN (
		SELECT artist_id
		FROM spotify.sp_artista_estadisticas
        WHERE fecha LIKE '24/04/20');
        

        /* EJERCICIO 6
Dime el nombre de los artistas que no están en la tabla estadistica
*/


SELECT nombre
	FROM spotify.sp_artista a
  WHERE NOT EXISTS (
	SELECT artist_id
    FROM spotify.sp_artista_estadisticas e
    WHERE e.artist_id = a.artist_id
    );



        /* EJERCICIO 7
Dime el artista mas popular en cada fecha.
*/

SELECT DISTINCT e.fecha, a.nombre
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id 
   WHERE e.popularity = (
		SELECT MAX(popularity)
		FROM spotify.sp_artista_estadisticas
	);

        /* EJERCICIO 8
Dime los artistas que su media de seguidores es menor a 4500 
*/


SELECT a.nombre, AVG(e.num_followers) AS 'Media Seguidores'
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
    GROUP BY a.nombre
    HAVING AVG(e.num_followers) < 4500
    ORDER BY 2 DESC;
	
    
        /* EJERCICIO 9
Dime los artistas del 23/05, que tienen una popularidad mayor o igual a la media del dia '23/05/20' y la suma de popularidad *200 de la la fecha 24/04.
*/

SELECT a.nombre
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
	WHERE fecha LIKE '23/05/20'AND e.popularity >= (
		SELECT AVG(popularity)
        FROM spotify.sp_artista_estadisticas
        WHERE fecha LIKE '23/05/20'AND num_followers >= (
			SELECT SUM(popularity)* 100
            FROM spotify.sp_artista_estadisticas
            WHERE fecha LIKE '24/04/20'
            ));


        /* EJERCICIO 10
Dime la fecha en la que Ariana Grande alcanzó mayor popularidad y numero de seguidores 
*/

SELECT e.fecha
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
  WHERE a.nombre = 'Ariana Grande' AND e.popularity = (
	SELECT MAX(e.popularity) 
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
    WHERE a.nombre = 'Ariana Grande') AND e.num_followers = (
				SELECT MAX(e.num_followers)
				FROM spotify.sp_artista a
				JOIN spotify.sp_artista_estadisticas e
				ON a.artist_id = e.artist_id
				WHERE a.nombre = 'Ariana Grande');


        /* EJERCICIO 11

Dime cuantos artistas aparecen en mas de 12 fechas
*/

SELECT a.nombre, COUNT(fecha)
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
    GROUP BY a.nombre
	HAVING COUNT(fecha) > 12;
    


        /* EJERCICIO 12

De los artistas que mas dias han estado, dime los 3 que mas seguidores tienen
*/

SELECT a.nombre, COUNT(fecha), MAX(e.num_followers)
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
    GROUP BY a.nombre
	HAVING COUNT(fecha) > 12
    ORDER BY 3 DESC
    LIMIT 3;



        /* EJERCICIO 13
Dime las 5 fechas que menos artistas han tenido.
*/

SELECT e.fecha, COUNT(e.artist_id) AS 'Numero de artistas'
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
    GROUP BY e.fecha
    ORDER BY 2 ASC
    LIMIT 5;


        /* EJERCICIO 14
Dime las 5 fechas con mayor indice de popularidad y seguidores. Ordenado por popularidad
*/

SELECT e.fecha, AVG(e.popularity)AS 'Media popularidad', AVG(e.num_followers) AS 'Media seguidores'
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
    GROUP BY e.fecha
	ORDER BY 2 DESC
    LIMIT 5;

        /* EJERCICIO 15
Dime la media de seguidores que tiene un artista con mas de 90 de popularidad
*/

SELECT AVG(e.num_followers) AS 'Media seguidores'
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
	WHERE e.popularity >= 90;


        /* EJERCICIO 16
Dime el nombre los artistas que tienen una media de popularidad mas alta que la de Coldplay.
*/

SELECT a.nombre, AVG(e.popularity) AS 'Media popularidad'
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
    GROUP BY a.nombre
    HAVING AVG(e.popularity) > (
		SELECT AVG(popularity)
		FROM spotify.sp_artista a
		JOIN spotify.sp_artista_estadisticas e
		ON a.artist_id = e.artist_id
		WHERE a.nombre = 'Coldplay'
		);


        /* EJERCICIO 17
Dime el nombre y los seguidores del artista menos popular 
*/

SELECT a.nombre, e.num_followers, MIN(e.popularity)
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
  GROUP BY a.nombre, e.num_followers
  ORDER BY 3 ASC
  LIMIT 1;

        /* EJERCICIO 18
Dime los nombres de los artistas que empizan por 'Al'
*/

SELECT nombre 
FROM spotify.sp_artista
WHERE artist_id = ANY (
	SELECT artist_id
    FROM spotify.sp_artista_estadisticas
    WHERE nombre LIKE 'Al%'
    );

        /* EJERCICIO 19
Dime le artista menos popular de la fecha 24/04/20
*/

SELECT a.nombre
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
	WHERE fecha LIKE '24/04/20' AND e.artist_id = ( 
		SELECT artist_id
        FROM spotify.sp_artista_estadisticas 
        WHERE popularity = (
			SELECT MIN(popularity)
			FROM spotify.sp_artista_estadisticas
            ));
			


        /* EJERCICIO 20
Dime el artista menos popular con mayor numero de seguidores
*/

SELECT DISTINCT a.nombre, e.popularity, e.num_followers
	FROM spotify.sp_artista a
	JOIN spotify.sp_artista_estadisticas e
	ON a.artist_id = e.artist_id
    WHERE e.popularity = ( 
		SELECT MIN(popularity)
        FROM spotify.sp_artista_estadisticas
        WHERE num_followers = (
			SELECT MAX(num_followers)
            FROM spotify.sp_artista_estadisticas
            ))
	LIMIT 1;
