-- SCRIPT PARA CREACIÓN DE VISTAS

-- 1. Vista de productos con bajo stock
CREATE OR REPLACE VIEW vw_productos_bajo_stock AS
SELECT Nombre, Stock FROM Productos WHERE Stock < 10;

-- 2. Vista de ventas totales por día
CREATE OR REPLACE VIEW vw_ventas_por_dia AS
SELECT TRUNC(FechaVenta) AS Dia, SUM(Total) AS TotalVentas
FROM Ventas
GROUP BY TRUNC(FechaVenta);

-- 3. Vista de clientes frecuentes (más de 3 compras)
CREATE OR REPLACE VIEW vw_clientes_frecuentes AS
SELECT c.ClienteID, c.Nombre, COUNT(v.VentaID) AS Compras
FROM Clientes c
JOIN Ventas v ON c.ClienteID = v.ClienteID
GROUP BY c.ClienteID, c.Nombre
HAVING COUNT(v.VentaID) > 3;

-- 4. Vista de productos por categoría
CREATE OR REPLACE VIEW vw_productos_categoria AS
SELECT p.Nombre AS Producto, c.Nombre AS Categoria
FROM Productos p
JOIN Categorias c ON p.CategoriaID = c.CategoriaID;

-- 5. Vista de productos por proveedor
CREATE OR REPLACE VIEW vw_productos_proveedor AS
SELECT p.Nombre AS Producto, pr.Nombre AS Proveedor
FROM Productos p
JOIN Proveedores pr ON p.ProveedorID = pr.ProveedorID;

-- 6. Vista de pedidos pendientes
CREATE OR REPLACE VIEW vw_pedidos_pendientes AS
SELECT * FROM PedidosProveedor WHERE Estado = 'PENDIENTE';

-- 7. Vista de ventas por empleado
CREATE OR REPLACE VIEW vw_ventas_empleado AS
SELECT e.Nombre AS Empleado, COUNT(v.VentaID) AS Ventas, SUM(v.Total) AS Total
FROM Ventas v
JOIN Empleados e ON v.EmpleadoID = e.EmpleadoID
GROUP BY e.Nombre;

-- 8. Vista de detalle de ventas extendida
CREATE OR REPLACE VIEW vw_detalle_ventas AS
SELECT dv.DetalleID, v.VentaID, p.Nombre AS Producto, dv.Cantidad, dv.Subtotal
FROM DetalleVenta dv
JOIN Ventas v ON dv.VentaID = v.VentaID
JOIN Productos p ON dv.ProductoID = p.ProductoID;

-- 9. Vista de usuarios por rol
CREATE OR REPLACE VIEW vw_usuarios_rol AS
SELECT Rol, COUNT(*) AS Total FROM Usuarios GROUP BY Rol;

-- 10. Vista de inventario reciente (últimos 30 días)
CREATE OR REPLACE VIEW vw_inventario_reciente AS
SELECT * FROM Inventario WHERE FechaMovimiento >= SYSDATE - 30;
