-- SCRIPT PARA CREACIÓN DE PAQUETES

-- Paquete CRUD para Clientes
CREATE OR REPLACE PACKAGE pkg_clientes AS
  PROCEDURE CrearCliente(p_nombre NVARCHAR2, p_telefono NVARCHAR2, p_correo NVARCHAR2);
  PROCEDURE LeerCliente(p_clienteid IN NUMBER, p_result OUT SYS_REFCURSOR);
  PROCEDURE ActualizarCliente(p_clienteid IN NUMBER, p_nombre NVARCHAR2, p_telefono NVARCHAR2, p_correo NVARCHAR2);
  PROCEDURE EliminarCliente(p_clienteid IN NUMBER);
END pkg_clientes;
/

CREATE OR REPLACE PACKAGE BODY pkg_clientes AS
  PROCEDURE CrearCliente(p_nombre NVARCHAR2, p_telefono NVARCHAR2, p_correo NVARCHAR2) IS
  BEGIN
    INSERT INTO Clientes (Nombre, Telefono, Correo)
    VALUES (p_nombre, p_telefono, p_correo);
  END;

  PROCEDURE LeerCliente(p_clienteid IN NUMBER, p_result OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_result FOR
      SELECT * FROM Clientes WHERE ClienteID = p_clienteid;
  END;

  PROCEDURE ActualizarCliente(p_clienteid IN NUMBER, p_nombre NVARCHAR2, p_telefono NVARCHAR2, p_correo NVARCHAR2) IS
  BEGIN
    UPDATE Clientes
    SET Nombre = p_nombre,
        Telefono = p_telefono,
        Correo = p_correo
    WHERE ClienteID = p_clienteid;
  END;

  PROCEDURE EliminarCliente(p_clienteid IN NUMBER) IS
  BEGIN
    DELETE FROM Clientes WHERE ClienteID = p_clienteid;
  END;
END pkg_clientes;
/

-- Paquete CRUD para Empleados
CREATE OR REPLACE PACKAGE pkg_empleados AS
  PROCEDURE CrearEmpleado(p_nombre NVARCHAR2, p_cargo NVARCHAR2);
  PROCEDURE LeerEmpleado(p_empleadoid IN NUMBER, p_result OUT SYS_REFCURSOR);
  PROCEDURE ActualizarEmpleado(p_empleadoid IN NUMBER, p_nombre NVARCHAR2, p_cargo NVARCHAR2);
  PROCEDURE EliminarEmpleado(p_empleadoid IN NUMBER);
END pkg_empleados;
/

CREATE OR REPLACE PACKAGE BODY pkg_empleados AS
  PROCEDURE CrearEmpleado(p_nombre NVARCHAR2, p_cargo NVARCHAR2) IS
  BEGIN
    INSERT INTO Empleados (Nombre, Cargo)
    VALUES (p_nombre, p_cargo);
  END;

  PROCEDURE LeerEmpleado(p_empleadoid IN NUMBER, p_result OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_result FOR
      SELECT * FROM Empleados WHERE EmpleadoID = p_empleadoid;
  END;

  PROCEDURE ActualizarEmpleado(p_empleadoid IN NUMBER, p_nombre NVARCHAR2, p_cargo NVARCHAR2) IS
  BEGIN
    UPDATE Empleados
    SET Nombre = p_nombre,
        Cargo = p_cargo
    WHERE EmpleadoID = p_empleadoid;
  END;

  PROCEDURE EliminarEmpleado(p_empleadoid IN NUMBER) IS
  BEGIN
    DELETE FROM Empleados WHERE EmpleadoID = p_empleadoid;
  END;
END pkg_empleados;
/

-- Paquete CRUD para Usuarios
CREATE OR REPLACE PACKAGE pkg_usuarios AS
  PROCEDURE CrearUsuario(p_empleadoid NUMBER, p_nombreusuario NVARCHAR2, p_contrasena NVARCHAR2, p_rol NVARCHAR2);
  PROCEDURE LeerUsuario(p_usuarioid IN NUMBER, p_result OUT SYS_REFCURSOR);
  PROCEDURE ActualizarUsuario(p_usuarioid IN NUMBER, p_nombreusuario NVARCHAR2, p_contrasena NVARCHAR2, p_rol NVARCHAR2);
  PROCEDURE EliminarUsuario(p_usuarioid IN NUMBER);
END pkg_usuarios;
/

CREATE OR REPLACE PACKAGE BODY pkg_usuarios AS
  PROCEDURE CrearUsuario(p_empleadoid NUMBER, p_nombreusuario NVARCHAR2, p_contrasena NVARCHAR2, p_rol NVARCHAR2) IS
  BEGIN
    INSERT INTO Usuarios (EmpleadoID, NombreUsuario, Contrasena, Rol)
    VALUES (p_empleadoid, p_nombreusuario, p_contrasena, p_rol);
  END;

  PROCEDURE LeerUsuario(p_usuarioid IN NUMBER, p_result OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_result FOR
      SELECT * FROM Usuarios WHERE UsuarioID = p_usuarioid;
  END;

  PROCEDURE ActualizarUsuario(p_usuarioid IN NUMBER, p_nombreusuario NVARCHAR2, p_contrasena NVARCHAR2, p_rol NVARCHAR2) IS
  BEGIN
    UPDATE Usuarios
    SET NombreUsuario = p_nombreusuario,
        Contrasena = p_contrasena,
        Rol = p_rol
    WHERE UsuarioID = p_usuarioid;
  END;

  PROCEDURE EliminarUsuario(p_usuarioid IN NUMBER) IS
  BEGIN
    DELETE FROM Usuarios WHERE UsuarioID = p_usuarioid;
  END;
END pkg_usuarios;
/

-- Paquete CRUD para Categorias
CREATE OR REPLACE PACKAGE pkg_categorias AS
  PROCEDURE CrearCategoria(p_nombre NVARCHAR2);
  PROCEDURE LeerCategoria(p_categoriaid IN NUMBER, p_result OUT SYS_REFCURSOR);
  PROCEDURE ActualizarCategoria(p_categoriaid IN NUMBER, p_nombre NVARCHAR2);
  PROCEDURE EliminarCategoria(p_categoriaid IN NUMBER);
END pkg_categorias;
/

CREATE OR REPLACE PACKAGE BODY pkg_categorias AS
  PROCEDURE CrearCategoria(p_nombre NVARCHAR2) IS
  BEGIN
    INSERT INTO Categorias (Nombre) VALUES (p_nombre);
  END;

  PROCEDURE LeerCategoria(p_categoriaid IN NUMBER, p_result OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_result FOR SELECT * FROM Categorias WHERE CategoriaID = p_categoriaid;
  END;

  PROCEDURE ActualizarCategoria(p_categoriaid IN NUMBER, p_nombre NVARCHAR2) IS
  BEGIN
    UPDATE Categorias SET Nombre = p_nombre WHERE CategoriaID = p_categoriaid;
  END;

  PROCEDURE EliminarCategoria(p_categoriaid IN NUMBER) IS
  BEGIN
    DELETE FROM Categorias WHERE CategoriaID = p_categoriaid;
  END;
END pkg_categorias;
/

-- Paquete CRUD para Proveedores
CREATE OR REPLACE PACKAGE pkg_proveedores AS
  PROCEDURE CrearProveedor(p_nombre NVARCHAR2, p_telefono NVARCHAR2, p_direccion NVARCHAR2);
  PROCEDURE LeerProveedor(p_proveedorid IN NUMBER, p_result OUT SYS_REFCURSOR);
  PROCEDURE ActualizarProveedor(p_proveedorid IN NUMBER, p_nombre NVARCHAR2, p_telefono NVARCHAR2, p_direccion NVARCHAR2);
  PROCEDURE EliminarProveedor(p_proveedorid IN NUMBER);
END pkg_proveedores;
/

CREATE OR REPLACE PACKAGE BODY pkg_proveedores AS
  PROCEDURE CrearProveedor(p_nombre NVARCHAR2, p_telefono NVARCHAR2, p_direccion NVARCHAR2) IS
  BEGIN
    INSERT INTO Proveedores (Nombre, Telefono, Direccion) VALUES (p_nombre, p_telefono, p_direccion);
  END;

  PROCEDURE LeerProveedor(p_proveedorid IN NUMBER, p_result OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_result FOR SELECT * FROM Proveedores WHERE ProveedorID = p_proveedorid;
  END;

  PROCEDURE ActualizarProveedor(p_proveedorid IN NUMBER, p_nombre NVARCHAR2, p_telefono NVARCHAR2, p_direccion NVARCHAR2) IS
  BEGIN
    UPDATE Proveedores
    SET Nombre = p_nombre, Telefono = p_telefono, Direccion = p_direccion
    WHERE ProveedorID = p_proveedorid;
  END;

  PROCEDURE EliminarProveedor(p_proveedorid IN NUMBER) IS
  BEGIN
    DELETE FROM Proveedores WHERE ProveedorID = p_proveedorid;
  END;
END pkg_proveedores;
/

-- Paquete CRUD para Productos
CREATE OR REPLACE PACKAGE pkg_productos AS
  PROCEDURE CrearProducto(p_nombre NVARCHAR2, p_precio NUMBER, p_stock NUMBER, p_categoriaid NUMBER, p_proveedorid NUMBER);
  PROCEDURE LeerProducto(p_productoid IN NUMBER, p_result OUT SYS_REFCURSOR);
  PROCEDURE ActualizarProducto(p_productoid IN NUMBER, p_nombre NVARCHAR2, p_precio NUMBER, p_stock NUMBER, p_categoriaid NUMBER, p_proveedorid NUMBER);
  PROCEDURE EliminarProducto(p_productoid IN NUMBER);
END pkg_productos;
/

CREATE OR REPLACE PACKAGE BODY pkg_productos AS
  PROCEDURE CrearProducto(p_nombre NVARCHAR2, p_precio NUMBER, p_stock NUMBER, p_categoriaid NUMBER, p_proveedorid NUMBER) IS
  BEGIN
    INSERT INTO Productos (Nombre, Precio, Stock, CategoriaID, ProveedorID)
    VALUES (p_nombre, p_precio, p_stock, p_categoriaid, p_proveedorid);
  END;

  PROCEDURE LeerProducto(p_productoid IN NUMBER, p_result OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_result FOR SELECT * FROM Productos WHERE ProductoID = p_productoid;
  END;

  PROCEDURE ActualizarProducto(p_productoid IN NUMBER, p_nombre NVARCHAR2, p_precio NUMBER, p_stock NUMBER, p_categoriaid NUMBER, p_proveedorid NUMBER) IS
  BEGIN
    UPDATE Productos
    SET Nombre = p_nombre, Precio = p_precio, Stock = p_stock,
        CategoriaID = p_categoriaid, ProveedorID = p_proveedorid
    WHERE ProductoID = p_productoid;
  END;

  PROCEDURE EliminarProducto(p_productoid IN NUMBER) IS
  BEGIN
    DELETE FROM Productos WHERE ProductoID = p_productoid;
  END;
END pkg_productos;
/

-- Paquete CRUD para Inventario
CREATE OR REPLACE PACKAGE pkg_inventario AS
  PROCEDURE CrearMovimiento(p_productoid NUMBER, p_tipomov NVARCHAR2, p_cantidad NUMBER, p_obs NVARCHAR2);
  PROCEDURE LeerMovimiento(p_inventarioid IN NUMBER, p_result OUT SYS_REFCURSOR);
  PROCEDURE ActualizarMovimiento(p_inventarioid IN NUMBER, p_tipomov NVARCHAR2, p_cantidad NUMBER, p_obs NVARCHAR2);
  PROCEDURE EliminarMovimiento(p_inventarioid IN NUMBER);
END pkg_inventario;
/

CREATE OR REPLACE PACKAGE BODY pkg_inventario AS
  PROCEDURE CrearMovimiento(p_productoid NUMBER, p_tipomov NVARCHAR2, p_cantidad NUMBER, p_obs NVARCHAR2) IS
  BEGIN
    INSERT INTO Inventario (ProductoID, TipoMovimiento, Cantidad, Observaciones)
    VALUES (p_productoid, p_tipomov, p_cantidad, p_obs);
  END;

  PROCEDURE LeerMovimiento(p_inventarioid IN NUMBER, p_result OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_result FOR SELECT * FROM Inventario WHERE InventarioID = p_inventarioid;
  END;

  PROCEDURE ActualizarMovimiento(p_inventarioid IN NUMBER, p_tipomov NVARCHAR2, p_cantidad NUMBER, p_obs NVARCHAR2) IS
  BEGIN
    UPDATE Inventario
    SET TipoMovimiento = p_tipomov, Cantidad = p_cantidad, Observaciones = p_obs
    WHERE InventarioID = p_inventarioid;
  END;

  PROCEDURE EliminarMovimiento(p_inventarioid IN NUMBER) IS
  BEGIN
    DELETE FROM Inventario WHERE InventarioID = p_inventarioid;
  END;
END pkg_inventario;
/

-- Paquete CRUD para Ventas
CREATE OR REPLACE PACKAGE pkg_ventas AS
  PROCEDURE CrearVenta(p_clienteid NUMBER, p_empleadoid NUMBER, p_total NUMBER);
  PROCEDURE LeerVenta(p_ventaid IN NUMBER, p_result OUT SYS_REFCURSOR);
  PROCEDURE ActualizarVenta(p_ventaid IN NUMBER, p_clienteid NUMBER, p_empleadoid NUMBER, p_total NUMBER);
  PROCEDURE EliminarVenta(p_ventaid IN NUMBER);
END pkg_ventas;
/

CREATE OR REPLACE PACKAGE BODY pkg_ventas AS
  PROCEDURE CrearVenta(p_clienteid NUMBER, p_empleadoid NUMBER, p_total NUMBER) IS
  BEGIN
    INSERT INTO Ventas (ClienteID, EmpleadoID, Total)
    VALUES (p_clienteid, p_empleadoid, p_total);
  END;

  PROCEDURE LeerVenta(p_ventaid IN NUMBER, p_result OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_result FOR SELECT * FROM Ventas WHERE VentaID = p_ventaid;
  END;

  PROCEDURE ActualizarVenta(p_ventaid IN NUMBER, p_clienteid NUMBER, p_empleadoid NUMBER, p_total NUMBER) IS
  BEGIN
    UPDATE Ventas
    SET ClienteID = p_clienteid, EmpleadoID = p_empleadoid, Total = p_total
    WHERE VentaID = p_ventaid;
  END;

  PROCEDURE EliminarVenta(p_ventaid IN NUMBER) IS
  BEGIN
    DELETE FROM Ventas WHERE VentaID = p_ventaid;
  END;
END pkg_ventas;
/

-- Paquete CRUD para DetalleVenta
CREATE OR REPLACE PACKAGE pkg_detalleventa AS
  PROCEDURE CrearDetalle(p_ventaid NUMBER, p_productoid NUMBER, p_cantidad NUMBER, p_subtotal NUMBER);
  PROCEDURE LeerDetalle(p_detalleid IN NUMBER, p_result OUT SYS_REFCURSOR);
  PROCEDURE ActualizarDetalle(p_detalleid IN NUMBER, p_cantidad NUMBER, p_subtotal NUMBER);
  PROCEDURE EliminarDetalle(p_detalleid IN NUMBER);
END pkg_detalleventa;
/

CREATE OR REPLACE PACKAGE BODY pkg_detalleventa AS
  PROCEDURE CrearDetalle(p_ventaid NUMBER, p_productoid NUMBER, p_cantidad NUMBER, p_subtotal NUMBER) IS
  BEGIN
    INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, Subtotal)
    VALUES (p_ventaid, p_productoid, p_cantidad, p_subtotal);
  END;

  PROCEDURE LeerDetalle(p_detalleid IN NUMBER, p_result OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_result FOR SELECT * FROM DetalleVenta WHERE DetalleID = p_detalleid;
  END;

  PROCEDURE ActualizarDetalle(p_detalleid IN NUMBER, p_cantidad NUMBER, p_subtotal NUMBER) IS
  BEGIN
    UPDATE DetalleVenta SET Cantidad = p_cantidad, Subtotal = p_subtotal
    WHERE DetalleID = p_detalleid;
  END;

  PROCEDURE EliminarDetalle(p_detalleid IN NUMBER) IS
  BEGIN
    DELETE FROM DetalleVenta WHERE DetalleID = p_detalleid;
  END;
END pkg_detalleventa;
/

