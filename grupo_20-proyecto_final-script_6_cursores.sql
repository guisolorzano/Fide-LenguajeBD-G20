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

-- 9. Cursor para listar clientes y la cantidad de compras realizadas por cada uno
DECLARE
  CURSOR cur_clientes IS
    SELECT ClienteID, Nombre FROM Clientes;
  v_count NUMBER;
BEGIN
  FOR c IN cur_clientes LOOP
    SELECT COUNT(*) INTO v_count 
    FROM Ventas 
    WHERE ClienteID = c.ClienteID;
    DBMS_OUTPUT.PUT_LINE(c.Nombre || ' - Compras realizadas: ' || v_count);
  END LOOP;
END;
/

-- 10. Cursor para listar productos sin stock (agotados)
DECLARE
  CURSOR cur_productos_sin_stock IS
    SELECT ProductoID, Nombre, Stock FROM Productos WHERE Stock = 0;
BEGIN
  FOR r IN cur_productos_sin_stock LOOP
    DBMS_OUTPUT.PUT_LINE('Producto: ' || r.Nombre || ' (Stock: ' || r.Stock || ')');
  END LOOP;
END;
/

-- 11. Cursor para listar productos que nunca han sido vendidos
DECLARE
  CURSOR cur_productos_no_vendidos IS
    SELECT ProductoID, Nombre FROM Productos;
  v_count NUMBER;
BEGIN
  FOR p IN cur_productos_no_vendidos LOOP
    SELECT COUNT(*) INTO v_count 
    FROM DetalleVenta 
    WHERE ProductoID = p.ProductoID;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Producto: ' || p.Nombre || ' (Sin ventas)');
    END IF;
  END LOOP;
END;
/

-- 12. Cursor para listar empleados que no han realizado ventas
DECLARE
  CURSOR cur_empleados_sin_ventas IS
    SELECT EmpleadoID, Nombre FROM Empleados;
  v_count NUMBER;
BEGIN
  FOR e IN cur_empleados_sin_ventas LOOP
    SELECT COUNT(*) INTO v_count 
    FROM Ventas 
    WHERE EmpleadoID = e.EmpleadoID;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Empleado: ' || e.Nombre || ' (Sin ventas)');
    END IF;
  END LOOP;
END;
/

-- 13. Cursor para listar ventas de monto alto (por ejemplo, mayores a 1000)
DECLARE
  CURSOR cur_ventas_monto_alto IS
    SELECT VentaID, Total FROM Ventas WHERE Total > 1000;
BEGIN
  FOR v IN cur_ventas_monto_alto LOOP
    DBMS_OUTPUT.PUT_LINE('Venta #' || v.VentaID || ' Total: ' || v.Total);
  END LOOP;
END;
/

-- 14. Cursor para listar proveedores y la cantidad de pedidos pendientes que tiene cada uno
DECLARE
  CURSOR cur_proveedores_pedidos_pendientes IS
    SELECT ProveedorID, Nombre FROM Proveedores;
  v_count NUMBER;
BEGIN
  FOR p IN cur_proveedores_pedidos_pendientes LOOP
    SELECT COUNT(*) INTO v_count 
    FROM PedidosProveedor 
    WHERE ProveedorID = p.ProveedorID AND Estado = 'PENDIENTE';
    DBMS_OUTPUT.PUT_LINE(p.Nombre || ': ' || v_count || ' pedidos pendientes');
  END LOOP;
END;
/

-- 15. Cursor para listar ventas con el nombre del cliente y del empleado
DECLARE
  CURSOR cur_ventas_clientes_empleados IS
    SELECT v.VentaID,
           c.Nombre AS Cliente,
           e.Nombre AS Empleado,
           v.Total
    FROM Ventas v
    JOIN Clientes c ON v.ClienteID = c.ClienteID
    JOIN Empleados e ON v.EmpleadoID = e.EmpleadoID;
BEGIN
  FOR vinfo IN cur_ventas_clientes_empleados LOOP
    DBMS_OUTPUT.PUT_LINE('Venta #' || vinfo.VentaID || 
                         ' - Cliente: ' || vinfo.Cliente || 
                         ', Empleado: ' || vinfo.Empleado || 
                         ', Total: ' || vinfo.Total);
  END LOOP;
END;
/
