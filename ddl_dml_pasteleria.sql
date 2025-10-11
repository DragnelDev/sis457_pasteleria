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

/* Para borrar Tabalas -> UEPS */

DROP TABLE IF EXISTS DetallePedido;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS Proveedor;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Usuario;

/*Creacion de tablas en SQLserver */
CREATE TABLE Usuario(
  id INT PRIMARY KEY IDENTITY(1,1),
  Usuario VARCHAR(50) NOT NULL,
  Clave VARCHAR(50) NOT NULL,
  Rol VARCHAR(20) NOT NULL
);

CREATE TABLE Producto(
  id INT PRIMARY KEY IDENTITY(1,1),
  Nombre VARCHAR(50) NOT NULL,
  PrecioProducto DECIMAL(10,2) NOT NULL,
  TipoProducto VARCHAR(50) NOT NULL,
  Descripcion VARCHAR(255),
);

CREATE TABLE Cliente(
  id INT PRIMARY KEY IDENTITY(1,1),
  NombreCliente VARCHAR(50) NOT NULL,
  ApellidoCliente VARCHAR(50) NOT NULL,
  TelefonoCliente VARCHAR(15),
  EmailCliente VARCHAR(100),
  DireccionCliente VARCHAR(255)
);

CREATE TABLE Proveedor(
  id INT PRIMARY KEY IDENTITY(1,1),
  NombreProveedor VARCHAR(50) NOT NULL,
  TelefonoProveedor VARCHAR(15),
  EmailProveedor VARCHAR(100),
  DireccionProveedor VARCHAR(255)
);

CREATE TABLE Pedido(
  id INT PRIMARY KEY IDENTITY(1,1),
  FechaEntrega DATETIME NOT NULL,
  Total DECIMAL(10,2) NOT NULL,
  idCliente INT,
  idUsuario INT,
  FOREIGN KEY (idCliente) REFERENCES Cliente(id),
  FOREIGN KEY (idUsuario) REFERENCES Usuario(id),
);

CREATE TABLE DetallePedido(
  id INT PRIMARY KEY IDENTITY(1,1),
  Cantidad INT NOT NULL,
  idPedido INT,
  idProducto INT,
  FOREIGN KEY (idPedido) REFERENCES Pedido(id),
  FOREIGN KEY (idProducto) REFERENCES Producto(id),
);


ALTER TABLE Usuario ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Usuario ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Usuario ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

ALTER TABLE Producto ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Producto ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Producto ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

ALTER TABLE Cliente ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Cliente ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Cliente ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

ALTER TABLE Proveedor ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Proveedor ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Proveedor ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

ALTER TABLE Pedido ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Pedido ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE Pedido ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

ALTER TABLE DetallePedido ADD  usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE DetallePedido ADD  fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();
ALTER TABLE DetallePedido ADD  estado SMALLINT NOT NULL DEFAULT 1; -- -1: Eliminado, 0: Inactivo, 1: Activo

-- Insertar datos iniciales en la tabla Usuario
INSERT INTO Usuario (Usuario, Clave, Rol) VALUES 
('admin', 'admin123', 'Administrador'),
('vendedor1', 'vendedor123', 'Vendedor'),
('vendedor2', 'vendedor123', 'Vendedor');

-- Insertar datos iniciales en la tabla Producto
INSERT INTO Producto (Nombre, PrecioProducto, TipoProducto, Descripcion) VALUES 
('Pastel de Chocolate', 20.00, 'Pastel', 'Delicioso pastel de chocolate con cobertura de ganache.'),
('Cupcake de Vainilla', 3.00, 'Cupcake', 'Suave cupcake de vainilla con glaseado de crema.'),
('Galletas de Avena', 1.50, 'Galleta', 'Crujientes galletas de avena con pasas.'),
('Tarta de Frutas', 15.00, 'Tarta', 'Tarta fresca con una variedad de frutas de temporada.'),
('Brownie', 2.50, 'Postre', 'Brownie denso y fudgy con nueces.');

-- Insertar datos iniciales en la tabla Cliente
INSERT INTO Cliente (NombreCliente, ApellidoCliente, TelefonoCliente, EmailCliente, DireccionCliente) VALUES 
('Juan', 'Perez', '555-1234', 'juan@gmail.com', 'Calle Falsa 123'),
('Maria', 'Lopez', '555-5678', 'maria@gmail.com', 'Avenida Siempre Viva 456'),
('Carlos', 'Gomez', '555-8765', 'carlos@gmail.com', 'Boulevard Central 789');

-- Insertar datos iniciales en la tabla Proveedor
INSERT INTO Proveedor (NombreProveedor, TelefonoProveedor, EmailProveedor, DireccionProveedor) VALUES 
('Dulces S.A.', '555-4321', 'dulses@gmail.com', 'Calle Dulce 321'),
('Harinas y Mas', '555-8765', 'harina@gmail.com', 'Avenida Harina 654'),
('Frutas Frescas', '555-3456', 'frutas@gmail.com', 'Boulevard Fruta 987');

-- Insertar datos iniciales en la tabla Pedido
INSERT INTO Pedido (FechaEntrega, Total, idCliente, idUsuario) VALUES 
('2024-10-01', 50.00, 1, 1),
('2024-10-02', 30.00, 2, 2),
('2024-10-03', 20.00, 3, 3);

-- Insertar datos iniciales en la tabla DetallePedido
INSERT INTO DetallePedido (Cantidad, idPedido, idProducto) VALUES 
(2, 1, 1), -- 2 Pasteles de Chocolate en el Pedido 1
(5, 1, 2), -- 5 Cupcakes de Vainilla en el Pedido 1
(10, 2, 3), -- 10 Galletas de Avena en el Pedido 2
(1, 2, 4), -- 1 Tarta de Frutas en el Pedido 2
(4, 3, 5); -- 4 Brownies en el Pedido 3

GO
-- Verificar los datos insertados
--SELECT * FROM Usuario;
SELECT * FROM Producto;
-- SELECT * FROM Cliente;
-- SELECT * FROM Proveedor;
-- SELECT * FROM Pedido;
-- SELECT * FROM DetallePedido;

GO
-- 1. Eliminar el procedimiento si ya existe (uso de IF EXISTS es correcto)
DROP PROCEDURE IF EXISTS paListarProductos;
GO

-- 2. Crear el Procedimiento Almacenado con el nombre corregido
CREATE PROCEDURE paListarProductos
    @TipoProducto VARCHAR(50) -- Parámetro para filtrar por Tipo de Producto
AS
BEGIN
    -- Consulta para calcular las unidades vendidas e ingresos totales,
    -- filtrando por el Tipo de Producto proporcionado.
    SELECT
        PR.Nombre AS Producto,
        PR.TipoProducto, -- Incluimos el tipo para verificar el filtro
        SUM(DP.Cantidad) AS TotalUnidadesVendidas,
        SUM(DP.Cantidad * PR.PrecioProducto) AS IngresoTotalGenerado
    FROM
        DetallePedido AS DP
    JOIN
        Producto AS PR ON DP.idProducto = PR.id
    WHERE
        -- Filtra el tipo de producto usando el parámetro
        PR.TipoProducto = @TipoProducto
        -- Aseguramos que tanto el detalle del pedido como el producto estén activos (estado = 1)
        AND DP.estado = 1
        AND PR.estado = 1
    GROUP BY
        PR.Nombre, PR.TipoProducto -- Agregamos TipoProducto a GROUP BY
    ORDER BY
        IngresoTotalGenerado DESC;
END
GO

-- Ejecutar el procedimiento almacenado
EXEC paListarProductos 'Pastel';
	