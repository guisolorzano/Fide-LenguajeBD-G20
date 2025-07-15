-- SCRIPT PARA CREACIÓN DE FUNCIONES

-- 1. Obtener nombre de cliente por ID
CREATE OR REPLACE FUNCTION fn_nombre_cliente(p_clienteid NUMBER)
RETURN NVARCHAR2 IS
  v_nombre NVARCHAR2(100);
BEGIN
  SELECT Nombre INTO v_nombre FROM Clientes WHERE ClienteID = p_clienteid;
  RETURN v_nombre;
END;
/

-- 2. Obtener nombre de producto por ID
CREATE OR REPLACE FUNCTION fn_nombre_producto(p_productoid NUMBER)
RETURN NVARCHAR2 IS
  v_nombre NVARCHAR2(100);
BEGIN
  SELECT Nombre INTO v_nombre FROM Productos WHERE ProductoID = p_productoid;
  RETURN v_nombre;
END;
/

-- 3. Calcular el subtotal de un detalle de venta
CREATE OR REPLACE FUNCTION fn_calcular_subtotal(p_cantidad NUMBER, p_precio_unitario NUMBER)
RETURN NUMBER IS
BEGIN
  RETURN p_cantidad * p_precio_unitario;
END;
/

-- 4. Obtener el total de una venta
CREATE OR REPLACE FUNCTION fn_total_venta(p_ventaid NUMBER)
RETURN NUMBER IS
  v_total NUMBER;
BEGIN
  SELECT SUM(Subtotal) INTO v_total FROM DetalleVenta WHERE VentaID = p_ventaid;
  RETURN NVL(v_total, 0);
END;
/

-- 5. Verificar si producto tiene stock suficiente
CREATE OR REPLACE FUNCTION fn_stock_suficiente(p_productoid NUMBER, p_cantidad NUMBER)
RETURN BOOLEAN IS
  v_stock NUMBER;
BEGIN
  SELECT Stock INTO v_stock FROM Productos WHERE ProductoID = p_productoid;
  RETURN v_stock >= p_cantidad;
END;
/

-- 6. Obtener cantidad en inventario de un producto
CREATE OR REPLACE FUNCTION fn_inventario_producto(p_productoid NUMBER)
RETURN NUMBER IS
  v_total NUMBER;
BEGIN
  SELECT SUM(CASE WHEN TipoMovimiento = 'ENTRADA' THEN Cantidad ELSE -Cantidad END)
  INTO v_total FROM Inventario WHERE ProductoID = p_productoid;
  RETURN NVL(v_total, 0);
END;
/

-- 7. Obtener nombre de empleado por ID
CREATE OR REPLACE FUNCTION fn_nombre_empleado(p_empleadoid NUMBER)
RETURN NVARCHAR2 IS
  v_nombre NVARCHAR2(100);
BEGIN
  SELECT Nombre INTO v_nombre FROM Empleados WHERE EmpleadoID = p_empleadoid;
  RETURN v_nombre;
END;
/

-- 8. Verificar si cliente es frecuente
CREATE OR REPLACE FUNCTION fn_es_cliente_frecuente(p_clienteid NUMBER)
RETURN BOOLEAN IS
  v_compras NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_compras FROM Ventas WHERE ClienteID = p_clienteid;
  RETURN v_compras > 3;
END;
/

-- 9. Obtener cantidad total de productos vendidos
CREATE OR REPLACE FUNCTION fn_total_productos_vendidos(p_productoid NUMBER)
RETURN NUMBER IS
  v_total NUMBER;
BEGIN
  SELECT SUM(Cantidad) INTO v_total FROM DetalleVenta WHERE ProductoID = p_productoid;
  RETURN NVL(v_total, 0);
END;
/

-- 10. Calcular descuento de cliente frecuente
CREATE OR REPLACE FUNCTION fn_descuento_cliente(p_clienteid NUMBER, p_total NUMBER)
RETURN NUMBER IS
BEGIN
  IF fn_es_cliente_frecuente(p_clienteid) THEN
    RETURN p_total * 0.90; -- 10% de descuento
  ELSE
    RETURN p_total;
  END IF;
END;
/

-- 11. Obtener cantidad total de ventas de un empleado
CREATE OR REPLACE FUNCTION fn_total_ventas_empleado(p_empleadoid NUMBER)
RETURN NUMBER IS
  v_total NUMBER;
BEGIN
  SELECT SUM(Total) INTO v_total FROM Ventas WHERE EmpleadoID = p_empleadoid;
  RETURN NVL(v_total, 0);
END;
/

-- 12. Obtener número total de ventas por cliente
CREATE OR REPLACE FUNCTION fn_cantidad_ventas_cliente(p_clienteid NUMBER)
RETURN NUMBER IS
  v_total NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_total FROM Ventas WHERE ClienteID = p_clienteid;
  RETURN v_total;
END;
/

-- 13. Calcular el precio promedio de productos
CREATE OR REPLACE FUNCTION fn_precio_promedio_productos
RETURN NUMBER IS
  v_prom NUMBER;
BEGIN
  SELECT AVG(Precio) INTO v_prom FROM Productos;
  RETURN v_prom;
END;
/

-- 14. Verificar si usuario tiene rol administrador
CREATE OR REPLACE FUNCTION fn_es_administrador(p_usuarioid NUMBER)
RETURN BOOLEAN IS
  v_rol NVARCHAR2(50);
BEGIN
  SELECT Rol INTO v_rol FROM Usuarios WHERE UsuarioID = p_usuarioid;
  RETURN v_rol = 'ADMIN';
END;
/

-- 15. Obtener nombre de proveedor por ID
CREATE OR REPLACE FUNCTION fn_nombre_proveedor(p_proveedorid NUMBER)
RETURN NVARCHAR2 IS
  v_nombre NVARCHAR2(100);
BEGIN
  SELECT Nombre INTO v_nombre FROM Proveedores WHERE ProveedorID = p_proveedorid;
  RETURN v_nombre;
END;
/
