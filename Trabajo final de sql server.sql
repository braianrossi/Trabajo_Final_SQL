

--Enunciado de problema N°3: ROBLES S.A

/*La empresa ROBLES S.A. se dedica a la comercialización de muebles y cuenta 
con una amplia gama de productos de alta calidad que se venden tanto al por mayor como 
al público en general con varias sucursales en distintas provincias del país. 
El proceso de venta comienza con la llegada del cliente al local, donde un 
vendedor capacitado lo recibe y lo acompaña durante todo el proceso de compra. El 
cliente puede optar por revisar el catálogo en línea o recorrer el amplio salón de ventas, 
donde puede elegir entre una gran variedad de productos. Una vez que el cliente ha 
decidido qué comprar, el vendedor se encarga de verificar si el producto está disponible 
en el stock en la sucursal y de proporcionar información detallada sobre el precio y las 
características del producto. 
En caso de que el cliente decida realizar la compra, el vendedor procede a registrar 
los detalles del pedido en el sistema de la empresa, asegurándose de que todos los datos 
estén actualizados y sean precisos. A continuación, se prepara el producto para su entrega.
Una vez que el pedido está listo, el cliente se dirige a la caja, donde se realiza el 
pago. La empresa ROBLES S.A. acepta hasta tres formas de pago diferentes por factura 
y dependiendo de la forma de pago puede esta tener recargos, y los detalles de cada forma 
de pago se registran en el sistema. 
Finalmente, el cliente recibe su producto junto con la factura y los detalles de la 
empresa de transporte encargada de la entrega. Esta información se almacena en una base 
de datos centralizada y actualizada regularmente para garantizar la eficiencia y la 
precisión de las operaciones comerciales de ROBLES S.A*/



--Script de la base de datos
--CREAR TABLAS
create database SistemaDeGestionRoblesSA
go
--ABRE BASE DE DATOS
use SistemaDeGestionRoblesSA
go
--CREACION DE TABLAS
create table Paises(
id_pais int identity(1,1), 
nom_pais varchar(150) not null,
constraint pk_paises primary key (id_pais))
create table Provincias(
id_provincia int identity(1,1), 
nom_provincia varchar(150) not null, 
id_pais int,
constraint pk_provincias primary key (id_provincia), 
constraint fk_paises_provincias foreign key (id_pais) references Paises(id_pais))
create table Localidades(
id_localidad int identity(1,1),
nom_localidad varchar(150) not null, 
id_provincia int,
constraint pk_localidades primary key (id_localidad),
constraint fk_provincias_localidades foreign key (id_provincia) references 
Provincias(id_provincia))
create table Barrios(
id_barrio int identity(1,1), 
nom_barrio varchar(150) not null, 
id_localidad int,
constraint pk_barrios primary key (id_barrio),
constraint fk_localidades_barrios foreign key (id_localidad) references 
localidades(id_localidad))
create table tiposDomicilios(
id_tipo_domicilio int identity(1,1),
tipo_domicilio varchar(150) not null,
constraint pk_tiposDomicilios primary key (id_tipo_domicilio))
create table Domicilios(
id_domicilio int identity(1,1), 
calle varchar(200) not null,
altura int not null, 
piso varchar(20), 
depto varchar(20), 
cod_postal int,
id_barrio int,
id_tipo_domicilio int,
constraint pk_domicilios primary key (id_domicilio), 
constraint fk_barrios_domicilios foreign key(id_barrio) references Barrios(id_barrio),
constraint fk_tiposDomicilios_domicilios foreign key(id_tipo_domicilio) references 
tiposDomicilios(id_tipo_domicilio))
create table Colores(
id_color int identity(1,1), 
color varchar(150)not null,
constraint pk_colores primary key (id_color))
create table TiposMateriales(
id_tipo_material int identity(1,1),
tipo_material varchar(50)
constraint pk_tiposMateriales primary key (id_tipo_material))
create table Materiales(
id_material int identity(1,1), 
id_tipo_material int,
material varchar(150)not null,
constraint pk_materiales primary key (id_material),
constraint fk_tiposMateriales_materiales foreign key (id_tipo_material) references 
TiposMateriales(id_tipo_material))
create table tiposMuebles(
id_tipo_mueble int identity(1,1),
tipo_mueble varchar(150)not null,
constraint pk_tiposMuebles primary key (id_tipo_mueble))
create table Medidas(
id_medida int identity(1,1), 
ancho float not null,
alto float not null,
largo float not null,
constraint pk_medidas primary key (id_medida))
create table MarcasProductos(
id_marca int identity(1,1), 
marca varchar(150) not null,
constraint pk_marcas primary key (id_marca))
create table tiposContactos(
id_tipoContacto int identity(1,1),
tipo_contacto varchar(150) not null,
constraint pk_tiposContactos primary key(id_tipoContacto))
create table tiposDocumentos(
id_tipo_documento int identity(1,1),
tipo_documento varchar(150) not null,
constraint pk_tiposDocumentos primary key(id_tipo_documento))
create table Sucursales(
id_sucursal int identity(1,1), 
sucursal varchar(150) not null, 
id_domicilio int,
constraint pk_sucursales primary key (id_sucursal),
constraint fk_domicilios_sucursales foreign key (id_domicilio) references 
Domicilios(id_domicilio))
create table Productos(
id_producto int identity(1,1),
descripcion varchar(50),
precio money not null,
peso float, 
stock bit,
id_color int,
id_material int,
id_tipo_mueble int,
id_medida int not null, 
id_marca int not null,
constraint pk_productos primary key(id_producto),
constraint fk_colores_productos foreign key(id_color) references Colores(id_color),
constraint fk_materiales_productos foreign key(id_material) references 
Materiales(id_material),
constraint fk_tiposMuebles_productos foreign key(id_tipo_mueble) references 
tiposMuebles(id_tipo_mueble),
constraint fk_medidas_productos foreign key (id_medida) references 
Medidas(id_medida),
constraint fk_marcas_productos foreign key(id_marca) references 
MarcasProductos(id_marca))
create table ProductosSucursales(
id_prodSucursal int identity(1,1),
id_sucursal int,
id_producto int
constraint pk_ProductosSucursales primary key(id_prodSucursal),
constraint fk_sucursales_ProductosSucursales foreign key(id_sucursal) references 
Sucursales(id_sucursal),
constraint fk_productos_ProductosSucursales foreign key(id_producto) references 
Productos(id_producto))
create table Proveedores(
id_proveedor int identity(1,1),
razon_social varchar(150) not null ,
CUIT varchar(150) not null,
id_domicilio int,
constraint pk_proveedores primary key (id_proveedor),
constraint fk_domicilios_proveedores foreign key (id_domicilio) references 
Domicilios(id_domicilio))
create table proveedoresMateriales(
id_proveedor_material int identity(1,1), 
id_proveedor int,
id_material int,
constraint pk_proveedoresMateriales primary key (id_proveedor_material), 
constraint fk_proveedor_proveedoresMateriales foreign key (id_proveedor) references 
proveedores(id_proveedor),
constraint fk_materiales_proveedoresMateriales foreign key (id_material) references 
materiales(id_material))
create table Generos(
id_genero int identity(1,1), 
genero varchar(100) not null,
constraint pk_generos primary key(id_genero))
create table tiposClientes(
id_tipoCliente int identity(1,1),
tipoCliente varchar(100)not null,
constraint pk_tipo primary key (id_tipoCliente))
create table Clientes(
id_cliente int identity(1,1), 
nombre varchar(150) not null, 
apellido varchar(150) not null, 
documento varchar(150) not null, 
id_tipo_documento int,
id_domicilio int, 
id_genero int, 
id_tipoCliente int, 
constraint pk_clientes primary key (id_cliente),
constraint fk_tiposDocumentos_clientes foreign key (id_tipo_documento) references 
tiposDocumentos(id_tipo_documento),
constraint fk_domicilios_clientes foreign key (id_domicilio) references 
Domicilios(id_domicilio),
constraint fk_gereros_clientes foreign key (id_genero) references Generos(id_genero),
constraint fk_tiposClientes_clientes foreign key(id_tipoCliente) references 
tiposClientes(id_tipoCliente))
create table Puestos(
id_puesto int identity(1,1), 
puesto varchar(150) not null,
constraint pk_puestos primary key (id_puesto))
create table Empleados(
id_empleado int identity(1,1), 
nombre varchar(150) not null, 
apellido varchar(150) not null, 
documento varchar(150) not null, 
id_tipo_documento int, 
fecha_ingreso date not null, 
fecha_nacimiento date,
id_genero int,
id_domicilio int,
id_puesto int,
constraint pk_empleados primary key (id_empleado),
constraint fk_documentos_empleados foreign key(id_tipo_documento) references 
tiposDocumentos(id_tipo_documento),
constraint fk_generos_empleados foreign key(id_genero) references 
Generos(id_genero),
constraint fk_domicilios_empleados foreign key(id_domicilio) references 
Domicilios(id_domicilio),
constraint fk_puestos_empleados foreign key(id_puesto) references Puestos(id_puesto))
create table TiposAutomoviles(
id_tipo_automovil int identity(1,1),
descripcion varchar(50)
constraint pk_TiposAutomoviles primary key(id_tipo_automovil))
create table MarcasAutomoviles(
id_marcasAutomoviles int identity(1,1),
descripcion varchar(50)
constraint pk_MarcasAutomoviles primary key (id_marcasAutomoviles))
create table Automoviles(
id_automovil int identity(1,1),
patente varchar(50) not null, 
descripcion varchar(50), 
id_marcasAutomoviles int, 
id_tipo_automovil int, 
constraint pk_Automoviles primary key(id_automovil),
constraint fk_TiposAutomoviles_Automoviles foreign key (id_tipo_automovil) 
references TiposAutomoviles(id_tipo_automovil),
constraint fk_MarcasAutomoviles_Automoviles foreign key (id_marcasAutomoviles) 
references MarcasAutomoviles(id_marcasAutomoviles))
create table Repartidores(
id_repartidor int identity(1,1),
nombre varchar(50),
apellido varchar(50),
documento varchar(20),
id_tipo_documento int,
constraint pk_Repartidores primary key (id_repartidor),
constraint fk_TiposDocumentos_Repartidores foreign key (id_tipo_documento) 
references tiposDocumentos(id_tipo_documento))
create table Transportes(
id_transporte int identity(1,1),
razon_social varchar(50),
CUIT varchar(20),
costo money,
id_repartidor int, 
id_automovil int
constraint pk_EmpresasTransportes primary key(id_transporte),
constraint fk_Repartidores_EmpresasTransportes foreign key (id_repartidor) references 
Repartidores(id_repartidor),
constraint fk_Automoviles_EmpresaTransportes foreign key (id_automovil) references 
Automoviles(id_automovil))
create table Contactos(
id_contacto int identity(1,1), 
contacto varchar(100) not null , 
id_tipoContacto int,
id_cliente int null,
id_empleado int null,
id_proveedor int null,
id_sucursal int null,
id_transporte int null,
constraint pk_contactos primary key (id_contacto),
constraint fk_tiposContactos_contacto foreign key (id_tipoContacto) references 
tiposContactos(id_tipoContacto),
constraint fk_Clientes_contacto foreign key (id_cliente) references clientes(id_cliente),
constraint fk_empleados_contacto foreign key (id_empleado) references 
empleados(id_empleado),
constraint fk_proveedores_contacto foreign key (id_proveedor) references 
Proveedores(id_proveedor),
constraint fk_sucursales_contacto foreign key (id_sucursal) references 
Sucursales(id_sucursal),
constraint fk_Transportes_contacto foreign key (id_transporte) references 
Transportes(id_transporte))
create table formasPagos(
id_formaPago int identity(1,1), 
forma_pago varchar(100), 
recargo float,
constraint pk_formasPagos primary key(id_formaPago))
create table tiposMediosCompras(
id_tiposMediosCompras int identity(1,1),
descripcion varchar(50)
constraint pk_tiposMediosCompras primary key (id_tiposMediosCompras))
create table mediosCompras(
id_medioCompra int identity(1,1), 
id_tiposMediosCompras int, 
id_sucursal int,
constraint pk_mediosCompras primary key(id_medioCompra), 
constraint fk_sucursal_mediosCompras foreign key(id_sucursal) references 
Sucursales(id_sucursal),
constraint fk_tiposMediosCompras_mediosCompras foreign 
key(id_tiposMediosCompras) references 
tiposMediosCompras(id_tiposMediosCompras))
create table Facturas( 
id_factura int identity(1,1), 
fecha_pedido date,
id_cliente int,
id_empleado int,
id_medioCompra int,
constraint pk_facturas primary key (id_factura), 
constraint fk_clientes_facturas foreign key(id_cliente) references Clientes(id_cliente),
constraint fk_empelados_facturas foreign key(id_empleado) references 
Empleados(id_empleado),
constraint fk_mediosCompras_facturas foreign key(id_medioCompra) references 
mediosCompras(id_medioCompra))
create table facturasFormasPagos(
id_facturaFormaPago int identity(1,1),
montoPago money,
id_factura int,
id_formaPago int,
constraint pk_facturasFormasPagos primary key(id_facturaFormaPago), 
constraint fk_facturas_facturasFormasPagos foreign key(id_factura) references 
Facturas(id_factura),
constraint fk_formasPagos_facturasFormasPagos foreign key(id_formaPago) references 
formasPagos(id_formaPago))
create table detalleFacturas(
id_detalleFactura int identity(1,1), 
id_factura int,
id_prodSucursal int, 
fecha_entrega date, 
cantidad int,
precio_unitario money,
id_transporte int
constraint pk_detalleFacturas primary key(id_detalleFactura), 
constraint fk_facturas_detalleFacturas foreign key(id_factura) references 
Facturas(id_factura),
constraint fk_productos_detalleFacturas foreign key(id_prodSucursal) references 
ProductosSucursales(id_prodSucursal),
constraint fk_transportes_detalleFacturas foreign key (id_transporte) references 
Transportes(id_transporte))


-- INSERTAR REGISTROS A LAS TABLAS
--PAÍSES
Insert into Paises(nom_pais) values('Argentina');
--PROVINCIAS
Insert into Provincias(nom_provincia,id_pais) values('Caba',1),('Buenos 
Aires',1),('Catamarca',1),('Chubut',1),('Cordoba',1),('Corrientes',1),('Entre 
Rios',1),('Formosa',1),('Jujuy',1),('La Pampa',1),('La 
Rioja',1),('Mendoza',1),('Misiones',1),('Neuquen',1),('Rio Negro',1),('Salta',1),('San 
Juan',1),('San Luis',1),('Santa Fe',1),('Santa 
Cruz',1),('Santiago Del Estero',1),('Tierra Del Fuego',1),('Tucuman',1);
--LOCALIDADES
INSERT INTO Localidades(nom_localidad,id_provincia) VALUES ('Cordoba',5),('Rio 
Cuarto',5),('Villa Maria',5),('Carlos 
Paz',5),('San Francisco',5),('Alta Gracia',5),
('Rio Tercero',5),('Bell Ville',5),('La Calera',5),('Jesus Maria',5),('Villa Dolores',5),('Cruz 
del Eje',5),('Villa 
Allende',5),('Marcos Juarez',5),
('Arroyito',5),('Dean Funes',5),('Colonia Caroya',5),('Laboulaye',5),('Rio 
Segundo',5),('Rio 
Ceballos',5),('Cosquin',5),('Villa Nueva',5),('Unquillo',5),
('Morteros',5),('La Falda',5),('Las Varillas',5),('Villa del 
Rosario',5),('Pilar',5),('Oncativo',5),('Santa Rosa de 
Calamuchita',5),('La Carlota',5),('Malvinas Argentinas',5),('Estacion Juarez 
Celman',5),('Almafuerte',5),('General 
Cabrera',5),('Capilla del Monte',5),('General Deheza',5),('Saldan',5);
--BARRIOS
insert into barrios(nom_barrio,id_localidad) values ('Alto 
Alberdi',1),('Arguello',1),('Alberdi',1),('Alta Cordoba',1),('Alto 
Verde',3),('Altamira',3),('Bella Vista',3),('Juniors',3),
('Yofre Norte',5),('Yofre Sur',5),('Centro',1),('Chateau Carreras',1),('Cerro de las 
Rosas',1),('Cofico',1),('General 
Paz',7),('Guemes',7),('General Arenales',7),('Jardin',7),
('Jose Ignacio Diaz',9),('La France',9),('Los Naranjos',9),('Nueva 
Cordoba',9),('Observatorio',9),('Parque 
Capital',1),('Rosedal',1),('San Francisco',1),
('San Vicente',1),('Santa Isabel',13),('Urca',13),('Villa Belgrano',13),('Villa el 
Libertador',13),('Villa Gran 
Parque',13),('Horizonte',13),('Liceo',1);
--TIPOS DE DOMICILIOS
insert into TiposDomicilios(tipo_domicilio) values 
('Legal'),('Personal'),('Fiscal'),('Comercial'),('Especial'),('Real'),('Civil');
--TIPOS DE GENEROS
Insert into Generos(genero) values ('Masculino'),('Femenino'),('Otro');
--DOMICILIOS
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Negrete de la camara',2221,NULL,NULL,5012,3,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Chancalai',1123,NULL,NULL,5007,13,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Bv. San Juan',345,2,NULL,5002,1,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Av. Las Malvinas',3000,NULL,NULL,5010,11,5)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Av. Gauss',345,NULL,NULL,5002,31,7)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Av. Las Malvinas',5235,NULL,NULL,5015,31,7)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Emilio Salgari ',2080,NULL,NULL,5017,21,2)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Eduardo San Martin',1517,NULL,NULL,12,1,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Juan del campillo',765,NULL,5005,12,7,4)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Jose de quevedo ',7889,NULL,5012,1,3,5)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Av. Colon ',567,5,NULL,5004,7,7)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Talleres',1120,NULL,NULL,5004,7,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Av. La Voz del Interior',4579,NULL,NULL,5020,13,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Av.Donatto Alvarez',3456,NULL,NULL,5009,13,5)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Av. Fuerza Aerea ',4234,NULL,NULL,5015,17,7)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('los tintines',231,NULL,NULL,5001,27,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('sarachaga',1242,2,4,5000,29,2)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('de la rosa',759,3,3,5000,3,7)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('las vertientes',456,NULL,NULL,5002,7,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('lascano',1232,NULL,NULL,5003,7,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('cordoba',1268,1,5,5001,31,7)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('castelar',1568,3,2,5012,33,7)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('pinto',789,NULL,NULL,5000,7,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('copacabana',963,2,4,5015,7,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('sarandi',364,15,3,5010,3,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('vivees',1564,NULL,NULL,5000,1,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('correa',123,2,1,5001,13,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('iribois',1789,2,1,5013,7,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('castelar',654,NULL,NULL,5012,7,5)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('mendiolaza',987,NULL,NULL,5010,5,7)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('ruiz',1453,7,3,5000,5,7)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('colombres',658,NULL,NULL,5001,5,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('suquia',954,2,2,5000,5,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('santa fe',3690,NULL,NULL,5000,7,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('uberman ',1245,NULL,NULL,5000,9,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Av. Capdevilla',3456,NULL,NULL,5013,33,2)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Bv. Los Alemanes',234,3,4,5018,1,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Los italianos',6119,NULL,NULL,5020,33,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Emilio Olmos',345,6,NULL,5003,33,3)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Belgrano',245,3,NULL,5001,5,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('Consejal Alonso',266,NULL,NULL,5019,5,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('tomas de irobi ',5709,1,1,5008,31,2)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('pimentel',456,2,1,5009,1,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('monsenior pablo cabrera',469,1,0,5007,4,7)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('general paz',570,3,4,5008,9,1)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('buenos aires',457,4,1,5003,5,4)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('salta',1700,1,2,5000,5,4)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('manuel belgrano',348,1,3,5001,22,2)
Insert into Domicilios (calle,altura,piso,depto,cod_postal,id_barrio,id_tipo_domicilio) 
Values ('donato alvarez',432,3,1,5002,21,2)
--COLORES 
insert into Colores(color) Values 
('Blanco'),('Celeste'),('Gris'),('Naranja'),('Negro'),('Oro'),('Rojo'),('Rosa'),('Salmón'),('Ver
de');
--TIPO DE MATERIALES 
insert into TiposMateriales(tipo_material) 
values('Madera'),('Metal'),('Piedras'),('Plastico');
--MATERIALES 
insert into Materiales(material,id_tipo_material) 
Values('Pino',1),('Cedro',1),('Roble',1),('Nogal',1),
('Aluminio',2),('Acero inoxidable', 2),('Marmol', 3),('Piedra losada', 3),('Plastico 
PET',4),('Plastico PEAD',4);
--TPOS DE MUEBLES
insert into tiposMuebles(tipo_mueble) values('Sofás'),('Mesas de 
Living'),('Sillas'),('Camas'),('Escritorios'),('Mesas de comedor'),('Sillas de 
comedor'),('Muebles de televisor'),('Bibliotecas'),
('Mesitas de café'),('Mesa de noche'),('Islas para 
cocina'),('Armarios'),('Mesadas'),('Mesas de Patio Exterior');
--MEDIDAS
insert into Medidas(ancho,alto,largo) 
values(15.50,200,50),(15,300,1000),(20,1500,200),(30,3000,1000),(30.50,500,1500);
--MARCAS
insert into MarcasProductos(marca) values('IKEA'),('Williams-Sonoma'),('La-ZBoy'),('Firma americana'),('Kartell'),('Roche Bobois');
--TIPOS DE CONTACTOS
insert into tiposContactos(tipo_contacto) values('Mail'),('Telefono Celular'),('Telefono 
Fijo');
--TIPOS DE DOCUMENTOS
insert into tiposDocumentos(tipo_documento) 
values('D.N.I.'),('Pasaporte'),('CUIL'),('CUIT');
--SUCURSALES
insert into Sucursales(sucursal,id_domicilio) values('Sucursal 1',1),('Sucursal 
2',2),('Sucursal 3',3);
--PRODUCTOS
Insert into Productos
(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,id_medida,
id_marca) values('Mesa de comedor patas cortas',15000.00,500.50,1,2,2,6,5,6)
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca)
values('Mueble para televisor olgante',10000.00,150.50,1,6,1,8,2,4)
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) 
values('Sofa en forma de L',59999.99,200.50,1,2,3,1,5,6)
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Sillas de madera antiguas',7000,20.80,1,5,3,3,5,5)
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Escritorio Gamer',14000.00,50,1,9,6,5,4,1)
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Mesa Exterior De Marmol',150000,800,1,2,7,15,2,6)
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Silla de plastico',5599.99,10,1,10,10,3,5,2)
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Biblioteca de Roble',160000.00,150,1,4,3,9,5,2)
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Biblioteca de Nogal',160000.00,150,1,6,4,9,3,5)
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Silla con respaldo alto', 9999.99,4.50,1,7,5,3,2,4);
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Sofa esquinero',50000.00,50.25,1,10,1,1,1,1);
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Silla Rectangular blanca', 66600.00, 10.00,4,3,5,3,2,1);
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Cama',84999.99,75.00,1,3,5,4,4,2);
insert into 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) values('Escritorio amplio',25000.00,20.78,1,2,10,5,5,3);
INSERT INTO 
Productos(descripcion,precio,peso,stock,id_color,id_material,id_tipo_mueble,
id_medida,id_marca) VALUES ('Mesa de comedor blanca', 76819.19, 
40.00,3,7,7,6,3,4)
--PRODUCTOS SUCURSALES
insert into ProductosSucursales(id_sucursal,id_producto) 
Values(1,1),(2,2),(3,3),(1,4),(1,5),(2,6),(3,7),(2,8),(1,9),(2,10),(3,11),(3,12),(1,13),(2,14)
,(3,15);
--PROVEEDORES
insert into Proveedores(razon_social,CUIT,id_domicilio) 
values ('Productos Rossi','20-4080602-6',4);
insert into Proveedores(razon_social,CUIT,id_domicilio)
values ('Fabrica Internacional de Muebles','30-465875411-9',5);
insert into Proveedores(razon_social,CUIT,id_domicilio) 
values ('Ventas por Sogeli','20-15458454-9',6);
insert into Proveedores(razon_social,CUIT,id_domicilio) 
values ('Tus muebles.com','15-56154865-5',7);
insert into Proveedores(razon_social,CUIT,id_domicilio) 
values ('Muebleria SRL ','30-4068184-9',8);
insert into Proveedores(razon_social,CUIT,id_domicilio)
values ('Familia Mueble','15-48651-5',9);
insert into Proveedores(razon_social,CUIT,id_domicilio)
values ('FA Asociados','48-15486-5',10);
insert into Proveedores(razon_social,CUIT,id_domicilio) 
values ('Asociados Y','4-068175-9',11);
insert into Proveedores(razon_social,CUIT,id_domicilio) 
values ('LJE','40-6817599-4',12);
insert into Proveedores(razon_social,CUIT,id_domicilio)
values ('KM','49-5415654-99',13) ;
insert into Proveedores(razon_social,CUIT,id_domicilio)
values('Pampa Muebles', '98-765432-1',14);
insert into Proveedores(razon_social,CUIT,id_domicilio)
values('La Europera','34-567890-2',15);
insert into Proveedores(razon_social,CUIT,id_domicilio) 
values('Productos Rusticos','34-28962457-2',16);
insert into Proveedores(razon_social,CUIT,id_domicilio) 
values('Materiales Probuild','21-098765-4',17);
insert into Proveedores(razon_social,CUIT,id_domicilio) 
values('Distribuidores Megacorp','56-789012-3',18);
--PROVEEDOR DE MATERIALES
insert into proveedoresMateriales(id_proveedor,id_material) 
VALUES(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,1),(8,2),(9,3),(10,4),(11,5),(12,6),
(13,7),(14,1),(15,2);
--TIPOS CLIENTES
insert into tiposClientes(tipoCliente) values('Cliente Mayorista'),('Cliente Minorista');
--CLIENTES
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Braian', 'Rossi', '40681759',1,19,1,1);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Tatiana', 'Clavero', '40681526',1,20,2,1);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Mariela', 'Aseloni', '15485948',2,21,2,1);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Jose', 'Rossi', '15485926',1,22,3,1);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Raul', 'Rossi', '26-15485-9',3,23,1,1);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values ('Juan','Diaz','24933853',1,24,1,1);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Juan','Pérez','81-83823-2',3,25,1,2);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Julian','Alvarez','AR8765432',2,26,3,2);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('María','Gómez','AR2345678',2,27,2,1);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Carlos','Rodríguez','23-56789012-3',4,28,1,1);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Paola','Argento','27-98765432-1',3,29,2,1);
INSERT INTO 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Lautaro', 'Heger', '40220998', 1,30,2,2);
INSERT INTO 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Federico', 'Heger', '37854698',1,31,1,2);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Cindy', 'Rossi', '15-49893-6',3,32,2,2);
insert into 
Clientes(nombre,apellido,documento,id_tipo_documento,id_domicilio,id_genero,
id_tipoCliente) values('Vanina', 'Rossi', '62-51484-5',4,33,2,2);
--PUESTOS DE TRABAJO
Insert into Puestos(puesto) values('Gerente General'),
('Gerente del la Sucursal'),('Contador'),('Vendedor');
Set dateformat dmy
--EMPLEADOS
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Brahian','Alexis','406815962',1,'31/05/2023','11/11/1997',1,34,1);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Josefina','Rossas','15486251',2,'21/01/2021','10/05/1991',2,35,2);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Federico','Clavero','48561526',1,'12/08/2021','15/01/1967',1,36,2);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Fede','Roso','50681759',1,'29/09/2022','06/12/1987',1,37,2);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Yabran','Thoma','26154896',1,'03/11/2023','01/05/1988',3,38,3);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Joaquin','Lopez','54321098',1,'10/05/2010','08/12/1987',1,39,3);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Pablo','Escobar','32458712',1,'10/02/2021','11/12/2000',1,40,3);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Paula','Irusta','33876123',1,'07/07/2001','12/05/1975',2,41,4);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Jhon','Wick','27321291',1,'23/06/1999','01/01/1972',1,42,4);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Pedro','Aznar','29321231',1,'12/12/2000','02/06/1989',1,43,4);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Alma','Gaudino','39123712',1,'07/10/2012','29/01/1991',2,44,4);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Hugo','Bustamante','40123412',1,'02/12/1994','01/07/1972',2,45,4);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Agustina','Cardozo','32879123',1,'05/04/2019','19/03/1992',2,46,4);
insert into Empleados(nombre,apellido,documento,id_tipo_documento,fecha_ingreso,
fecha_nacimiento,id_genero,id_domicilio,id_puesto) 
values('Tatiana','Tejerina','44120321',1,'06/10/2023','06/02/2003',2,47,4);
--TIPOS DE AUTOMOVILES
insert into TiposAutomoviles(descripcion) values('Moto'),('Auto'),('Utilitario');
--MARCAS DE AUTOMOVILES
insert into MarcasAutomoviles(descripcion) values('Renault'),('Mercedes-Benz'),('Fiat');
--AUTOMOVILES
insert into Automoviles(patente,descripcion,id_marcasAutomoviles,id_tipo_automovil) 
values('AA-254-DS','Color rojo',1,3),('AZ-512-ZA','Color azul',1,1),('AA-854-
DF','Color rojo',2,2), ('AD-421-ZS','Color negro',2,1),('AA-514-AA','Color blanco',3,2);
--REPARTIDORES
insert into Repartidores(nombre,apellido,documento,id_tipo_documento) 
values('Pepe','Argento','40681759',1),('Fatiga','Argento','451289562',1),
('Koki','Argento','5613265',1),('Paola','Argento','5612365',1),
('Moni','Argento','4513298',1);
--TRANSPORTES
insert into Transportes(razon_social,CUIT,costo,id_repartidor,id_automovil) 
values('Correo Argentino', '20-562665132-9',1000.00,1,1),
('Correo Argentino', '20-562665132-9',500.00,2,2),
('Expreso Lomas', '20-556846522-9',600,3,3),
('Expreso Lomas', '20-556846522-9',700,4,4),('Andreani', '20-99999999-9',900,5,5)
--CONTACTOS
insert into Contactos(contacto,id_tipoContacto,id_sucursal) values('6954852',3,1);
insert into Contactos(contacto,id_tipoContacto,id_sucursal) values('2012045',3,2);
insert into Contactos(contacto,id_tipoContacto,id_sucursal) values('540120',3,3);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('542405',2,1);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('12021',2,2);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('120544522',2,3);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('12045',2,4);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('1201',2,5);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('080005022822',2,6);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('21021012',3,7);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('002121021',3,8);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('201254',3,9);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('1200',3,10);
insert into Contactos(contacto,id_tipoContacto,id_cliente) values('6950024852',3,11);
insert into Contactos(contacto,id_tipoContacto,id_cliente) 
values('Braian@yahoo.com.ar',1,12);
insert into Contactos(contacto,id_tipoContacto,id_cliente) 
values('juan@google.com.ar',1,13);
insert into Contactos(contacto,id_tipoContacto,id_cliente) 
values('Pepe@hotmail.com.ar',1,14);
insert into Contactos(contacto,id_tipoContacto,id_cliente) 
values('mariana@gmial.com.ar',1,15);
insert into Contactos(contacto,id_tipoContacto,id_empleado) values('3518485612',1,5);
insert into Contactos(contacto,id_tipoContacto,id_empleado) 
values('JulianAlvarez@gmial.com.ar',1,1);
insert into Contactos(contacto,id_tipoContacto,id_empleado) values('3517578051',2,2);
insert into Contactos(contacto,id_tipoContacto,id_empleado) values('3234321123',2,3);
insert into Contactos(contacto,id_tipoContacto,id_empleado) values('3314276231',2,4);
insert into Contactos(contacto,id_tipoContacto,id_empleado) values('8956151235',3,4)
insert into Contactos(contacto,id_tipoContacto,id_empleado) 
values('BraianAlxis@gmail.com',1,5)
insert into Contactos(contacto,id_tipoContacto,id_empleado) 
values('Juan+Pepe@gmail.com',1,5)
insert into Contactos(contacto,id_tipoContacto,id_empleado) 
values('Sabiola?Leonel@gmail.com',1,5)
insert into Contactos(contacto,id_tipoContacto,id_empleado) 
values('Messi@Cristiano@gmail.com',1,5)
insert into Contactos(contacto,id_tipoContacto,id_empleado) 
values('Jorgue!onaldo@gmail.com',1,5)
insert into Contactos(contacto,id_tipoContacto,id_empleado) 
values('0221-1234567',2,2);
insert into Contactos(contacto,id_tipoContacto,id_empleado) 
values('011-2345-6789',2,2);
insert into Contactos(contacto,id_tipoContacto,id_empleado) 
values('4334610',2,3);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('3518485612',2,1);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('3251651235',2,2);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('7605115',3,3);
insert into Contactos(contacto,id_tipoContacto,id_proveedor)
values('4896525',3,4);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('5845825',3,5);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('9584852',3,6);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('3518485612',2,7);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('3511513212',2,8);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('6551231324',3,9);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('1569815612',3,10);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('4684515',2,3);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('3517578051',2,2);
insert into Contactos(contacto,id_tipoContacto,id_proveedor)
values('3510932127',2,2);
insert into Contactos(contacto,id_tipoContacto,id_proveedor) 
values('3512653521',3,2);
insert into Contactos(contacto,id_tipoContacto,id_proveedor)
values('3517523460',3,2);
insert into Contactos(contacto,id_tipoContacto,id_transporte) 
values('3517523460',3,2);
insert into Contactos(contacto,id_tipoContacto,id_transporte) 
values('011-1234-5678',2,2);
insert into Contactos(contacto,id_tipoContacto,id_transporte) 
values('0221-1234567',2,2);
insert into Contactos(contacto,id_tipoContacto,id_transporte) 
values('011-2345-6789',3,2);
insert into Contactos(contacto,id_tipoContacto,id_transporte) 
values('4334610',2,3);
insert into Contactos(contacto,id_tipoContacto,id_transporte) 
values('4684515',3,3);
--FORMAS DE PAGO
Insert into FormasPagos(forma_pago,recargo) 
values('Efectivo',0),('Cheque',15),('Transferencia',0),('Debito',0),('Credito',7),
('Cuenta corriente',10),('Mercado Pago',10);
--TIPOS MEDIOS COMPRAS
insert into tiposMediosCompras(descripcion) values('Compra en el local'),
('Comprapor pagina web'),('Compra telefónica');
--MEDIOS COMPRAS
insert into mediosCompras(id_sucursal,id_tiposMediosCompras) values(3,1);
insert into mediosCompras(id_sucursal,id_tiposMediosCompras) values(2,2);
insert into mediosCompras(id_sucursal,id_tiposMediosCompras) values(1,3);
insert into mediosCompras(id_sucursal,id_tiposMediosCompras) values(3,1);
insert into mediosCompras(id_sucursal,id_tiposMediosCompras) values(1,2);
insert into mediosCompras(id_sucursal,id_tiposMediosCompras) values(2,3);
--FACTURAS
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('06/01/2023',1,8,1);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('27/06/2023',2,9,2);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('01/07/2022',3,10,3);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('18/09/2022',4,11,1);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('05/10/2021',5,12,2);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('26/01/2021',6,13,3);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('02/02/2020',7,14,1);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('11/08/2020',8,12,2);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('12/04/2019',9,14,3);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('15/09/2019',10,13,1);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('08/01/2018',11,12,2);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('27/05/2018',12,11,3);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('01/07/2017',13,10,1);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('31/12/2016',14,9,2);
insert into Facturas(fecha_pedido,id_cliente,id_empleado,id_medioCompra) 
values('01/01/2016',15,8,3);
--FACTURAS FORMAS PAGOS
insert into facturasFormasPagos(id_factura,id_formaPago,montoPago) 
values(1,1,16000.00)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(2,2,15000.00)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(3,3,25050.00)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(4,1,20500.60)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(5,7,21899.99)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(6,6,30100.50)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(7,7,10999.99)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(8,7,2500.50)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(9,2,19000)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(10,1,25000)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(12,4,3400)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(13,5,3499)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(14,1,1999.99)
INSERT INTO FacturasFormasPagos(id_factura,id_formaPago,montoPago) 
VALUES(15,7,1999.99)
--DETALLE FACTURAS
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'09/01/2023',1,1,15000.00,1)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'30/06/2023',2,2,10000.00,2)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'02/07/2022',3,3,59999.99,3)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'20/09/2022',4,4,7000.00,4)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'05/10/2021',5,5,14000.00,5)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'28/01/2021',6,6,15000.00,1)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'29/02/2020',7,7,5599.99,2)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'30/06/2020',8,8,160000.00,3)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'15/04/2019',9,9,160000.00,4)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'12/09/2019',10,10,9999.99,5)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'16/01/2018',11,11,50000.00,1)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'08/05/2018',12,12,66600.00,2)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'28/07/2017',13,13,84999.99,3)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'31/12/2016',14,14,25000.00,4)
insert into 
detalleFacturas(cantidad,fecha_entrega,id_factura,id_prodSucursal,precio_unitario,
id_transporte) values(1,'05/01/2016',15,15,76819.19,5)


--Consultas


--Braian Alexis Rossi 

/*Se solicita mostrar el top 5 de ventas con las formas de pago en Cheque o Efectivo, 
además, se deberá mostrar los clientes con su número de identificación tipo DNI o 
Pasaporte , la vendedora mostrando su género que sea Femenino, y mostrar el canal de 
atención que se utilizó*/

select top 5 c.apellido + ', ' + c.nombre 'Clientes', c.documento 
'Identificación' ,
ffp.montoPago 'Monto de pago',fp.forma_pago 'Forma de pago' ,
e.apellido+', '+e.nombre 'Empleado', g.genero 'Genero del empleado',
tmc.descripcion 'Medio de compra'
from facturasFormasPagos FFP
INNER JOIN formasPagos FP on FFP.id_formaPago = fp.id_formaPago
INNER JOIN Facturas f on ffp.id_factura = f.id_factura
INNER JOIN Clientes c on c.id_cliente = f.id_cliente
INNER JOIN Empleados e on e.id_empleado = f.id_empleado
INNER JOIN Puestos p on p.id_puesto = e.id_puesto
INNER JOIN Generos g on g.id_genero = e.id_genero
INNER JOIN tiposDocumentos tp on tp.id_tipo_documento = c.id_tipo_documento
INNER JOIN mediosCompras mc on mc.id_medioCompra = f.id_medioCompra
INNER JOIN tiposMediosCompras tmc on tmc.id_tiposMediosCompras =
mc.id_tiposMediosCompras
where (fp.forma_pago = 'Efectivo' or fp.forma_pago = 'Cheque') and
(tp.tipo_documento = 'D.N.I.' or tp.tipo_documento = 'Pasaporte' ) and g.genero =
'Femenino'

/* Listado de productos de menor precio con material Pino o Nogal, peso del producto 
entre 50 y 200 y el nombre del repartidor que empiece con la letra P, con su respectivo 
modelo, vehículo y patente. Domicilio del mismo del cliente (calle, barrio y localidad). 
Ordenar de forma ascendente el precio*/
select P.descripcion 'Descripcion del producto', p.precio 'Precio $',
m.material, p.peso 'Peso del producto',
r.apellido +', '+ r.nombre 'Nombre del repartidor',
tp.descripcion +', ' +ma.descripcion +', '+ a.patente 'Datos del vehiculo',
d.calle 'Direccion del cliente', b.nom_barrio 'Barrio', l.nom_localidad 
'Localidad'
from detalleFacturas DF
JOIN ProductosSucursales PS on PS.id_prodSucursal = DF.id_prodSucursal
JOIN Productos P on P.id_producto = PS.id_producto
JOIN Materiales M on p.id_material = m.id_material
JOIN Transportes T on t.id_transporte = df.id_transporte
JOIN Repartidores R on r.id_repartidor = t.id_repartidor
JOIN Automoviles A on a.id_automovil = t.id_automovil
JOIN TiposAutomoviles TP on tp.id_tipo_automovil = a.id_tipo_automovil
JOIN MarcasAutomoviles MA on ma.id_marcasAutomoviles =
a.id_marcasAutomoviles
JOIN Facturas F on f.id_factura = df.id_factura
JOIN Clientes C on c.id_cliente = f.id_cliente
JOIN Domicilios D on d.id_domicilio = c.id_domicilio
JOIN Barrios B on b.id_barrio = d.id_barrio
JOIN Localidades L on l.id_localidad = b.id_localidad
WHERE (p.peso between 50 and 200) and r.nombre like '[p]%' and( m.material =
'Pino'
or m.material = 'Nogal')
ORDER BY 2

-- Jeremías Ezequiel Patiño Rodríguez

/* Se pide mostrar 5 clientes con su respectivo id, de género masculino y con tipo de 
contacto "Teléfono Celular" ordenados alfabéticamente con nombre completo y mostrar 
solo los apellidos que empiecen con R */
SELECT TOP 5 cl.id_cliente 'Codigo de cliente',
cl.nombre + ' ' + cl.apellido 'Nombre completo', tc.tipo_contacto 'Tipo de 
contacto',
tc.id_tipoContacto 'Id de contacto', g.genero 'Genero'
FROM Clientes CL
JOIN Contactos C on C.id_cliente = CL.id_cliente
JOIN tiposContactos TC on TC.id_tipoContacto = C.id_tipoContacto
JOIN Generos G on g.id_genero = cl.id_genero
Where g.genero = 'Masculino' and tc.tipo_contacto= 'Telefono Celular' and
cl.apellido like 'R%'
ORDER BY [Nombre completo] asc

/* Filtrar todos los productos que su id color sea 2 mostrar respectivamente el nombre 
del color, que el tipo de material este entre los valores 1 y 3 también sus medidas y que 
el alto no pase de 600 a 2500cm, marca ordenarlos alfabéticamente con precio de menor 
a mayor y rotular*/ 
Select p.descripcion 'Nombre del producto', p.precio 'Precio', c.id_color 'Id del 
color',
c.color 'Color del producto', m.id_medida 'Medida', m.alto 'Alto',
m.ancho'Ancho',m.largo'Largo', Mp.marca 'Marca del producto',
MT.id_tipo_material'Id de material' , Mt.material 'Tipo de material'
From Productos P
JOIN Colores C ON c.id_color=p.id_color
JOIN Medidas M ON M.id_medida = p.id_medida
JOIN MarcasProductos MP ON mp.id_marca = p.id_marca
JOIN Materiales MT on mt.id_material = p.id_material
JOIN TiposMateriales TM on tm.id_tipo_material = Mt.id_tipo_material
Where c.id_color in(1,2,4,7) and (TM.tipo_material between 'Madera' and
'Piedras') and (m.alto not between 600 and 25000)
ORDER BY p.precio DESC 


--Lautaro Martin Heger
/* Obtener el detalle de las ventas de los ultimos 3 años de cada vendedor.
Mostrar el nombre del cliente, la forma de pago y la fecha de la venta. Ordenarlo por 
nombre del vendedor en orden alfabetico. */
SELECT E.apellido + ' ' + E.nombre 'Vendedor',(c.apellido + ' ' + c.nombre)
'Cliente',P.descripcion 'Articulo', df.cantidad 'Unidades vendidas',
df.precio_unitario 'Precio Unitario',
fp.forma_pago 'Forma de Pago', f.fecha_pedido 'Fecha de Factura'
FROM detalleFacturas DF
JOIN Facturas F ON F.id_factura = DF.id_factura
JOIN Empleados E ON F.id_empleado = E.id_empleado
JOIN ProductosSucursales PS ON DF.id_prodSucursal = PS.id_prodSucursal
JOIN Productos P ON PS.id_producto = P.id_producto
JOIN Clientes C ON F.id_cliente = c.id_cliente
JOIN facturasFormasPagos FFP ON df.id_factura = ffp.id_factura
JOIN formasPagos FP ON FFP.id_formaPago = FP.id_formaPago
JOIN Generos G ON E.id_genero = G.id_genero
JOIN Puestos PU on E.id_puesto = PU.id_puesto
WHERE PU.puesto = 'Vendedor'AND year(f.fecha_pedido) BETWEEN 2020 AND 2023
ORDER BY 'Vendedor'

/* Se solicita mostrar los nombres de los clientes y productos que hayan comprado entre 
los años 2016 y 2023. Incluir el nombre del vendedor, y filtrar por aquellos productos 
enviados por Correo Argentino. Ordenarlo del más reciente al más antiguo. */
SELECT c.nombre + ' ' + c.apellido 'Cliente', P.descripcion 'Producto',e.nombre 
+ ' '+ e.apellido 'Vendedor', df.cantidad 'Cantidad',p.precio 
'Precio',f.fecha_pedido 'Fecha', t.razon_social 'Transporte'
FROM Clientes C
join Facturas F on c.id_cliente = f.id_cliente
join detalleFacturas DF on f.id_factura = df.id_factura
JOIN ProductosSucursales PS ON df.id_prodSucursal = ps.id_prodSucursal
JOIN Productos P ON PS.id_producto = P.id_producto
JOIN Transportes T ON df.id_transporte = T.id_transporte
JOIN Empleados E ON f.id_empleado = E.id_empleado
WHERE year(f.fecha_pedido) BETWEEN 2016 AND
2023 AND t.razon_social = 'Correo Argentino'
ORDER BY f.fecha_pedido DESC

-- Rivera Nahuel
/*Deben mostrar los nombres y apellidos de los clientes que pagaron con cheque desde 
el 2010 y sus montos de pago
van entre $10.000 y $100.000. Tambien se debe mostrar el monto del pago.
Todo debe estar ordenando con los montos del mayor al menor*/
select concat (C.nombre,' ',C.apellido) 'Nombre completo',montoPago
from Clientes C
join Facturas F on C.id_cliente=F.id_cliente
join FacturasFormasPagos FFP on F.id_factura=FFP.id_factura
join FormasPagos FP on FFP.id_formaPago=FP.id_formaPago
join detalleFacturas DF on F.id_factura=DF.id_factura
where FP.id_formaPago = 2 and montoPago between '10000' and '100000' and
fecha_entrega>='2010-01-01'
order by montoPago desc

/*Se debe obtener (el nombre, fecha de compra, cantidad) de los 3 productos que se 
vendieron en mayor cantidad en una venta. Se debe tener en cuenta que únicamente se 
mostraran los productos pagados en efectivo, y cuyos compradores no tengan
documento tipo CUIL.*/
Select top 3 P.id_producto 'Producto', CONVERT(VARCHAR,F.fecha_pedido,103)
'Fecha de compra', DF.cantidad 'Cantidad comprada'
From Productos P
Join detalleFacturas DF on DF.id_prodSucursal=P.id_producto
join Facturas F on F.id_factura=DF.id_factura
join FacturasFormasPagos FF on FF.id_formaPago=F.id_factura
Join FormasPagos FP on FP.id_formaPago=FF.id_formaPago
join Clientes C on C.id_cliente=C.id_cliente
join TiposDocumentos TD on TD.id_tipo_documento =C.id_tipo_documento
Where (FP.forma_pago ='Efectivo') and (not TD.tipo_documento='C.U.I.L')
Order by DF.cantidad desc

-- Julián Gabriel Calo Konecny
/*Mostrar por nombre, apellido, documento, tipo de documento de los empleados de 
género masculino que tengan el puesto de vendedor cuyo DNI sea mayor a 20 millones. 
Ordenar por Nombre y Apellido de forma descendente. */
select E.nombre +' '+ E.apellido 'Nombre y Apellido',
E.documento 'Documento', TC.tipo_documento 'Tipo de documento',
P.puesto 'Puesto',
G.genero 'Genero'
from Empleados E
join Generos G on G.id_genero = E.id_genero
join Puestos P on P.id_puesto = E.id_puesto
join tiposDocumentos TC on TC.id_tipo_documento = E.id_tipo_documento
where (E.documento >= 20000000)
and G.genero = 'Masculino'
and P.puesto = 'Vendedor'
Order by 'Nombre y apellido' desc

/*Se solicita mostrar 6 ventas con los medios de compra en Local o Telefónica.
Además, se deberá mostrar los clientes con su nombre, apellido y documento, nombre 
del empleado vendedor del pedido, su género y el producto que vendió. El vendedor 
tiene que ser de género femenino y en la fecha del pedido mostrar únicamente el año. Y 
ordenar fecha de pedido en forma ascendente*/
select top 6 C.nombre + ' ' + C.apellido 'Nombre y apellido',
C.documento 'Documento',
 TMC.descripcion 'Medio de Compra',
 E.nombre 'Vendedor', G.genero 'Genero Vendedor',
 P.descripcion 'Producto',
 YEAR(F.fecha_pedido) 'Fecha de pedido'
from Facturas F
join Clientes C on C.id_cliente = F.id_cliente
join mediosCompras MC on MC.id_medioCompra = F.id_medioCompra
join tiposMediosCompras TMC on TMC.id_tiposMediosCompras =
MC.id_tiposMediosCompras
join Empleados E on E.id_empleado = F.id_empleado
join Generos G on G.id_genero = E.id_genero
join detalleFacturas DF on DF.id_factura = F.id_factura
join ProductosSucursales PS on PS.id_prodSucursal = DF.id_prodSucursal
join Productos P on P.id_producto = PS.id_producto
where (TMC.descripcion='Compra en el local' or
TMC.descripcion='Compra telefónica') and
G.genero = 'Femenino' and YEAR(F.fecha_pedido) between 2016 and 2021
order by F.fecha_pedido asc

