-- SCRIPT PARA CREACIÓN DE TRIGGERS

-- 1. Trigger para registrar cambios de stock tras una venta
CREATE OR REPLACE TRIGGER trg_actualizar_stock_venta
AFTER INSERT ON DetalleVenta
FOR EACH ROW
BEGIN
  UPDATE Productos
  SET Stock = Stock - :NEW.Cantidad
  WHERE ProductoID = :NEW.ProductoID;
END;
/

-- 2. Trigger para controlar el log de cambios en productos
CREATE OR REPLACE TRIGGER trg_log_actualizacion_producto
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
  INSERT INTO LogCambios (Tabla, Descripcion, FechaCambio)
  VALUES ('Productos', 'Producto actualizado: ' || :OLD.Nombre, SYSDATE);
END;
/

-- 3. Trigger para auditar nuevos clientes
CREATE OR REPLACE TRIGGER trg_auditoria_clientes
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
  INSERT INTO AuditoriaClientes (ClienteID, FechaRegistro)
  VALUES (:NEW.ClienteID, SYSDATE);
END;
/

-- 4. Trigger para validar cantidad en inventario antes de registrar venta
CREATE OR REPLACE TRIGGER trg_validar_stock
BEFORE INSERT ON DetalleVenta
FOR EACH ROW
DECLARE
  v_stock NUMBER;
BEGIN
  SELECT Stock INTO v_stock FROM Productos WHERE ProductoID = :NEW.ProductoID;
  IF v_stock < :NEW.Cantidad THEN
    RAISE_APPLICATION_ERROR(-20001, 'Stock insuficiente para el producto');
  END IF;
END;
/

-- 5. Trigger para actualizar estado del pedido al registrar entrada en inventario
CREATE OR REPLACE TRIGGER trg_actualizar_estado_pedido
AFTER INSERT ON Inventario
FOR EACH ROW
BEGIN
  IF :NEW.PedidoID IS NOT NULL THEN
    UPDATE PedidosProveedor
    SET Estado = 'ENTREGADO'
    WHERE PedidoID = :NEW.PedidoID;
  END IF;
END;
/
