/*EJ-1 OK
En primer lugar, es fundamental conocer los datos que queremos analizar.
Para ellos, vamos a visualizar todos los datos de la tabla.
*/
SELECT *
	FROM ricos.2021ricos;

/*EJ-2 OK
¿De cuántos países diferentes son las personas que se encuentran en la lista?
¿Cuáles son esos países?
*/

SELECT COUNT(DISTINCT Country)
	FROM ricos.2021ricos;

 SELECT DISTINCT Country
	FROM  ricos.2021ricos;


/*EJ-3   OK
¿A qué sectores profesionales pertenecen las personas de la lista?*/

SELECT DISTINCT Industry
	FROM ricos.2021ricos;

/*EJ-4 OK
¿Qué personas componen el TOP10 de las personas más ricas en 2021?
*/

SELECT rango, name
	FROM ricos.2021ricos
 WHERE rango <= 10;

SELECT rango, name, total
	FROM ricos.2021ricos
ORDER BY total DESC
LIMIT 10;

/*EJ-5 OK
¿Cuál es el patrimonio medio de las personas de la lista?
*/

SELECT AVG(total)
	FROM ricos.2021ricos;

/*EJ-6 OK
¿En qué puesto se encuentra Amancio Ortega? ¿Cuál es su patrimonio?
*/

SELECT *
	FROM ricos.2021ricos
  WHERE name = "Amancio Ortega";


/*EJ-7 OK
¿Qué personas se llaman Robert (o Rob…)?
*/

SELECT name
	FROM ricos.2021ricos
  WHERE name like 'Rob%';


/*EJ-8 OK
¿Qué personas tienen un nombre que termina con la letra w? */

SELECT name
	FROM ricos.2021ricos
  WHERE name like '%w';

/*EJ-9 OK
¿Qué personas de España componen la lista?
*/

SELECT country, name
	FROM ricos.2021ricos
  WHERE country like "%Spain%";


/*EJ-10 OK
. Patrimonio medio por sector.*/

SELECT ROUND(AVG(total), 2), industry  # ROUND PARA REDONDEAR LOS DATOS MEDIOS
	FROM ricos.2021ricos
 GROUP BY industry;


/*EJ-11 OK
 TOP5 sectores con mayor patrimonio medio.
*/

SELECT AVG(total)as "Patrimonio medio", industry 
	FROM ricos.2021ricos
 GROUP BY industry 
  ORDER BY AVG(total) DESC  #PUEDES PONER VARIAS OPCIONES EN EL ORDER BY, SI DOS DATOS SON IGUALES, SIGUE ORDENDO CON LA SIGUIENTE CONDICION
    LIMIT 5;

/*EJ-12 OK
Patrimonio total por país y sector, ordenado por país.*/

SELECT ROUND(sum(total), 2), country, industry
	FROM ricos.2021ricos
 GROUP BY country, industry
 order by country;

/*EJ-13 OK
¿Hay laguna persona de China que trabaje en el sector de la tecnología?
*/

SELECT COUNT(name), country, Industry 
	FROM ricos.2021ricos
  WHERE Industry = 'Technology' and country = 'China'
 GROUP BY country, industry; 


/*EJ-14 OK
Patrimonio medio de las personas cuyo nombre empieza por la letra k
agrupado por país*/

SELECT country, ROUND(AVG (total), 2) as "promedio"
	FROM ricos.2021ricos
  WHERE name like 'k%'
GROUP BY country;