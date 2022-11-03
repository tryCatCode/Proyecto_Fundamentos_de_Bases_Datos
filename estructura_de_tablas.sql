CREATE DATABASE bd_proyecto_final_v3
GO
USE bd_proyecto_final_v3
GO

CREATE TABLE tcategoria(
	id INT NOT NULL CONSTRAINT PK_categoria PRIMARY KEY IDENTITY(1,1),
	codigo VARCHAR(25) NOT NULL CONSTRAINT UNQ_codigo_categoria UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	estado VARCHAR(15)  NULL,
	CONSTRAINT CHK_estado_categoria CHECK (estado IN ('Activo', 'Inactivo'))
)
GO

CREATE TABLE tcliente (
	id INT NOT NULL CONSTRAINT PK_id_cliente PRIMARY KEY IDENTITY(1,1),
	cedula VARCHAR(25) NOT NULL CONSTRAINT UNQ_cedula_cliente UNIQUE,
	nombre VARCHAR(50) NOT NULl,
	direccion_exacta VARCHAR(100) NOT NULL,
	telefono VARCHAR(25) NOT NULL,
	monto_credito FLOAT NOT NULL,
	descuento FLOAT NULL CONSTRAINT DF_descuento_cliente DEFAULT 0
)
GO

CREATE TABLE tplanes(
	id INT NOT NULL CONSTRAINT PK_planes PRIMARY KEY IDENTITY(1,1),
	numero VARCHAR(20) NOT NULL CONSTRAINT UNQ_numero_plan UNIQUE,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL
)
GO

CREATE TABLE tmedida(
	id INT NOT NULL CONSTRAINT PK_medidad PRIMARY KEY IDENTITY(1,1),
	codigo VARCHAR(15) NOT NULL CONSTRAINT UNQ_codigo_medida UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	simbolo VARCHAR(15) NOT NULL
)	
GO

/**ALTER TABLE tmedida
	ADD  simbolo VARCHAR(15) NOT NULL*/


CREATE TABLE tmueble(
	id INT NOT NULL CONSTRAINT PK_mueble PRIMARY KEY IDENTITY(1,1),
	codigo VARCHAR(15) CONSTRAINT UNQ_codigo_mueble UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	descripcion VARCHAR(250) NOT NULL,
	precio_costo FLOAT NOT NULL,
	precio_venta FLOAT NOT NULL,
	unidades_existentes INT NOT NULL CONSTRAINT DF_unidades_existentes DEFAULT 0
)
GO

/*ALTER TABLE tmueble
	ALTER COLUMN descripcion VARCHAR(250) NOT NULL*/

CREATE TABLE tproveedor(
	id INT NOT NULL CONSTRAINT PK_proveedor PRIMARY KEY IDENTITY(1,1),
	cedula VARCHAR(25) NOT NULL CONSTRAINT UNQ_cedula_proveedor UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	direccion_exacta VARCHAR(100) NOT NULL,
	telefono VARCHAR(25) NOT NULL,
	plazo_credito DATE NOT NULL
)
GO

CREATE TABLE tjuego_muebles(
	id INT NOT NULL CONSTRAINT PK_id_tjuego_muebles PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(50) NOT NULL
)
GO

CREATE TABLE tpago(
	id INT NOT NULL CONSTRAINT PK_id_pago PRIMARY KEY IDENTITY(1,1),
	fecha DATE NOT NULL,
	tipo VARCHAR(20) NOT NULL,
	monto FLOAT NOT NULL,
	numero_documento VARCHAR(25) NOT NULL,
	CONSTRAINT CK_tipo_pago CHECK (tipo IN ('Cheque', 'Transferencia' , 'Efectivo'))
)
GO

CREATE TABLE tfactura(
	id INT NOT NULL CONSTRAINT PK_id_factura PRIMARY KEY IDENTITY(1,1),
	numero VARCHAR(20) NOT NULL CONSTRAINT UNQ_numero_factura UNIQUE,
	estado VARCHAR(11) NOT NULL,
	fecha DATE NOT NULL,
	monto FLOAT NOT NULL,
	saldo FLOAT NOT NULL,
	plazo DATE NOT NULL,
	CONSTRAINT CK_estado_factura CHECK (estado IN ('Pendiente', 'Cancelado'))
)
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	

CREATE TABLE tmaterial(
	id INT NOT NULL CONSTRAINT PK_material PRIMARY KEY IDENTITY (1,1),
	codigo VARCHAR(15) NOT NULL CONSTRAINT UNQ_codigo_material UNIQUE,
	nombre VARCHAR(50) NOT NULL,
	precio FLOAT NOT NULL,
	unidades_existentes INT NOT NULL,
	cantidad_maxima INT NOT NULL,
	cantidad_minima INT NOT NULL,
	estado VARCHAR(15) NOT NULL,
	id_categoria INT NOT NULL CONSTRAINT FK_id_categoria_material FOREIGN KEY REFERENCES tcategoria(id),
	CONSTRAINT CK_estado_material CHECK(estado IN ('Activo', 'Inactivo'))
)
GO

CREATE TABLE tmateriales_x_muebles(
	id INT NOT NULL CONSTRAINT PK_materiales_x_muebles PRIMARY KEY IDENTITY(1,1),
	cantidad_necesaria INT NOT NULL,
	id_mueble INT NOT NULL CONSTRAINT FK_mueble_tmateriales_x_muebles FOREIGN KEY REFERENCES tmueble(id),
	id_material INT NOT NULL CONSTRAINT FK_material_tmateriales_x_muebles FOREIGN KEY REFERENCES tmaterial(id)
)
GO

CREATE TABLE tmedidas_x_materiales(
	id INT NOT NULL CONSTRAINT PK_medidas_materiales PRIMARY KEY IDENTITY(1,1),
	id_medida INT NOT NULL CONSTRAINT FK_medida_tmedidas_x_materiales FOREIGN KEY REFERENCES tmedida(id),
	id_material INT NOT NULL CONSTRAINT FK_material_tmedidas_x_materiales FOREIGN KEY REFERENCES tmaterial(id)
)
GO

CREATE TABLE tbitacora (
	id INT NOT NULL CONSTRAINT PK_bitacora PRIMARY KEY IDENTITY(1,1),
	numero VARCHAR(20) NOT NULL CONSTRAINT UNQ_numero_bitacora UNIQUE,
	descripcion VARCHAR(100) NOT NULL,
	tipo VARCHAR(8) NOT NULL, 
	id_material INT NOT NULL CONSTRAINT FK_id_material_bitacora FOREIGN KEY REFERENCES tmaterial(id),
	cantidad INT NOT NULL,
	precio_nuevo FLOAT NULL CONSTRAINT DF_precio_nuevo_bitacora DEFAULT 0, 
	precio_anterior FLOAT NULL CONSTRAINT DF_precio_anterior_bitacora DEFAULT 0,
	CONSTRAINT CK_tipo_bitacora CHECK (tipo IN ('Entrada', 'Salida'))
)
GO

--Fecha de entrega de tipo de dato TIME O DATE
CREATE TABLE tmateriales_x_proveedor (
	id INT NOT NULL CONSTRAINT PK_materiales_proveedor PRIMARY KEY IDENTITY(1,1),
	fecha_entrega DATE NOT NULL,
	id_material INT NOT NULL CONSTRAINT FK_id_material_tmateriales_x_proveedor FOREIGN KEY REFERENCES tmaterial(id),
	id_proveedor INT NOT NULL CONSTRAINT FK_id_proveedor_tmateriales_x_proveedor FOREIGN KEY REFERENCES tproveedor(id)
)
GO

CREATE TABLE tvale_producccion(
	id INT NOT NULL CONSTRAINT PK_id_vale_produccion PRIMARY KEY IDENTITY(1,1),
	fecha DATE NOT NULL,
	cantidad_producida INT NOT NULL,
	id_plan INT NOT NULL CONSTRAINT FK_id_plan_tvale_producccion FOREIGN KEY REFERENCES tplanes(id),
	id_mueble INT NOT NULL CONSTRAINT FK_id_mueble_tvale_producccion FOREIGN KEY REFERENCES tmueble(id)
)
GO

CREATE TABLE tmedidas_x_muebles(
	id INT NOT NULL CONSTRAINT PK_medidas_muebles PRIMARY KEY IDENTITY(1,1),
	id_medida INT NOT NULL CONSTRAINT FK_medida_tmedidas_x_muebles FOREIGN KEY REFERENCES tmedida(id),
	id_mueble INT NOT NULL CONSTRAINT FK_mueble_tmedidas_x_muebles FOREIGN KEY REFERENCES tmueble(id)
)
GO

--Fecha de entrega de tipo de dato TIME O DATE
CREATE TABLE tmuebles_x_planes(
	id INT NOT NULL CONSTRAINT PK_muebles_x_planes PRIMARY KEY IDENTITY(1,1),
	cantidad_x_producir INT NOT NULL CONSTRAINT CK_cantidad_x_producir CHECK (cantidad_x_producir >= 1),
	costo_mano_obra FLOAT NOT NULL,
	costo_administrativo FLOAT NOT NULL,
	otros_costos FLOAT NOT NULL,
	tiempo_produccion DATE NOT NULL,
	id_mueble INT NOT NULL CONSTRAINT FK_id_mueble FOREIGN KEY REFERENCES tmueble(id),
	id_plan INT NOT NULL CONSTRAINT FK_id_plan FOREIGN KEY REFERENCES tplanes(id)
)
GO

CREATE TABLE tjuego_muebles_x_muebles(
	id INT NOT NULL CONSTRAINT PK_id_tjuego_muebles_x_muebles PRIMARY KEY IDENTITY(1,1),
	id_juego_muebles INT NOT NULL CONSTRAINT FK_juegoMuebles_tjuego_muebles_x_muebles FOREIGN KEY REFERENCES tjuego_muebles (id),
	id_mueble INT NOT NULL CONSTRAINT FK_mueble_tjuego_muebles_x_muebles FOREIGN KEY REFERENCES tmueble(id)
)
GO

CREATE TABLE tfactura_proveedor(
	id INT NOT NULL CONSTRAINT PK_factura_cliente PRIMARY KEY IDENTITY(1,1),
	id_factura INT NOT NULL CONSTRAINT FK_factura_tfactura_proveedor FOREIGN KEY REFERENCES tfactura(id),
	id_proveedor INT NOT NULL CONSTRAINT FK_proveedor_tfactura_proveedor FOREIGN KEY REFERENCES tproveedor(id),
)
GO

CREATE TABLE tfactura_cliente(
	id INT NOT NULL CONSTRAINT PK_id_factura_cliente PRIMARY KEY IDENTITY(1,1),
	tipo VARCHAR(10) NOT NULL,
	id_factura INT NOT NULL CONSTRAINT FK_id_factura_tfactura_cliente FOREIGN KEY REFERENCES tfactura(id),
	id_cliente INT NOT NULL CONSTRAINT FK_id_cliente_tfactura_cliente FOREIGN KEY REFERENCES tcliente(id),
	CONSTRAINT CK_tipo_factura_cliente CHECK (tipo IN ('Crédito', 'Contado'))
)
GO

CREATE TABLE tfacturas_clientes_x_muebles(
	id INT NOT NULL CONSTRAINT PK_id_facturas_clientes_x_muebles PRIMARY KEY IDENTITY(1,1),
	cantidad_comprada INT NOT NULL,
	id_mueble INT NOT NULL CONSTRAINT FK_mueble_facturas_clientes_x_muebles FOREIGN KEY REFERENCES tmueble(id),
	id_factura_cliente INT NOT NULL CONSTRAINT Fk_factura_cliente_facturas_clientes_x_muebles FOREIGN KEY REFERENCES tfactura_cliente(id)
)
GO

CREATE TABLE tpago_cliente (
	id INT NOT NULL CONSTRAINT PK_id_pago_cliente PRIMARY KEY IDENTITY(1,1),
	saldo FLOAT NOT NULL,
	id_pago INT NOT NULL CONSTRAINT FK_pago_tpago_cliente FOREIGN KEY REFERENCES tpago(id),
	id_factura_cliente INT NOT NULL CONSTRAINT FK_factura_cliente_tpago_cliente FOREIGN KEY REFERENCES tfactura_cliente(id)
)

GO
ALTER TABLE tpago_cliente
	ALTER COLUMN saldo FLOAT NULL
GO

CREATE TABLE tpago_proveedor(
	id INT NOT NULL CONSTRAINT PK_id_pago_proveedor PRIMARY KEY IDENTITY(1,1),
	numero VARCHAR(50) NOT NULL CONSTRAINT UNQ_numero_pago_proveedor UNIQUE,
	id_pago INT NOT NULL CONSTRAINT FK_pago__tpago_proveedor FOREIGN KEY REFERENCES tpago(id),
	id_factura_proveedor INT NOT NULL CONSTRAINT FK_facturaProveedor__tpago_proveedor FOREIGN KEY REFERENCES tfactura_proveedor(id)
)