-- SCRIPT PARA CREACIÓN DE CURSORES

-- 1. Cursor para listar todos los productos con bajo stock
DECLARE
  CURSOR cur_productos_bajo_stock IS
    SELECT ProductoID, Nombre, Stock FROM Productos WHERE Stock < 10;
BEGIN
  FOR r IN cur_productos_bajo_stock LOOP
    DBMS_OUTPUT.PUT_LINE('Producto: ' || r.Nombre || ' (Stock: ' || r.Stock || ')');
  END LOOP;
END;
/

-- 2. Cursor para listar ventas recientes
DECLARE
  CURSOR cur_ventas_recientes IS
    SELECT VentaID, FechaVenta, Total FROM Ventas WHERE FechaVenta >= SYSDATE - 7;
BEGIN
  FOR v IN cur_ventas_recientes LOOP
    DBMS_OUTPUT.PUT_LINE('Venta #' || v.VentaID || ' Total: ' || v.Total);
  END LOOP;
END;
/

-- 3. Cursor para recorrer empleados y total de ventas
DECLARE
  CURSOR cur_empleados IS
    SELECT EmpleadoID, Nombre FROM Empleados;
  v_total NUMBER;
BEGIN
  FOR e IN cur_empleados LOOP
    SELECT NVL(SUM(Total), 0) INTO v_total FROM Ventas WHERE EmpleadoID = e.EmpleadoID;
    DBMS_OUTPUT.PUT_LINE(e.Nombre || ' - Total Ventas: ' || v_total);
  END LOOP;
END;
/

-- 4. Cursor para listar proveedores y cantidad de productos asociados
DECLARE
  CURSOR cur_proveedores IS
    SELECT ProveedorID, Nombre FROM Proveedores;
  v_count NUMBER;
BEGIN
  FOR p IN cur_proveedores LOOP
    SELECT COUNT(*) INTO v_count FROM Productos WHERE ProveedorID = p.ProveedorID;
    DBMS_OUTPUT.PUT_LINE(p.Nombre || ': ' || v_count || ' productos');
  END LOOP;
END;
/

-- 5. Cursor para detalle de pedidos pendientes
DECLARE
  CURSOR cur_pedidos IS
    SELECT PedidoID, ProveedorID FROM PedidosProveedor WHERE Estado = 'PENDIENTE';
BEGIN
  FOR ped IN cur_pedidos LOOP
    DBMS_OUTPUT.PUT_LINE('Pedido pendiente: ' || ped.PedidoID || ' - Proveedor: ' || ped.ProveedorID);
  END LOOP;
END;
/

-- 6. Cursor para recorrer el inventario reciente
DECLARE
  CURSOR cur_inventario IS
    SELECT * FROM Inventario WHERE FechaMovimiento >= SYSDATE - 30;
BEGIN
  FOR mov IN cur_inventario LOOP
    DBMS_OUTPUT.PUT_LINE('Movimiento ' || mov.InventarioID || ' - ' || mov.TipoMovimiento);
  END LOOP;
END;
/

-- 7. Cursor para revisar usuarios por rol
DECLARE
  CURSOR cur_usuarios IS
    SELECT NombreUsuario, Rol FROM Usuarios;
BEGIN
  FOR u IN cur_usuarios LOOP
    DBMS_OUTPUT.PUT_LINE(u.NombreUsuario || ' (' || u.Rol || ')');
  END LOOP;
END;
/

-- 8. Cursor para calcular total por cada venta
DECLARE
  CURSOR cur_ventas IS
    SELECT VentaID FROM Ventas;
  v_total NUMBER;
BEGIN
  FOR v IN cur_ventas LOOP
    SELECT SUM(Subtotal) INTO v_total FROM DetalleVenta WHERE VentaID = v.VentaID;
    DBMS_OUTPUT.PUT_LINE('Venta #' || v.VentaID || ' Total Calculado: ' || NVL(v_total,0));
  END LOOP;
END;
/
