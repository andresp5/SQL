/*EJ-1
Devuelve  un  listado  con  el  código  de  oficina  y  la  ciudad  donde  hay 
oficinas*/

SELECT codigo_oficina, ciudad
	FROM jardineria.oficina;
    
/*EJ-2
Devuelve  un  listado  con  la  ciudad  y  el  teléfono  de  las  oficinas  de 
España. */

SELECT ciudad, telefono, pais
	FROM jardineria.oficina
  WHERE pais = "España";
  
/*EJ-3
Devuelve un listado con el nombre, apellidos y email de los empleados 
cuyo jefe tiene un código de jefe igual a 7 */
  
  SELECT nombre, apellido1, apellido2, email, codigo_jefe
	FROM jardineria.empleado
  WHERE codigo_jefe = 7;

/*EJ-4
Devuelve el nombre del puesto, nombre, apellidos y email del jefe de 
la empresa.  */  

  SELECT puesto, nombre, apellido1, apellido2, email
	FROM jardineria.empleado
  WHERE puesto = "Director General";
  
SELECT puesto, nombre, apellido1, apellido2, email
	FROM jardineria.empleado
  WHERE codigo_jefe IS NULL; /*Buscar celdas vacias*/
  
/*EJ-5
Devuelve  un  listado  con  el  nombre,  apellidos  y  puesto  de  aquellos 
empleados que no sean representantes de ventas.   */

  SELECT nombre, apellido1, apellido2, puesto
	FROM jardineria.empleado
  WHERE NOT puesto = "Representante Ventas";
  
/*EJ-6
Devuelve un listado con el nombre de los todos los clientes españoles.*/

  SELECT nombre_cliente, pais
	FROM jardineria.cliente
  WHERE pais = "Spain";

/*EJ-7
Devuelve un listado con los distintos estados por los que puede pasar 
un pedido*/  

SELECT DISTINCT estado
	FROM jardineria.pedido;

/*EJ-8
Devuelve un listado con el código de cliente de aquellos clientes que 
realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar 
aquellos  códigos  de  cliente  que  aparezcan  repetidos.  Resuelva  la 
consulta: 
• Utilizando la función YEAR de MySQL. 
• Utilizando la función DATE_FORMAT de MySQL. 
• Sin utilizar ninguna de las funciones anteriores. */ 

SELECT  DISTINCT codigo_cliente
	FROM jardineria.pago
 WHERE YEAR(fecha_pago) = 2008;
  
SELECT DISTINCT codigo_cliente
	FROM jardineria.pago
  WHERE DATE_FORMAT(fecha_pago, '%Y') = 2008;

SELECT DISTINCT codigo_cliente
	FROM jardineria.pago
  WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';
  
/*EJ-9
Devuelve un listado con el código de pedido, código de cliente, fecha 
esperada y fecha de entrega de los pedidos que no han sido 
entregados a tiempo. */ 

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
	FROM jardineria.pedido
  WHERE fecha_entrega > fecha_esperada;

/*EJ-10
. Devuelve un listado con el código de pedido, código de cliente, fecha 
esperada y fecha de entrega de los pedidos cuya fecha de entrega ha 
sido al menos dos días antes de la fecha esperada.
• Utilizando la función ADDDATE de MySQL.
• Utilizando la función DATEDIFF de MySQL.
*/

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
	FROM jardineria.pedido
  WHERE DATE_ADD(fecha_esperada, interval -2 day) >= fecha_entrega;

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
	FROM jardineria.pedido
  WHERE fecha_entrega <= ADDDATE(fecha_esperada, -2);
  
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
	FROM jardineria.pedido
 WHERE DATEDIFF (fecha_esperada, fecha_entrega) >= 2;

/*EJ-11
 Devuelve un listado de todos los pedidos que 
fueron rechazados en 2009.*/

SELECT codigo_pedido, estado, fecha_entrega
	FROM jardineria.pedido
 WHERE YEAR(fecha_entrega) = 2009 AND estado = 'Rechazado';
  
/*EJ-12
 Devuelve un listado de todos los pedidos que han sido entregados en 
el mes de enero de cualquier año.*/

SELECT codigo_pedido, estado, fecha_entrega
	FROM jardineria.pedido
 WHERE MONTH(fecha_entrega) = 01 AND estado = 'Entregado';
  
/*EJ-13
 Devuelve un listado con todos los pagos que se realizaron en el 
año 2008 mediante Paypal. Ordene el resultado de mayor a menor.*/
 
SELECT id_transaccion, fecha_pago, forma_pago, total
	FROM jardineria.pago
   WHERE YEAR(fecha_pago) = 2008 AND forma_pago = "PayPal"
  ORDER BY total DESC;

/*EJ-14
 Devuelve un listado con todas las formas de pago que aparecen en la 
tabla pago. Tenga en cuenta que no deben aparecer formas de pago 
repetidas.*/

SELECT DISTINCT forma_pago
	FROM jardineria.pago;

/*EJ-15
 Devuelve un listado con todos los productos que pertenecen a la 
gama Ornamentales y que tienen más de 100 unidades en stock. El 
listado deberá estar ordenado por su precio de venta, mostrando en 
primer lugar los de mayor precio*/
  
SELECT nombre, gama, cantidad_en_stock
	FROM jardineria.producto
  WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100
  ORDER BY precio_venta DESC; 

/*EJ-16
Devuelve un listado con todos los clientes que sean de la ciudad 
de Madrid y cuyo representante de ventas tenga el código de 
empleado 11 o 30. */

SELECT nombre_cliente, ciudad, codigo_empleado_rep_ventas
	FROM jardineria.cliente
  WHERE ciudad = "Madrid" AND codigo_empleado_rep_ventas = "11" OR 
  codigo_empleado_rep_ventas ="30";