-- Crear la base de datos "prueba" 
CREATE DATABASE Arcor;

-- Usar la base arcor
USE arcor;

-- Tabla: CLIENTES, Datos de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(30) NOT NULL,
    numero_contacto INT NOT NULL,
    tipo_documento VARCHAR(3) DEFAULT 'DNI',
    direccion VARCHAR(30) NOT NULL,
    codigo_postal VARCHAR(30) NOT NULL,
    pais TEXT NOT NULL
);

-- Tabla: empleados, Datos de los empleados
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_ingreso_kompany TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: shippers, Datos de los shippers
CREATE TABLE shippers (
    id_shipper INT AUTO_INCREMENT PRIMARY KEY,
    shipper_name VARCHAR(30) NOT NULL,
    numero_contacto INT NOT NULL
);

-- Tabla: proveedores, Datos del proveedor
CREATE TABLE proveedores (
    id_proveedores INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(30) NOT NULL,
    numero_proveedor INT NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    ciudad TEXT NOT NULL,
    codigo_postal VARCHAR(30) NOT NULL,
    pais TEXT NOT NULL,
    telefono INT NOT NULL
);

-- Tabla: categorias, Datos de las categorias
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(30) NOT NULL,
    descripcion VARCHAR(30) NOT NULL
);

-- Tabla: productos, Datos de los productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(40) NOT NULL,
    id_proveedor INT NOT NULL,
    id_categoria INT NOT NULL,
    precio DECIMAL (4,2),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedores),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Tabla: orders, Datos de las ordenes
CREATE TABLE orders (
    id_orders INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    id_shipper INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_shipper) REFERENCES shippers(id_shipper)
);


-- Tabla: detalles_ordenes, Detalles de las ordenes
CREATE TABLE detalles_ordenes (
    id_detalle_ordenes INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    FOREIGN KEY (id_orden) REFERENCES orders(id_orders),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla ventas
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_order INT NOT NULL,
    id_empleado INT NOT NULL,
    id_cliente INT NOT NULL,  -- Agregamos la columna id_cliente
    fecha_venta DATE NOT NULL,
    total_venta DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_order) REFERENCES orders(id_orders),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)  -- Relación con la tabla clientes

);

-- Se agrega una nueva columna a la tabla ventas 

ALTER TABLE ventas 
ADD estado_venta VARCHAR(20);



-- Tabla devoluciones
CREATE TABLE devoluciones (
      id_devolucion INT AUTO_INCREMENT PRIMARY KEY,
      id_venta INT NOT NULL,
      id_producto INT NOT NULL,
      id_cliente INT NOT NULL,
      fecha_devolucion DATE NOT NULL,
      motivo_devolucion TEXT,
      FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
      FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
      FOREIGN KEY (id_cliente)REFERENCES clientes(id_cliente)
      );


CREATE TABLE Sueldos (
    id_sueldo INT AUTO_INCREMENT PRIMARY KEY,
    monto_sueldo DECIMAL(10, 2), 
    id_empleado INT,
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);



 
  
-- Apartado de vistas 
-- Primera vista Productos por Categoría #1
CREATE VIEW vista_productos_por_categoria AS
SELECT p.nombre_producto, c.nombre_categoria
FROM productos p
INNER JOIN categorias c ON p.id_categoria = c.id_categoria;

-- Segunda vista Clientes en Venezuela #2
CREATE VIEW vista_clientes_venezuela AS
SELECT *
FROM clientes
WHERE pais = 'venezuela';

-- Tercera vista: Detalles de Órdenes con Nombres de Productos #3
CREATE VIEW vista_detalles_ordenes_productos AS
SELECT do.id_orden, p.nombre_producto
FROM detalles_ordenes do
INNER JOIN productos p ON do.id_producto = p.id_producto;

-- Cuarta vista Clientes con Órdenes #4
CREATE VIEW vista_clientes_con_ordenes AS
SELECT c.id_cliente, c.nombre_cliente, 
       (SELECT COUNT(*) FROM orders o WHERE o.id_cliente = c.id_cliente) AS cantidad_ordenes
FROM clientes c;

-- Quinta vista Proveedores con Más Demanda #5
CREATE VIEW vista_proveedores_con_mas_demanda AS
SELECT pr.id_proveedores, pr.nombre_proveedor, 
       (SELECT COUNT(*) FROM detalles_ordenes do
        INNER JOIN productos p ON do.id_producto = p.id_producto
        WHERE p.id_proveedor = pr.id_proveedores) AS cantidad_productos
FROM proveedores pr
ORDER BY cantidad_productos DESC
LIMIT 5;

  -- Apartado de store procedure
DELIMITER //

-- Este procedimiento devuelve la cantidad de clientes cuyos nombres contienen una letra dada.
CREATE PROCEDURE arcor.cantidad_x_letra(IN letra CHAR(30))
BEGIN
    SELECT COUNT(*)
    FROM clientes
    WHERE nombre_cliente LIKE CONCAT('%', letra, '%');
END;
//

DELIMITER ;

-- Para llamar al procedimiento almacenado
CALL arcor.cantidad_x_letra('A');

DELIMITER //

-- Este procedimiento ordena una tabla por un campo dado en orden ascendente o descendente.
CREATE PROCEDURE arcor.OrdenarTabla(
    IN tabla_nombre VARCHAR(50),   -- Nombre de la tabla a ordenar
    IN campo_orden VARCHAR(50),   -- Campo por el cual ordenar
    IN orden VARCHAR(10)          -- Orden ('ASC' para ascendente, 'DESC' para descendente)
)
BEGIN
    -- Construir la consulta dinámica utilizando los parámetros
    SET @mi_query = CONCAT('SELECT * FROM ', tabla_nombre, ' ORDER BY ', campo_orden, ' ', orden);

    -- Preparar la consulta 
    PREPARE stmt FROM @mi_query;
    
    -- Ejecutar la consulta preparada
    EXECUTE stmt;
    
    -- Liberar la memoria utilizada por la consulta preparada
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- Para llamar al procedimiento que ordena la tabla "clientes" por "nombre_cliente" en orden ascendente
CALL arcor.OrdenarTabla('clientes', 'nombre_cliente', 'ASC');


DELIMITER //

-- Este procedimiento actualiza los precios de los productos de una categoría dada.
-- El codigo se llama directamente en el apartado de stored proceudre
CREATE PROCEDURE arcor.actualizacion_precio(IN id_categoria INT)
BEGIN
    -- Declarar una variable local para almacenar el nuevo precio calculado
    DECLARE nuevo_precio DECIMAL(10, 2);

    -- Calcular el nuevo precio
    SET nuevo_precio = (SELECT precio * 1.05 FROM productos WHERE id_categoria = id_categoria);

    -- Actualizar el precio en la tabla de productos
    UPDATE productos
    SET precio = nuevo_precio
    WHERE id_categoria = id_categoria;
END;
//

DELIMITER ;



-- Apartado de funciones 
DELIMITER //

-- Función para calcular el 21% de IVA
CREATE FUNCTION `Arcor`.`iva_21`(monto DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN 
    DECLARE iva DECIMAL(10, 2);
    SET iva = monto * 0.21;
    RETURN iva;
END //

DELIMITER ;

-- Se llama la función para calcular el 21% de IVA
SELECT Arcor.iva_21(488.00) AS iva_calculado;

DELIMITER //

-- Función para calcular el precio neto a partir del precio con IVA
CREATE FUNCTION `Arcor`.`precio_neto`(monto DECIMAL(10, 2)) 
RETURNS DECIMAL(10, 2) 
DETERMINISTIC
BEGIN 
    DECLARE precio_neto DECIMAL(10, 2);
    SET precio_neto = monto / 1.21;
    RETURN precio_neto;
END //

DELIMITER ;

-- Se llama la función para calcular el precio neto
SELECT Arcor.precio_neto(121.00) AS precio_neto_calculado;

DELIMITER //

-- Función que devuelve el país con la mayor cantidad de clientes
CREATE FUNCTION `Arcor`.`paises_clientes`()
RETURNS VARCHAR(30) 
CHARSET utf8mb4 
READS SQL DATA
BEGIN 	
    DECLARE paises_con_mas_clientes VARCHAR(30);
    SELECT pais 
    INTO paises_con_mas_clientes 
    FROM (
        SELECT pais, COUNT(*) AS cantidad_clientes
        FROM clientes
        GROUP BY pais
        ORDER BY cantidad_clientes DESC 
        LIMIT 1
    ) AS paises_con_clientes
    LIMIT 1;
    RETURN paises_con_mas_clientes;
END //

DELIMITER ;

-- Llamada a la función para obtener el país con más clientes
SELECT Arcor.paises_clientes() AS pais_con_mas_clientes; 

DELIMITER //

-- Función que calcula la edad de un empleado a partir de su fecha de nacimiento
CREATE FUNCTION `Arcor`.`edad_empleados`(fecha_nacimiento DATE) 
RETURNS INT READS SQL DATA
BEGIN 
    DECLARE edad INT;
    SET edad = TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE());
    RETURN edad;
END //

DELIMITER ;

-- Se calcula la edad de un empleado a partir de su fecha de nacimiento
SELECT Arcor.edad_empleados('1995-05-15') AS edad_calculada;


-- Aparato triggers 
-- Tabla log registros de bitácora para proveedores
CREATE TABLE proveedores_log (
    id_log INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    nombre_usuario VARCHAR(30) NOT NULL,
    id_proveedor INT NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedores)
);


-- Crear el trigger AFTER INSERT en la tabla proveedores
CREATE TRIGGER log_proveedores
AFTER INSERT ON proveedores
FOR EACH ROW
    -- Insertar en la tabla proveedores_log los detalles de la inserción en la tabla proveedores
    INSERT INTO proveedores_log (fecha_hora, nombre_usuario, id_proveedor)
    VALUES (NOW(), CURRENT_USER(), NEW.id_proveedores);

-- Se ejecuta el insert de prueba
INSERT INTO proveedores (nombre_proveedor, numero_proveedor, direccion, ciudad, codigo_postal, pais, telefono)
VALUES ('bokem', 98743, 'Avenida figueroa alcorta 1906', 'buenos aires', '0685', 'argentina', '4441567');

-- Verifico si el proveedor se ejecuto con claridad
SELECT *
FROM proveedores;

-- Ejecuto este query que me dicta el id del proveedor y el usuario que lo ejecuto 
SELECT * 
FROM proveedores_log;

-- Esta tabla se adaptara como tabla bitacora
CREATE TABLE IF NOT EXISTS ordenes_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_order INT NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    id_shipper INT NOT NULL,
    transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(255),
    FOREIGN KEY (id_order) REFERENCES orders(id_orders),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_shipper) REFERENCES shippers(id_shipper)
);

-- Crea el trigger AFter INSERT en la tabla orders
DELIMITER //

CREATE TRIGGER orders_transaction_log
AFTER INSERT ON orders FOR EACH ROW
BEGIN
    INSERT INTO ordenes_log (id_order, id_cliente, id_empleado, id_shipper, transaction_time, description)
    VALUES (NEW.id_orders, NEW.id_cliente, NEW.id_empleado, NEW.id_shipper, NOW(), 'Nueva orden creada');
END;
//

DELIMITER ;

-- Insertar una nueva orden en la tabla "orders"
INSERT INTO orders (id_cliente, id_empleado, id_shipper)
VALUES (1, 2, 3);


-- Consultar el registro de transacciones en la tabla "ordenes_log"
SELECT * FROM ordenes_log;



-- Crear el trigger BEFORE INSERT en la tabla productos
DELIMITER //
CREATE TRIGGER validar_producto_existente BEFORE INSERT ON productos
FOR EACH ROW
BEGIN
    -- Variable para almacenar la cantidad de productos con el mismo nombre
    DECLARE producto_existente INT;
    -- Verificar si el producto ya existe en la tabla con una sub-consulta
    SELECT COUNT(*) INTO producto_existente FROM productos WHERE nombre_producto = NEW.nombre_producto;
    -- Si el producto ya existe, lanzar un error
    IF producto_existente > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Producto ya existe en la base de datos';
    END IF;
END;
//
DELIMITER ;


-- Prueba de ejecucion del producto que ya se encuentra en la tabla PRODUCTOS
INSERT INTO productos (nombre_producto, id_proveedor, id_categoria, precio)
VALUES ('Auriculares inalámbricos', 82, 2, 91.98);




-- Apartado de commit,rolback y savepoint
-- Tabla: proyectos, Datos de los proyectos
CREATE TABLE proyectos (
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proyecto VARCHAR(50) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    responsable VARCHAR(30)
);

-- Empezamos con la transacción de registros utilizando ROLLBACK Y COMMIT
START TRANSACTION;

INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, responsable)
VALUES
    ('Proyecto de Desarrollo Web', 'Desarrollo de un sitio web corporativo.', '2023-09-01', '2023-12-15', 'Ana Pérez'),
    ('Implementación de ERP', 'Implementación de un sistema de planificación de recursos empresariales.', '2023-10-15', '2024-03-31', 'Juan García'),
    ('Investigación de Mercado', 'Realización de un estudio de mercado para lanzamiento de un nuevo producto.', '2023-11-05', '2023-11-30', 'María López'),
    ('Rediseño de Logo', 'Rediseño del logotipo de la empresa.', '2023-09-15', '2023-09-30', 'Carlos Martínez'),
    ('Proyecto de Infraestructura', 'Implementación de nueva infraestructura de red y servidores.', '2023-10-01', '2024-01-31', 'Luis Torres'),
    ('Desarrollo de App Móvil', 'Creación de una aplicación móvil para clientes.', '2023-12-01', '2024-06-30', 'Laura Ramírez'),
    ('Campaña de Marketing', 'Ejecución de una campaña publicitaria en redes sociales.', '2023-11-15', '2023-12-15', 'Javier Rodríguez'),
    ('Proyecto de Capacitación', 'Organización de cursos de capacitación para empleados.', '2023-10-01', '2023-11-15', 'Isabel Gómez');

-- ROLLBACK;

-- COMMIT;

SELECT *
FROM proyectos;

-- Comienza la transacción 
START TRANSACTION;

-- Empieza el insert de prueba
INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, responsable)
VALUES ('Proyecto E', 'Desarrollo de plataforma e-learning', '2023-10-10', '2024-02-28', 'Ana López');
INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, responsable)
VALUES ('Proyecto F', 'Diseño de campaña publicitaria', '2023-11-15', '2023-12-31', 'Carlos Ramírez');
INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, responsable)
VALUES ('Proyecto G', 'Implementación de sistema logístico', '2023-12-01', '2024-03-15', 'Luisa Martínez');
INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, responsable)
VALUES ('Proyecto H', 'Investigación en inteligencia de negocios', '2023-09-20', '2023-11-30', 'María Sánchez');

SAVEPOINT primeros_cuatro;

INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, responsable)
VALUES ('Proyecto A', 'Desarrollo de aplicación móvil', '2023-09-01', '2023-12-15', 'David García');
INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, responsable)
VALUES ('Proyecto B', 'Diseño de sitio web interactivo', '2023-10-15', '2023-12-31', 'Sofía Rodríguez');
INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, responsable)
VALUES ('Proyecto C', 'Implementación de sistema de ventas', '2023-11-01', '2024-04-15', 'Juan Pérez');
INSERT INTO proyectos (nombre_proyecto, descripcion, fecha_inicio, fecha_fin, responsable)
VALUES ('Proyecto D', 'Investigación en tecnologías emergentes', '2023-12-20', '2024-03-31', 'Laura Fernández');

-- En este rollback to se llaman a los primeros 4 registros
ROLLBACK TO primeros_cuatro;

-- Se dan por sentados los primeros 4 registros mientras que los otros 4 quedan descartados
COMMIT;

SELECT * 
FROM proyectos;


-- Apartado de permisos

-- Creando usurarios #1
CREATE USER 'julio'@'localhost' IDENTIFIED BY '123';

#3
CREATE USER 'valentin'@'localhost' IDENTIFIED BY '321';

#4
CREATE USER 'cesar'@'localhost' IDENTIFIED BY '852';


-- Modificacion de una contraseña ejemplo 
ALTER USER 'julio'@'localhost' IDENTIFIED BY '098';


-- Otorgando permisos sobre usuarios 

-- Este ususario solo tendra permisos de lectura sobre toda la DB Arcor
GRANT SELECT ON arcor.*
TO 'julio'@'localhost' ;


-- Este usuario tiene todoa los permisos sobre la DB Arcor
GRANT ALL ON  *.* TO 'valentin'@'localhost';

-- Este usuario solo tiene permisos de lectura,insertar y modificar
GRANT SELECT, INSERT, UPDATE ON arcor.* TO 'cesar'@'localhost';





SELECT * FROM
 mysql.user;
