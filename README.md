# Proyecto_Fundamentos_de_Bases_Datos
Caso de estudio
La empresa “All Wood” requiere un sistema para registrar la información de la
producción de muebles.
Del levantado de requerimientos se ha obtenido la siguiente información:
Módulos requeridos
Inventario
Se registra una tabla de categorías de materia prima que registra el código de la
categoría, el nombre y un estado (Activo - Inactivo). Por ejemplo :
● Código: cat01
● nombre: ‘Madera’
● estado: ‘activo’
Se registran las unidades de medida identificadas por un código de unidad de
medida, el símbolo que utiliza (m-metros, k-kilos, etc.) y el nombre.
Se registran las materias primas (‘Clavos de acero’, ‘Madera de Laurel’, ‘Codos de
plástico’) que se utilizan para construir los muebles, registrando el código de la
materia prima, el código utilizado por el proveedor, el nombre, el precio, las
unidades en existencia, el punto de reorden (cantidad mínima que debe existir para
hacer pedido), cantidad máxima de almacenamiento, estado (Activo, Inactivo).
El sistema debe permitir registrar los movimientos de inventario de la materia prima,
registrando el número de movimiento, el tipo de movimiento (Entrada - salida), el
código de la materia prima, y la cantidad, si se registra una entrada es importante
guardar el precio anterior y el nuevo en caso de cambio y una descripción del
movimiento (todos los movimientos se deben registrar en una tabla de bitácora).
Se registran los muebles, indicando el código del mueble, el nombre, la descripción,
el precio de costo, precio de venta, las unidades en existencia.
Existen juegos de muebles, que son conjuntos que se forman de la agrupación de
varios muebles (Juego Comedor, Juego Sala, cama con veladoras). Se debe poder
registrar estos como un producto compuesto de muebles individuales indicando la
cantidad de cada mueble que lo compone.
Caso de estudio
La empresa “All Wood” requiere un sistema para registrar la información de la
producción de muebles.
Del levantado de requerimientos se ha obtenido la siguiente información:
Módulos requeridos

#Inventario
Se registra una tabla de categorías de materia prima que registra el código de la
categoría, el nombre y un estado (Activo - Inactivo). Por ejemplo :
● Código: cat01
● nombre: ‘Madera’
● estado: ‘activo’
Se registran las unidades de medida identificadas por un código de unidad de
medida, el símbolo que utiliza (m-metros, k-kilos, etc.) y el nombre.
Se registran las materias primas (‘Clavos de acero’, ‘Madera de Laurel’, ‘Codos de
plástico’) que se utilizan para construir los muebles, registrando el código de la
materia prima, el código utilizado por el proveedor, el nombre, el precio, las
unidades en existencia, el punto de reorden (cantidad mínima que debe existir para
hacer pedido), cantidad máxima de almacenamiento, estado (Activo, Inactivo).
El sistema debe permitir registrar los movimientos de inventario de la materia prima,
registrando el número de movimiento, el tipo de movimiento (Entrada - salida), el
código de la materia prima, y la cantidad, si se registra una entrada es importante
guardar el precio anterior y el nuevo en caso de cambio y una descripción del
movimiento (todos los movimientos se deben registrar en una tabla de bitácora).
Se registran los muebles, indicando el código del mueble, el nombre, la descripción,
el precio de costo, precio de venta, las unidades en existencia.
Existen juegos de muebles, que son conjuntos que se forman de la agrupación de
varios muebles (Juego Comedor, Juego Sala, cama con veladoras). Se debe poder
registrar estos como un producto compuesto de muebles individuales indicando la
cantidad de cada mueble que lo compone.

#Producción
Para cada mueble se debe registrar las materias primas que ocupa, la unidad de
medida que utiliza, la cantidad requerida.
Para cada mueble se debe indicar el tiempo de producción, costo de mano de obra,
costos administrativos y otros costos.
Debe poder registrar planes mensuales de producción donde se indica el número de
plan, fecha Inicio, fecha final y registrar el detalle por mueble a producir indicando el
código del mueble y la cantidad a producir. Considere que el plan mensual es
indicar cuáles muebles se van a construir en un período específico.
Se deben registrar los vales de producción semanalmente, registrando el plan al que
pertenece el vale, la fecha, el mueble y la cantidad producida.

#Compras
Se deben registrar los proveedores con sus datos personales: cédula, nombre,
dirección, teléfonos, tiempo de entrega, plazo de crédito y los productos que ofrece.
Se deben registrar las facturas a proveedores con su respectivo número de factura,
monto, plazo, saldo y estado (Pendiente, cancelada).
Se deben registrar los pagos realizados a facturas indicando el número de pago,
fecha de pago, la factura correspondiente, monto cancelado, tipo pago (cheque,
transferencia, efectivo), documento de Pago (número cheque, numero transferencia,
número recibo de pago).

#Ventas
Se debe registrar el cliente con sus datos personales: cédula, nombre, dirección,
teléfonos, monto de crédito, porcentaje de descuento que se le realiza.

Objetos Programados
Funciones
1. Crear la función escalar FeCostoMateriaPrima que reciba como parámetro el
código del mueble y devuelve el costo en materia prima. El costo de materia
prima para cada mueble es el costo de la materia prima dividido entre el
rendimiento y multiplicado por la cantidad requerida.
2. Crear la función escalar FeCostoMueble que reciba como parámetros el
código del mueble y retorne el costo de producción. El costo de producción
es igual al costo de la materia prima + el costo de mano de obra + gastos
administrativos + otros gastos.
3. Crear la función de tabla FtMateriaPrima que recibe como parámetro el
código del mueble y retorna la materia prima requerida:
a. Código de la materia prima,
b. Nombre
c. Cantidad
4. Función de tabla FtFacturasPendienteProveedor que recibe como parámetro
el código del proveedor y retorna:
a. El número de factura.
b. Nombre del Proveedor.
c. Fecha de vencimiento (Fecha de la factura + plazo crédito)
d. Monto
e. Saldo pendiente

Vistas
1. vwInventarioMateriaPrima
a. CodigoMateriaPrima
b. Nombre
c. CostoUnitario
d. Existencia
e. ValorInventario (CostoUnitario * Existencia)
f. Cantidad a Pedir (Cantidad Máxima – Punto de reorden)
Solo cuando la existencia es igual o menor que el punto de reorden.
2. vwPlanProducción:
a. Número de Plan.
b. FechaInicio.
c. FechaFinal.
d. FechaActual
e. CodigoMueble
f. Mueble
g. CantidadPlaneada.
h. CantidadProducida.
Los planes cuya fecha final sea mayor que a la fecha actual.
3. vwFacturasPendientesCobrar:
a. NumeroFactura.
b. Cliente.
c. FechaVencimiento (FechaFactura + plazo). Monto.
d. FechaPago
e. TipoPago
f. Documento
g. Monto
h. Saldo
Solo las facturas que estén pendientes de pago.
4. VwFacturasPendientesPagar:
a. NumeroFactura.
b. Proveedor.
c. FechaVencimiento (FechaFactura + plazo) Monto.
d. NumeroPago
e. FechaPago
f. Monto
g. TipoPago
h. Documento Monto
i. Saldo.
Solo las facturas que tengan saldos pendientes.

Procedimientos
1. PaRegistrarValeProduccion:
a. Parámetros:
i. NumeroPlan.
ii. CodigoMueble.
iii. Cantidad.
b. Validaciones:
i. Exista el Plan y su fecha final sea mayor que la fecha actual
ii. Exista el mueble y la cantidad sea menor o igual al pendiente.
c. Acciones:
i. Insertar el vale de producción.
ii. Desplegar el registro insertado.
2. PaInsertarPagoFacturaCliente:
a. Parámetros:
i. NumeroFactura.
ii. TipoPago.
iii. Monto
iv. DocumentoPago.
b. Validaciones:
i. Exista la factura.
ii. Que el estado sea pendiente
iii. Monto sea igual o menor al saldo.
c. Acciones:
i. Insertar el registro de pago.
ii. Desplegar los datos del pago utilizando
VwFacturasPendientesCobrar.
3. PaInsertarPagoFacturaProveedor:
a. Parámetros:
i. NumeroFactura.
ii. TipoPago.
iii. Monto
iv. DocumentoPago.
b. Validaciones:
i. Que exista la factura.
ii. Que el estado sea pendiente.
iii. Monto sea igual o menor al saldo.
#c. Acciones:
i. Insertar el registro de pago.
ii. Desplegar los datos del pago utilizando
VwFacturasPendientesProveedor
4. PaDescripcionProductos:
a. Validaciones:
i. Que exista el producto.
b. Acciones:
i. Mostrar los datos del producto.
1. Codigo
2. Nombre
3. PrecioCosto
4. Cantidad
5. Existencia
ii. Mostrar las materias primas del producto.
1. CodigoMateriaPrima
2. Nombre
3. UnidadMedidaProducción.
4. CantidadRequerida
5. Costo
iii. Mostrar el desglose de costos del producto
1. TipoCosto
2. Monto
#Restricciones
Debe incluir las restricciones o reglas para que no se acepten valores inválidos para
las diferentes funciones y procedimientos
Transacciones
Debe hacer uso de las transacciones cuando así lo requiera.
#Bitácora
Debe utilizar triggers para llenar la bitácora mencionada en el enunciado.

#Modelo entidad relacion

![Entidad relacion](https://user-images.githubusercontent.com/117328094/199637879-07a8deb0-86ec-4a19-8891-712b7f4e2863.png)

#Modelo relacional
![modelo relacional](https://user-images.githubusercontent.com/117328094/199637889-b72be68e-0231-466c-bc69-aef6ed487b46.png)
