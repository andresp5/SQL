

 /*        CONSULTAS EMISIONES CO2 CANADA      */
    
    
    SELECT *
    FROM emisiones.co2_emisiones;

        /* CONSULTA 1
Relación entre el tipo de transmisión consumo y emisiones.
*/

SELECT AVG(Emisiones_CO2)
FROM emisiones.co2_emisiones
WHERE Transmision LIKE 'M%';

SELECT AVG(Emisiones_CO2)
FROM emisiones.co2_emisiones
WHERE Transmision LIKE 'A%';


SELECT AVG(Consumo_mixto)
FROM emisiones.co2_emisiones
WHERE Transmision LIKE 'M%';

SELECT AVG(Consumo_mixto)
FROM emisiones.co2_emisiones
WHERE Transmision LIKE 'A%';

        /* CONSULTA 2
Relación entre tipo de transmisión y consumo de combustible.
*/

SELECT Transmision, Combustible, MAX(consumo_ciudad), MAX(Consumo_mixto)
FROM emisiones.co2_emisiones
GROUP BY Transmision, Combustible
ORDER BY 3 DESC
LIMIT 10;

        /* CONSULTA 3
Relación entre transmisión y emisión de CO2
*/

SELECT DISTINCT Transmision, Combustible, Emisiones_CO2
FROM emisiones.co2_emisiones
WHERE Emisiones_CO2 > (
	SELECT AVG(Emisiones_CO2) 
    FROM emisiones.co2_emisiones
	)
GROUP BY Transmision, Combustible, Emisiones_CO2
ORDER BY 3 DESC
LIMIT 10;

        /* CONSULTA 4
Marca y modelo de los 10 coches que mayor consumo total(carretea,ciudad, mixto) tienen.
*/

SELECT marca, modelo, clase_vehiculo,
		MAX(consumo_carretera), 
        MAX(consumo_ciudad), 
        MAX(consumo_mixto)
FROM emisiones.co2_emisiones
GROUP BY marca, modelo, clase_vehiculo
ORDER BY 5 DESC
LIMIT 10;

        /* CONSULTA 5
Relación entre consumo elevado y alta contaminación
*/

SELECT marca, modelo, MAX(consumo_mixto), MAX(emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY marca, modelo
ORDER BY 4 DESC
LIMIT 10;

        /* CONSULTA 6
Relación entre consumo, contaminación y clase de vehiculo.
*/

SELECT DISTINCT clase_vehiculo, ROUND(AVG(consumo_ciudad),2),
				ROUND(AVG(consumo_carretera),2), 
                ROUND(AVG(consumo_mixto),2), 
                ROUND(AVG(emisiones_CO2),2)
FROM emisiones.co2_emisiones
GROUP BY clase_vehiculo
ORDER BY 5 DESC;


        /* CONSULTA 7
Relación entre contaminación elevada y tamaño de motor.
*/

SELECT marca, modelo, clase_vehiculo,MAX(tamaño_motor), MAX(emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY marca, modelo,clase_vehiculo
ORDER BY 5 DESC
LIMIT 10;


        /* CONSULTA 8
Relación entre contaminación elevada y cantidad de cilindros.
*/

SELECT marca, modelo, clase_vehiculo,MAX(cilindros), MAX(emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY marca, modelo,clase_vehiculo
ORDER BY 5 DESC
LIMIT 10;


        /* CONSULTA 9
Maximos contaminación
*/

SELECT marca, modelo, clase_vehiculo, MAX(emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY marca, modelo,clase_vehiculo
ORDER BY 4 DESC
LIMIT 10;


        /* CONSULTA 10
Marcas que  su media de emisiones está por encima de la media total
*/

SELECT DISTINCT marca, AVG(emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY marca
HAVING AVG(emisiones_CO2) >= (
	SELECT AVG(emisiones_CO2)
    FROM emisiones.co2_emisiones
    )
ORDER BY 2 DESC;


        /* CONSULTA 11
Marcas que  su media de emisiones está por debajo de la media total
*/

SELECT DISTINCT marca, AVG(emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY marca
HAVING AVG(emisiones_CO2) < (
	SELECT AVG(emisiones_CO2)
    FROM emisiones.co2_emisiones
    )
ORDER BY 2 DESC;


        /* CONSULTA 12
Clase de vehiculo que su media de emisiones está por encima de la media total 
*/

SELECT DISTINCT clase_vehiculo, AVG(emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY clase_vehiculo
HAVING AVG(emisiones_CO2) < (
	SELECT AVG(emisiones_CO2)
    FROM emisiones.co2_emisiones
    )
ORDER BY 2 DESC;


        /* CONSULTA 13
Media de emisiones por combustible
*/

SELECT DISTINCT Combustible, AVG(emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY Combustible
ORDER BY 2 DESC;


        /* CONSULTA 14
Media de consumo y emisiones según tipo de combustible
*/

SELECT DISTINCT Combustible,COUNT(Combustible), 
				ROUND(AVG(consumo_ciudad),2), 
                ROUND(AVG(consumo_carretera),2), 
                ROUND(AVG(consumo_mixto),2), 
                ROUND(AVG(emisiones_CO2),2)
FROM emisiones.co2_emisiones
GROUP BY Combustible
ORDER BY 5 DESC;


        /* CONSULTA 15
Marca con menos emisiones y consumo en ciudad
*/

SELECT DISTINCT marca, MIN(Consumo_ciudad), MIN(Emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY marca
ORDER BY 3 ASC
LIMIT 1;

        /* CONSULTA 16
Marca con menos emisiones y consumo en carretera
*/

SELECT DISTINCT marca, MIN(Consumo_carretera), MIN(Emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY marca
ORDER BY 3 ASC
LIMIT 1;


        /* CONSULTA 17
Marca con menos emisiones y consumo mixto
*/

SELECT DISTINCT marca, MIN(Consumo_mixto), MIN(Emisiones_CO2)
FROM emisiones.co2_emisiones
GROUP BY marca
ORDER BY 3 ASC
LIMIT 1;


        /* CONSULTA 18
Numero de vehiculos de cada clase con sus emisiones
*/

SELECT Clase_vehiculo, COUNT(Clase_vehiculo), ROUND(AVG(Emisiones_CO2),2)
	FROM emisiones.co2_emisiones
GROUP BY Clase_vehiculo
ORDER BY 2 DESC;


        /* CONSULTA 19
Relación tamaño motor con el consumo y las emisiones.
*/

SELECT Tamaño_motor, ROUND(AVG(Consumo_mixto),2)
FROM emisiones.co2_emisiones
GROUP BY Tamaño_motor
ORDER BY 2 DESC;

SELECT Tamaño_motor, ROUND(AVG(Emisiones_CO2),2)
FROM emisiones.co2_emisiones
GROUP BY Tamaño_motor
ORDER BY 2 DESC;


        /* CONSULTA 20
Relación numero cilindros con el consumo y las emisiones
*/

SELECT Cilindros, ROUND(AVG(Consumo_mixto),2)
FROM emisiones.co2_emisiones
GROUP BY Cilindros
ORDER BY 2 DESC;

SELECT Cilindros, ROUND(AVG(Emisiones_CO2),2)
FROM emisiones.co2_emisiones
GROUP BY Cilindros
ORDER BY 2 DESC;

        /* CONSULTA 21
Relación combustible con el consumo y las emisiones
*/

SELECT Combustible, ROUND(AVG(Consumo_mixto),2)
FROM emisiones.co2_emisiones
GROUP BY Combustible
ORDER BY 2 DESC;

SELECT Combustible, ROUND(AVG(Emisiones_CO2),2)
FROM emisiones.co2_emisiones
GROUP BY Combustible
ORDER BY 2 DESC;


        /* CONSULTA 22
Dime los coches que su motor y cilindros sea mayores o iguales a la media y que sean manuales 
*/

SELECT Marca, Modelo
FROM emisiones.co2_emisiones
WHERE Tamaño_motor >= (
	SELECT AVG(Tamaño_motor)
    FROM emisiones.co2_emisiones
    WHERE Cilindros >= (
		SELECT AVG(Cilindros)
		FROM emisiones.co2_emisiones
		WHERE Transmision LIKE 'M%'
        ));
