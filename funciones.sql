/*Esta función se encarga de obtener el costo total de un material específico del mueble seleccionado,
es una funcion complementaria que ayuda a la funcion principal FeCostoMateriaPrima.
Su objetivo es calcular el precio total de un materiale del mueble seleccionado.
Tiene los siguientes parametros: 
	@id_material: es tipo INT y el id que identifica al material buscado
	@codigo_muelbe es tipo VARCHAR y es el codigo del mueble donde se esta calculando el total de precio del material
Retorna el costo total del material seleccionado*/

ALTER FUNCTION FeCostoUnaMateria(@id_material INT, @codigo_mueble VARCHAR(15))
RETURNS FLOAT
AS
BEGIN
	DECLARE @total FLOAT
	DECLARE @cant_requeridad INT
	DECLARE @costo FLOAT
	DECLARE @rendimiento FLOAT = 2
	DECLARE @id_mueble INT
	
	SELECT @id_mueble = id FROM tmueble 
	WHERE codigo = @codigo_mueble

	SELECT @cant_requeridad = mp.cantidad_necesaria FROM tmateriales_x_muebles AS mp
	WHERE id_material = @id_material
	AND id_mueble = @id_mueble

	SELECT @costo = precio FROM tmaterial
	WHERE id = @id_material

	SET @total = @costo / @rendimiento * @cant_requeridad

	RETURN @total
END

/*Esta funcion se encarga de obtener costo total de materiales de un mueble en especifico,
Su objetivo es calcular el precio total de materiales de un mueble.
Tiene los siguientes parametros:
	@codigo, codigo del mueble donde se esta calculando el precio.
Retorna un valor de tipo float que tiene como resultado el costo total del materiales del mueble
seleccionado.
*/

CREATE FUNCTION FeCostoMateriaPrima(@codigo VARCHAR(15))
RETURNS FLOAT
AS
BEGIN
	DECLARE @total FLOAT

	SELECT @total = SUM(dbo.FeCostoUnaMateria(mn.id_material, @codigo))
							FROM tmateriales_x_muebles AS mn
								INNER JOIN tmaterial AS m
									ON m.id = mn.id_material
								INNER JOIN tmueble AS n
									ON n.id = mn.id_mueble
							WHERE n.codigo= @codigo

	RETURN @total
END

/*Esta funcion se encarga de obtener la informacion de los materiales de un mueble en especifico.
Tiene los siguientes parametros:
	@codigo, valor de tipo VARCHAR	y es el codigo de un mueble que se identifica de los demas muebles.
Retorna una tabla con toda la informacion de los mateariales requeridos del mueble seleccionado*/

CREATE FUNCTION fn_FtMateriaPrima (@codigo VARCHAR(15))
RETURNS TABLE
AS
	RETURN	(SELECT m.codigo AS 'Codigo de material', m.nombre AS 'Nombre del material', mn.cantidad_necesaria AS 'Cantidad necesaria'
					FROM tmaterial AS m
					INNER JOIN tmateriales_x_muebles AS mn
					ON mn.id_material = m.id
					INNER JOIN tmueble AS n
					ON mn.id_mueble = n.id
					WHERE n.codigo = @codigo
					)

/*Esta funcion se encarga de obtener el valor del inventario de un material en especifico,
esta es una funcion complementaria que ayuda a una vista llamada 'vwInventarioMateriaPrima'
Su objetivo es calcular el valor de inventario de un material.
Tiene los siguientes parametros:
	@codigo valor de tipo VARCHAR que identifica un material de los demas materiales.
Retorna el valor del inventario del material seleccionado. */

CREATE FUNCTION fn_calcular_valorInventario (@codigo VARCHAR(15))
RETURNS FLOAT
AS 
	BEGIN
		DECLARE @valor_inventario FLOAT
		DECLARE @precio FLOAT
		DECLARE @cant INT

		SELECT @precio = precio FROM tmaterial 
		WHERE codigo = @codigo

		SELECT @cant = m.unidades_existentes FROM tmaterial AS m
		WHERE codigo = @codigo

		SET @valor_inventario = @precio * @cant

		RETURN @valor_inventario
	END

/*Esta funcion se encarga de obtener la cantidad a pedir de un material en especifico,
esta es una funcion complementaria que ayuda a una vista llamada 'vwInventarioMateriaPrima'
Su objetivo principal es calcular la cantidad a pedir de un material.
Tiene los siguientes parametros:
	@codigo valor de tipo VARCHAR que identifica un material de los demas materiales.
Retorna la cantidad a pedir del material seleccionado*/

CREATE FUNCTION fn_calcular_cant_pedir (@codigo VARCHAR(15))
RETURNS INT
AS
	BEGIN
		DECLARE @cant_maxima INT
		DECLARE @cant_minima INT
		DECLARE @cant_pedir INT

		SELECT @cant_maxima = cantidad_maxima FROM tmaterial
		WHERE codigo = @codigo

		SELECT @cant_minima = cantidad_minima FROM tmaterial
		WHERE codigo = @codigo

		SET @cant_pedir = @cant_maxima - @cant_minima

		RETURN @cant_pedir
	END

/*Esta vista se encarga de ensenar el inventario de los materiales.*/
CREATE VIEW vwInventarioMateriaPrima 
AS
SELECT	m.codigo, m.nombre, m.precio, m.unidades_existentes, 
				dbo.fn_calcular_cant_pedir(m.codigo) AS 'Cantidad a pedir', 
				dbo.fn_calcular_valorInventario(m.codigo) AS 'Valor inventario'
FROM tmaterial AS m
WHERE m.unidades_existentes <= m.cantidad_minima

/*Esta funcion se encarga de obtener la fecha de vencimiento de una factura,
esta es una funcion complementaria que ayuda a una vista llamada 'vwFacturasPendientesCobrar'
Su objetivo es calcular la fecha de vencimiento.
Tiene los siguientes parametros:
	@numero, numero de la factura seleccionada
Retorna la fecha de vencimiento*/
ALTER FUNCTION fn_calcular_fecha_vencimiento (@numero VARCHAR(20))
RETURNS DATE
AS
	BEGIN
		DECLARE @fecha DATE
		DECLARE @plazo DATE
		DECLARE @fecha_vencimiento DATE
		DECLARE @dia INT

		SELECT @fecha = f.fecha FROM tfactura AS f
		WHERE f.numero = @numero

		SELECT @plazo = f.plazo FROM tfactura AS f
		WHERE f.numero = @numero

		IF @plazo > @fecha
			BEGIN
				SET @dia = DATEDIFF(DAY, @fecha, @plazo)
				SET @fecha_vencimiento = DATEADD(DAY, @dia, @fecha)
			END
		ELSE 
			BEGIN
				SET @fecha_vencimiento = @fecha
			END

		RETURN @fecha_vencimiento
	END
	
	
	
	SELECT * FROM vwFacturasPendientesCobrar

/*Esta vista se encarga de ensenar la informacion de las facturas pendientes, si hay realizados
pagos, se muestran los pagos a la factura.*/

ALTER VIEW vwFacturasPendientesCobrar
AS
	SELECT f.numero, c.nombre, dbo.fn_calcular_fecha_vencimiento(f.numero) AS 'Fecha vencimiento', 
					f.monto AS 'Monto factura', f.fecha, fc.tipo, p.numero_documento, p.monto AS 'Monto pago', pc.saldo 
	FROM tfactura_cliente AS fc
		INNER JOIN tfactura AS f
			ON f.id = fc.id_factura
		INNER JOIN tcliente AS c
			ON fc.id_cliente = c.id
		INNER JOIN tpago_cliente AS pc
			ON pc.id_factura_cliente = fc.id
		INNER JOIN tpago AS p
			ON pc.id_pago = p.id
	WHERE f.estado = 'Pendiente'

EXECUTE dbo.PaDescripcionProductos

/*Este procedimiento se encarga de ensenar de mostrar la siguiente informacion:
	codigo del mueble, nombre del mueble, precio costo del mueble, unidades existentes
	del mueble, codigo de la materia prima del mueble, nombre de la materia prima, unidad
	de medicion de la materia prima del mueble, cantidad requeridad de material al mueble,
	costo del material del mueble, tipo de costo del mueble, pago de materiales.
Su objetivo es mostrar toda la informacion de los productos
 (Nota: Se van a mostrar los muebles que tengan registros en todas las tablas seleccionadas.)*/

CREATE PROCEDURE PaDescripcionProductos
	AS
		BEGIN TRY
			BEGIN TRANSACTION
				SELECT n.codigo,  n.nombre, n.precio_costo, n.unidades_existentes, 
								m.codigo, m.nombre, mm.nombre,	 mn.cantidad_necesaria,
								m.precio, pa.monto, pa.tipo
				FROM tmueble AS n
					INNER JOIN tmateriales_x_muebles AS mn
						ON mn.id_mueble = n.id
					INNER JOIN tmaterial AS m
						ON mn.id_material = m.id
					INNER JOIN tmedidas_x_materiales as mmn
						ON mmn.id_material = m.id
					INNER JOIN tmedida AS mm
						ON mm.id = mmn.id_medida
					INNER JOIN tmateriales_x_proveedor AS mp
						ON mp.id_material = m.id
					INNER JOIN tproveedor AS p
						ON mp.id_proveedor = p.id
					INNER JOIN tfactura_proveedor AS fp
						ON fp.id_proveedor = p.id
					INNER JOIN tpago_proveedor AS pp
						ON pp.id_factura_proveedor = fp.id
					INNER JOIN tpago AS pa
						ON pp.id_pago = pa.id
			COMMIT TRANSACTION
		END TRY

		BEGIN CATCH
			PRINT 'No se pudo mostrar la descripcion del producto ' + ERROR_MESSAGE()
			ROLLBACK TRANSACTION
		END CATCH



/*Este procedimiento se encarga de insertar un pago a una factura de 
un cliente.
Su objetivo es registrar el pago de una factura de un cliente.
Tiene los siguientes parametros:
	@numero, numero de la factura que va ser pagada.
	@tipo tipo de pago que realizo el cliente
	@monto monto del pago.
	@documento numero del tipo de pago*/	

ALTER PROCEDURE PaInsertarPagoFacturaCliente
	@numero VARCHAR(20),
	@tipo VARCHAR(10),
	@monto FLOAT,
	@documento VARCHAR(25)
	AS
		BEGIN TRY
			BEGIN TRANSACTION

			DECLARE @id_factura INT 

			SELECT  @id_factura = f.id FROM tfactura AS f
			WHERE f.numero = @numero

			IF (@id_factura = null)
			BEGIN
			DECLARE @estado VARCHAR(11)

			SELECT @estado = f.estado FROM tfactura AS f
			WHERE f.numero = @numero

			IF @estado = 'Pendiente'
				BEGIN
					DECLARE @saldo FLOAT
					DECLARE @id_factura_cliente INT
					DECLARE @fecha DATE
					DECLARE @id_pago INT

					SELECT @saldo = saldo FROM tfactura
					WHERE numero = @numero

					SELECT @id_factura_cliente = fc.id FROM tfactura_cliente AS fc
					WHERE fc.id_factura = @id_factura

					IF @monto <= @saldo
						BEGIN
							SET @fecha = GETDATE()

							INSERT INTO tpago (fecha, tipo, monto, numero_documento)
							VALUES (@fecha, @tipo, @monto, @documento)

							SELECT @id_pago = MAX(p.id) FROM tpago AS p

							INSERT INTO tpago_cliente (id_pago, id_factura_cliente)
							VALUES (@id_pago, @id_factura_cliente)
						END
					ELSE
						BEGIN
							PRINT 'Monto supera al saldo'
						END
				END
			ELSE 
				BEGIN
					PRINT 'La factura esta cancelada'
				END
			END
			ELSE 
			BEGIN
				PRINT 'No se encuentra el numero de la factura'
			END
			COMMIT TRANSACTION
		END TRY

		BEGIN CATCH
			PRINT 'El numero de la factura no existe'
			ROLLBACK TRANSACTION
		END CATCH

SELECT * FROM dbo.fn_FtMateriaPrima ('MU0100')

SELECT * FROM tcategoria
SELECT * FroM tcliente
SELECT * FROM tmedida
SELECT * FROM tproveedor
SELECT * FROM tmaterial
SELECT * FROM tmateriales_x_muebles
SELECT * FROM tmedidas_x_materiales
SELECT * FROM tbitacora
SELECT * FROM tmateriales_x_proveedor
SELECT * FROM tplanes
SELECT * FROM tvale_producccion
SELECT * FROM tmedidas_x_muebles
SELECT * FROM tjuego_muebles
SELECT * FROM tfactura_proveedor
SELECT * FROM tfactura_cliente
SELECT * FROM tfactura
SELECT * FROM tpago
SELECT * FROM tpago_cliente
SELECT * FROM tmuebles_x_planes