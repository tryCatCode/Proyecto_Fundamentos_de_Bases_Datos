INSERT INTO tcategoria (codigo, nombre, estado)
VALUES	('MAD-010', 'Madera' , 'Activo'),
				('PID-016', 'Piedra' , 'Activo'),
				('MET-012', 'Metal' , 'Activo'),
				('VID-019', 'Vidrio' , 'Activo'),
				('ACE-1121', 'Acero' , 'Activo'),
				('CEE2-01', 'Ceramica' , 'Activo'),
				('PLLA2-01', 'Plastico' , 'Activo')

GO

INSERT INTO tcliente (cedula, nombre, direccion_exacta, telefono, monto_credito, descuento)
VALUES	('117180829', 'Christian' , 'San jose, desamparados, san miguel' , '87590809', 0, 0),
				('125451717', 'Esteban' , 'San jose, desamparados, centro' , '85471209', 0, 0),
				('117800255', 'Daniela' , 'San jose, pavas, lomas' , '87402210', 0, 0),
				('468746887', 'Pedro' , 'San jose, desamparados, centro' , '85471209', 0, 0)

GO
INSERT INTO tplanes (numero, fecha_inicio, fecha_fin)
VALUES	('120254', '2018-04-04', '2018-04-28'),
				('287940', '2018-03-02', '2018-03-30'),
				('986401', '2018-02-06', '2018-02-26'),
				('548785', '2018-05-04', '2018-05-28'),
				('88754', '2018-06-04', '2018-06-28'),
				('544', '2018-01-04', '2018-01-28'), 
				('120257', '2018-04-04', '2018-04-28')

GO
INSERT INTO tmedida	(codigo, nombre, simbolo)
VALUES	('01', 'Gramo' ,'g'),
				('02', 'Litro' ,'l'),
				('07', 'Kilolitros' ,'kl'),
				('08', 'Mililitros' ,'ml'),
				('00', 'Kilogramos' ,'km'),
				('04', 'Milimetro' ,'mm'),
				('05', 'Centimetro' ,'cm'),
				('06', 'Kilometro' ,'km'),
				('10', 'Miligramo' ,'mg')

GO
INSERT INTO tmueble (codigo, nombre, descripcion, precio_costo, precio_venta, unidades_existentes)
VALUES	('MU0100', 'Mesa' , 'tabla lisa que es sostenida por una o más patas', 50000, 65000, 100),
				('SIA0101', 'Silla' , 'cuatro patas, cuya finalidad es la de servir de asiento a una persona', 3500, 4500, 500),
				('KAM0987', 'Cama', 'mueble que tradicionalmente se emplea para dormir o descansar', 75000, 100000, 50),
				('SII01254', 'Sillon', 'mueble utilizado para dormir y sentarse confortablemente más de una persona', 55000, 60000, 50),
				('SPE255', 'Espejo', 'es una superficie pulida en la que, después de incidir, la luz se refleja siguiendo las leyes de la reflexión', 25000, 25000, 50),
				('FRE5477', 'Fregadero', 'pila de fregar y fregador​ es el recipiente usado para lavar la vajilla', 75000, 100000, 25)

GO
INSERT INTO tproveedor	(cedula, nombre, direccion_exacta, telefono, plazo_credito)
VALUES ('16802646530', 'Madera SA' , 'San Jose, santa pedro', 87451036, '2018-04-28'),
				('14231434484', 'Metal SA' , 'San Jose, santa marta', 84101210, '2018-04-28'),
				('58461354851', 'Piedra SA' , 'San Jose, santa ana', 89635241, '2018-04-28'),
				('20121450015', 'Vidrio SA' , 'San Jose, santa ana', 75301244, '2018-04-28'),
				('64534645346', 'Acero SA' , 'San Jose, santa ana', 71024245, '2018-04-28')

GO
INSERT INTO tjuego_muebles (nombre)
VALUES	('Juego de sillas'),
				('Juego de sillas con mesa'),
				('Juego de sofas')

GO
INSERT INTO tpago (fecha, tipo, monto, numero_documento) 
VALUES	('2018-04-23', 'Efectivo', 66000, '01'),
				('2018-04-20', 'Cheque', 116000, '03'),
				('2018-04-10', 'Transferencia', 26000, '02')

GO
INSERT INTO tfactura(numero, fecha, monto, saldo, plazo, estado)
VALUES	('01', '2018-04-23', 76000, 66000, '2018-04-28', 'Pendiente'),
				('02', '2018-04-20', 116000, 116000, '2018-04-28', 'Pendiente'),
				('31', '2018-04-10', 36000, 26000, '2018-04-28', 'Cancelado'),
				('290811', '2018-04-25', 10000, 10000, '2018-04-28', 'Pendiente')

GO
INSERT INTO tmaterial (codigo, nombre, precio, unidades_existentes, cantidad_maxima, cantidad_minima, estado, id_categoria)
VALUES	('C01', 'Clavos de acero', 550, 100, 500, 10, 'Activo', 5),
				('M-01', 'Madera de Laurel', 2500, 25, 100, 10, 'Activo', 1),
				('M02', 'Madera', 10000, 5, 50, 5, 'Activo', 1),
				('ME-01', 'Metal', 20000, 22, 50, 5, 'Activo', 3),
				('PLL-M01', 'Plastico', 5000, 55, 100, 5, 'Activo', 7),
				('VII-01', 'Vidrio', 5000, 55, 100, 5, 'Activo', 4)

GO
INSERT INTO tmateriales_x_muebles (cantidad_necesaria, id_mueble, id_material)
VALUES	(10, 1, 3),
				(2, 1, 6),
				(2, 2, 3),
				(8, 2, 1),
				(1, 5, 6)

GO
INSERT INTO tmedidas_x_materiales (id_medida, id_material)
VALUES	(7, 3),
				(7, 4),
				(7, 5),
				(7, 6),
				(1, 6)

GO
INSERT INTO tbitacora (numero, descripcion, tipo, id_material, cantidad, precio_nuevo, precio_anterior)
VALUES ('01', 'Salida de madera', 'Salida', 3, 15, 0, 0),
				('02', 'Entrada de plastico para construir una mueble de cocina', 'Entrada', 5, 15, 6000, 5000),
				('03', 'Salida de metal', 'Salida', 4, 15, 11000, 20000)

GO
INSERT INTO tmateriales_x_proveedor(fecha_entrega, id_material, id_proveedor)
VALUES	('2018-04-24', 4, 2),
				('2018-04-24', 3, 1),
				('2018-04-24', 6, 4),
				('2018-04-24', 1, 5)

GO
INSERT INTO tvale_producccion (fecha, cantidad_producida, id_plan, id_mueble)
VALUES	('2018-04-11', 5, 1, 1),
				('2018-05-11', 5, 4, 1),
				('2018-06-11', 5, 5, 1)

GO
INSERT INTO tmedidas_x_muebles (id_medida, id_mueble)
VALUES	(7, 1),
				(5, 1),
				(7, 3),
				(5, 3)

GO
INSERT INTO tmuebles_x_planes (cantidad_x_producir, costo_mano_obra, costo_administrativo, otros_costos, tiempo_produccion, id_mueble, id_plan)
VALUES	(6, 35000, 25000, 2555, '2018-04-15', 1, 1),
				(6, 35000, 25000, 2225, '2018-04-15', 1, 4),
				(6, 35000, 25000, 1025, '2018-04-15', 1, 5)

GO
INSERT INTO tjuego_muebles_x_muebles (id_juego_muebles, id_mueble)
VALUES (1, 1),
				(3, 4)

GO
INSERT INTO tfactura_proveedor (id_factura, id_proveedor)
VALUES	(1, 1),
				(3, 2)

GO
INSERT INTO tfactura_cliente (tipo, id_factura, id_cliente)
VALUES ('Contado', 2, 1),
				('Crédito', 4, 1)

GO
INSERT INTO tfacturas_clientes_x_muebles (cantidad_comprada, id_mueble, id_factura_cliente)
VALUES (2, 1, 1)

GO
INSERT INTO tpago_cliente (saldo, id_pago, id_factura_cliente)
VALUES	(1000, 1, 1)

GO
INSERT INTO tpago_proveedor (numero, id_pago, id_factura_proveedor)
VALUES ('010101', 2, 3)