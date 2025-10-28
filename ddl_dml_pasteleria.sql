CREATE DATABASE LabPasteleria;
USE master
GO 
CREATE LOGIN usrpasteleria WITH PASSWORD = '123456',
	CHECK_pOLICY = ON,
	CHECK_EXPIRATION = OFF,
	DEFAULT_DATABASE = LabPasteleria
GO
USE LabPasteleria
GO 
CREATE USER usrpasteleria FOR LOGIN usrpasteleria
GO
ALTER ROLE db_owner ADD MEMBER usrpasteleria
GO

DROP DATABASE IF EXISTS LabPasteleria;
/* Para borrar Tabalas -> UEPS */
DROP TABLE IF EXISTS DetallePedido;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS Producto;
-- DROP TABLE IF EXISTS Proveedor;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Empleado;

/*Creacion de tablas en SQLserver */
CREATE TABLE Empleado (
  id INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
  cedulaIdentidad VARCHAR(12) NOT NULL UNIQUE,
  nombres VARCHAR(50) NOT NULL,
  apellidoPaterno VARCHAR(50) NULL,
  apellidoMaterno VARCHAR(50) NULL,
  fechaNacimiento DATE NOT NULL,
  direccion VARCHAR(250) NOT NULL,
  celular BIGINT NOT NULL,
  cargo VARCHAR(50) NOT NULL
);

CREATE TABLE Usuario (
    id INT PRIMARY KEY IDENTITY(1,1),
    idEmpleado INT NOT NULL,
    usuario VARCHAR(15) NOT NULL UNIQUE,
    clave VARCHAR(250) NOT NULL,
    CONSTRAINT fk_Usuario_Empleado FOREIGN KEY (idEmpleado)
	REFERENCES Empleado(id)
);

CREATE TABLE Cliente (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NULL,
    email VARCHAR(100) UNIQUE,
    direccion VARCHAR(255) NULL
);

/*
CREATE TABLE Proveedor (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombreProveedor VARCHAR(100) NOT NULL,
    telefonoProveedor VARCHAR(20) NULL,
    emailProveedor VARCHAR(100) UNIQUE,
    direccionProveedor VARCHAR(255) NULL
);*/

CREATE TABLE Producto (
    id INT PRIMARY KEY IDENTITY(1,1),
    codigo VARCHAR(20) NOT NULL,
    nombre VARCHAR(150) NOT NULL UNIQUE,
    precio DECIMAL(10, 2) NOT NULL,
    tipo VARCHAR(50) NULL,
    descripcion VARCHAR(MAX) NULL,
    /*idProveedor INT NOT NULL
    
    CONSTRAINT fK_Producto_Proveedor FOREIGN KEY (idProveedor)
        REFERENCES Proveedor(id)*/
);

CREATE TABLE Pedido (
    id INT PRIMARY KEY IDENTITY(1,1),
    fechaEntrega DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    idCliente INT NOT NULL, 
    idUsuario INT NOT NULL
    
    CONSTRAINT fK_Pedido_Cliente FOREIGN KEY (idCliente)
        REFERENCES Cliente(id),
    CONSTRAINT fK_Pedido_Usuario FOREIGN KEY (idUsuario)
        REFERENCES Usuario(id)
);

CREATE TABLE DetallePedido (
    id INT PRIMARY KEY IDENTITY(1,1),
    cantidad INT NOT NULL,
    idPedido INT NOT NULL, 
    idProducto INT NOT NULL
    
    CONSTRAINT fK_DetallePedido_Pedido FOREIGN KEY (idPedido)
        REFERENCES Pedido(id),
    CONSTRAINT fK_DetallePedido_Producto FOREIGN KEY (idProducto)
        REFERENCES Producto(id)
);


ALTER TABLE Empleado ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Empleado ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Empleado ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

ALTER TABLE Usuario ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Usuario ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Usuario ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

ALTER TABLE Producto ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Producto ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Producto ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

ALTER TABLE Cliente ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Cliente ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Cliente ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

/*
ALTER TABLE Proveedor ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Proveedor ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Proveedor ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo
*/

ALTER TABLE Pedido ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Pedido ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Pedido ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

ALTER TABLE DetallePedido ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE DetallePedido ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE DetallePedido ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo


INSERT INTO Empleado (cedulaIdentidad, nombres, apellidoPaterno, apellidoMaterno, fechaNacimiento, direccion, celular, cargo) VALUES 
('12345678', 'Juan', 'Perez', 'Lopez', '1990-05-15', 'Calle Falsa 123', 5551234, 'Administrador');

INSERT INTO Usuario (idEmpleado, usuario, clave) VALUES 
(1, 'jperez', 'I0HCOO/NSSY6WOS9POP5XW=='); -- Clave: hola123

INSERT INTO Cliente (nombre, apellido, telefono, email, direccion) VALUES 
('Juan', 'Perez', '555-1234', 'juan@gmail.com', 'Calle Falsa 123'),
('Maria', 'Lopez', '555-5678', 'maria@gmail.com', 'Avenida Siempre Viva 456'),
('Carlos', 'Gomez', '555-8765', 'carlos@gmail.com', 'Boulevard Central 789');

/*INSERT INTO Proveedor (nombreProveedor, telefonoProveedor, emailProveedor, direccionProveedor) VALUES 
('Dulces S.A.', '555-4321', 'dulses@gmail.com', 'Calle Dulce 321'),
('Harinas y Mas', '555-8765', 'harina@gmail.com', 'Avenida Harina 654'),
('Frutas Frescas', '555-3456', 'frutas@gmail.com', 'Boulevard Fruta 987');*/

INSERT INTO Producto (codigo, nombre, precio, tipo, descripcion) VALUES 
('PAS001', 'Pastel de Chocolate', 20.00, 'Pastel', 'Delicioso pastel de chocolate con cobertura de ganache.'),
('CUP001', 'Cupcake de Vainilla', 3.00, 'Cupcake', 'Suave cupcake de vainilla con glaseado de crema.'),
('GAl001', 'Galletas de Avena', 1.50, 'Galleta', 'Crujientes galletas de avena con pasas.');

INSERT INTO Pedido (fechaEntrega, total, idCliente, idUsuario) VALUES 
('2024-10-01', 50.00, 1, 1),
('2024-10-02', 30.00, 2, 1),
('2024-10-03', 20.00, 3, 1);

INSERT INTO DetallePedido (cantidad, idPedido, idProducto) VALUES 
(2, 1, 1), -- 2 Pasteles de Chocolate en el Pedido 1
(5, 2, 2), -- 5 Cupcakes de Vainilla en el Pedido 1
(1, 3, 3); -- 1 Galletas de Avena en el Pedido 2

GO
-- Verificar los datos insertados
SELECT * FROM Empleado;
SELECT * FROM Usuario;
SELECT * FROM Producto;
SELECT * FROM Cliente;
-- SELECT * FROM Proveedor;
SELECT * FROM Pedido;
SELECT * FROM DetallePedido;

GO
-- 1. Eliminar el procedimiento si ya existe (uso de IF EXISTS es correcto)
DROP PROCEDURE IF EXISTS paListarProductos;
GO

-- Listar Productos con su Proveedor
CREATE PROC paListarProductos @parametro VARCHAR(50)
AS
    SELECT
        P.id,
        p.codigo,
        P.nombre,
        P.precio,
        P.tipo,
        P.descripcion,
        P.estado,
	P.usuarioRegistro,
        P.fechaRegistro
    FROM Producto P
    WHERE P.estado = 1 -- Solo productos Activos
    AND P.nombre LIKE '%' + @parametro + '%' -- Solo buscamos por el nombre del producto
    ORDER BY P.nombre ASC;

-- Ejecutar el procedimiento almacenado
EXEC paListarProductos 'Pastel';

GO
DROP PROC IF EXISTS paListarEmpleados;
GO
CREATE PROC paListarEmpleados @parametro VARCHAR(50)
AS
  SELECT E.id,
         E.cedulaIdentidad,
         E.nombres,
         E.apellidoPaterno,
         E.apellidoMaterno,
         E.fechaNacimiento,
         E.direccion,
         E.celular,
         E.cargo,
         E.estado,
         E.usuarioRegistro,
         E.fechaRegistro
   FROM Empleado E
   WHERE E.estado = 1 -- Solo empleados Activos
         AND (E.nombres + ' ' + E.apellidoPaterno + ' ' +
         E.apellidoMaterno LIKE '%' + @parametro + '%'
              OR E.cedulaIdentidad LIKE '%' + @parametro + '%')
              ORDER BY E.apellidoPaterno ASC;


-- Ejecutar el procedimiento almacenado
EXEC paListarEmpleados '';

GO
DROP PROC IF EXISTS paListarCliente;
GO

-- Listar Clientes Activos con Búsqueda
CREATE PROC paListarCliente @parametro VARCHAR(255)
AS
    SELECT
        id,
        nombre,
        apellido,
        telefono,
        email,
        direccion,
        usuarioRegistro,
        fechaRegistro,
        estado
    FROM Cliente
    WHERE estado = 1
    AND (
        nombre + ' ' + apellido LIKE '%' + @parametro + '%' OR
        email LIKE '%' + @parametro + '%'
    )
    ORDER BY apellido ASC;

    EXEC paListarCliente 'Juan';
    GO

/*
-- Obtener un Cliente por ID
CREATE PROC paClienteObtener @idCliente INT
AS
    SELECT *
    FROM Cliente
    WHERE id = @idCliente;

    EXEC paClienteObtener 1;
    GO*/


    DROP PROC IF EXISTS paPedidoListar;
    GO
-- Listar Pedidos entre dos fechas
CREATE PROC paPedidoListar @fechaInicio DATE, @fechaFin DATE
AS
    SELECT
        PE.id AS IdPedido,
        PE.fechaEntrega,
        PE.total,
        C.nombre + ' ' + C.apellido AS NombreCliente,
        E.nombres + ' ' + ISNULL(E.apellidoPaterno, '') + ' ' + ISNULL(E.apellidoMaterno, '') AS EmpleadoVenta, 
        PE.estado,
        PE.fechaRegistro
    FROM Pedido PE
    INNER JOIN Cliente C ON C.id = PE.idCliente
    INNER JOIN Usuario U ON U.id = PE.idUsuario
    INNER JOIN Empleado E ON E.id = U.idEmpleado
    WHERE PE.estado = 1
    AND PE.fechaRegistro BETWEEN @fechaInicio AND @fechaFin 
    ORDER BY PE.fechaRegistro DESC;

-- Ejecutar el procedimiento almacenado
EXEC paPedidoListar '2024-01-01', '2024-12-31';
GO


/*DROP PROC IF EXISTS paPedidoDetalleObtener;
GO
-- Obtener Detalle de un Pedido por ID
CREATE PROC paPedidoDetalleObtener @idPedido INT
AS
    SELECT
        DP.cantidad,
        P.nombre AS NombreProducto,
        P.precio, 
        (DP.cantidad * P.precio) AS SubTotal
    FROM DetallePedido DP
    INNER JOIN Producto P ON P.id = DP.idProducto
    WHERE DP.idPedido = @idPedido
    AND DP.estado = 1;
-- Ejecutar el procedimiento almacenado
EXEC paPedidoDetalleObtener 1;
GO*/

/*-- Consulta para ver quién creó qué usuario
CREATE VIEW vwUsuariosCreacion AS
SELECT
    usuario,
    rol,
    usuarioRegistro AS CreadoPor,
    fechaRegistro AS FechaCreacion,
    CASE estado
        WHEN 1 THEN 'Activo'
        WHEN 0 THEN 'Inactivo'
        WHEN -1 THEN 'Eliminado'
    END AS Estado
FROM Usuario
ORDER BY fechaRegistro DESC;
GO
-- Ver los datos de la vista
SELECT * FROM vwUsuariosCreacion;*/


	