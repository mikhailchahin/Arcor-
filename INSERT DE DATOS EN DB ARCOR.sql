USE Arcor;

-- 1. Insertar datos en la tabla "categorias"
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion)
VALUES
    (2, 'electronica', 'Smartphone alta resolución'),
    (3, 'ropa', 'Camiseta algodón estampada'),
    (4, 'hogar', 'Sabanas'),
    (5, 'alimentos', 'Enlatados'),
    (6, 'belleza', 'Cremas humectantes');

-- 2. Insertar datos en la tabla "proveedores"
INSERT INTO proveedores (nombre_proveedor, numero_proveedor, direccion, ciudad, codigo_postal, pais, telefono)
VALUES
     ('tecnoelectro', 6789, 'santo tome 456', 'yucatan', '12345', 'mexico', 5551567),
     ('modae stampada', 987654321, 'Calle de venganza 146', 'ciudad de mexico', '54321', 'mexico', 7776543),
     ('Hogarcomfort', 456789123, 'Descanso 8', 'Lima', '67890', 'Peru', 22291234),
     ('bellezatosmeti', 987, 'Calle de la Elegancia 333', 'san jose', '24680', 'costa rica', 8889321),
     ('fashiontrends', 654987321, 'Paseo de la reconquista 777', 'caracas', '56789', 'venezuela', 1119876),
     ('electrotech', 987321654, 'av directorio 1900', 'quito', '13579', 'ecuador', 6667321),
     ('serenisima', 456789123, 'panamerica km 84', 'buenos aires', '88888', 'argentina', 3336789),
     ('deli fresh', 123987456, 'avenida de los Alimentos 666', 'montevideo', '98765', 'uruguay', 4443987),
     ('comercial la lucha', 9313339, 'av antonio de berrios local °5', 'ciudad guayana', '41485', 'venezuela', 286914545),
     ('decocenter SA', 416686, 'av anotio de berrios local °4', 'ciudad guayana', '8563', 'venezuela', 416686504);


-- 3. Insertar datos en la tabla "empleados"
INSERT INTO empleados (nombre, apellido, fecha_nacimiento, fecha_ingreso_kompany)
VALUES
    ('luis', 'hernandez', '2000-05-13', '2022-05-13 00:00:00'),
    ('sofia', 'gomez', '1997-11-20', '2021-11-05 00:00:00'),
    ('camila', 'guzman', '2002-08-15', '2023-01-31 00:00:00'),
    ('santiago', 'rios', '2000-05-25', '2002-06-25 00:00:00'),
    ('camila', 'guzman', '1999-01-28', '2021-05-25 00:00:00'),
    ('alejandro', 'mendoza', '1985-10-10', '2023-03-03 00:00:00');

-- 4. Insertar datos en la tabla "shippers"
INSERT INTO shippers (shipper_name, numero_contacto)
VALUES
    ('envios rapidos', 123456),
    ('transporte expresso', 234567),
    ('logistica aegil', 345678),
    ('carga segura', 456789),
    ('envio agil', 567890);

-- 5. Insertar datos en la tabla "clientes"
INSERT INTO clientes (nombre_cliente, numero_contacto, tipo_documento, direccion, codigo_postal, pais)
VALUES
    ('ryan', 1151171830, 'DNI', '5613 Linden Drive', '15089', 'china'),
    ('daron', 1151171855, 'DNI', '85212 Northview Junction', '27812', 'china'),
    ('Cynthea', 1151172068, 'DNI', '1655 Mariners Cove Point', '93650', 'polonia'),
    ('Jilly', 1151201477, 'CDI', '25 Corben Way', '54073', 'camerun'),
    ('jose', 1151224469, 'CDI', '96 Bashford Point', '82599', 'rusia'),
    ('juan', 1151224469, 'DNI', '96 Bashford Point', '31946', 'venezuela'),
    ('luis', 1151214844, 'CDI', '5 Tomscot Plaza', '41529', 'nepal'),
    ('rosario', 1151232748, 'DNI', '77777 Arrowood Alley', '93650', 'francia'),
    ('norkis', 1151171820, 'CDI', 'larrea 1383', '41960', 'argentina'),
    ('esther', 1151171855, 'DNI', 'viamonte 1819', '75415', 'colombia'),
    ('alejandro', 113018517, 'DNI', 'nogoya 1076', '75416', 'ecuador'),
    ('dexter', 1151218743, 'CDI', 'sarmiento 874', '75820', 'uruguay'),
    ('raquel', 1151186935, 'DNI', 'sarmiento 872', '93193', 'brasil'),
    ('messi', 1151225719, 'DNI', 'rosario 2030', '95193', 'argentina'),
    ('aguero', 1151231383, 'DNI', 'bolivar 1900', '9323', 'argentina'),
    ('nellys', 1173677222, 'CDI', 'mendoza 3500', '70439', 'venezuela'),
    ('raed', 1151246673, 'CDI', 'pto ordaz 1200', '37236', 'siria'),
    ('Salim', 1151230633, 'DNI', '5831 Jay Alley', '28618', 'egipto');

-- 6. Insertar datos en la tabla "productos"
INSERT INTO productos (nombre_producto, id_proveedor, id_categoria, precio)
VALUES 
    ('Auriculares inalámbricos', 1, 2, 79.98),
    ('Smartwatch con monitor de ritmo cardíaco', 1, 2, 12.99),
    ('Camisa de lino estampada', 2, 3, 49.50),
    ('Set de cuchillos de cocina', 3, 4, 89.75),
    ('Sardinas en conserva', 8, 5, 4.99),
    ('Crema antiarrugas de colágeno', 4, 6, 34.90),
    ('Auriculares bluetooth deportivos', 1, 2, 59.99),
    ('Vestido de fiesta con lentejuelas', 4, 3, 89.99),
    ('Juego de ollas antiadherentes', 3, 4, 20.50),
    ('Cereal de desayuno con frutas', 8, 5, 6.75),
    ('Crema hidratante con vitamina E', 4, 6, 19.95),
    ('Altavoz bluetooth resistente al agua', 6, 2, 49.99),
    ('Jeans de corte recto para hombre', 10, 3, 39.90),
    ('Vajilla de porcelana para 6 personas', 10, 4, 99.75),
    ('Atún en aceite de oliva', 8, 5, 5.50),
    ('Crema reafirmante para el cuerpo', 4, 6, 29.90);

-- 7. Insertar datos en la tabla "orders"
INSERT INTO orders 
VALUES
    (NULL,1,1,1),
    (NULL,2,3,2),
    (NULL,3,4,3),
    (NULL,4,2,4),
    (NULL,6,6,5),
    (NULL,11,5,1),  
	(NULL,6,6,5),
	(NULL,8,3,3),
    (NULL,2,4,2),
    (NULL,12,1,3),
    (NULL,1,6,2),
	(NULL,1,6,2),
    (NULL,5,4,5),
	(NULL,2,3,3),
	(NULL,2,4,1),
	(NULL,16,2,4),
	(NULL,17,3,1),
	(NULL,8,4,3),
    (NULL,2,1,2);
    
    
    

-- 8. Insertar datos en la tabla "detalles_ordenes"
INSERT INTO detalles_ordenes 
VALUES
    (NULL,1,1),   
    (NULL,2,3),   
    (NULL,2,4),   
    (NULL,3,5),   
    (NULL,3,6),  
    (NULL,4,7),   
    (NULL,5,8),   
    (NULL,6, 9), 
    (NULL,7,10), 
    (NULL,8,11),  
    (NULL,9,12), 
    (NULL,10,13),
    (NULL,11,14), 
    (NULL,12,15), 
    (NULL,13,16),
    (NULL,14,16), 
    (NULL,15,7), 
    (NULL,16,15), 
    (NULL,16,1) 
;


-- 9. Insertar datos en la tabla "ventas"
INSERT INTO ventas (id_order, id_empleado, id_cliente, fecha_venta, total_venta)
VALUES
   (1, 2, 1, '2023-09-20', 115.25),
   (2, 3, 10, '2023-09-21', 89.99),
   (3, 4, 11, '2023-09-22', 155.50),
   (4, 5, 12, '2023-09-23', 73.45),
   (5, 6, 13, '2023-09-24', 145.75),
   (6, 1, 14, '2023-09-25', 68.60),
   (7, 2, 15, '2023-09-26', 92.25),
   (8, 3, 2, '2023-09-27', 123.90),
   (9, 4, 5, '2023-09-28', 76.25),
   (10, 5, 13, '2023-09-29', 135.00),
   (11, 6, 15, '2023-09-30', 88.25),
   (12, 1, 2, '2023-10-01', 155.75),
   (13, 2, 7, '2023-10-02', 105.60),
   (14, 3, 9, '2023-10-03', 68.99),
   (15, 4, 13, '2023-10-04', 112.75),
   (16, 5, 4, '2023-10-05', 95.90),
   (15, 6, 2, '2023-10-06', 120.45),
   (12, 1, 15, '2023-10-07', 145.75),
   (1, 2, 1, '2023-10-08', 78.60),
   (8, 3, 2, '2023-10-09', 98.25);


-- 10. Actualizar la columna "estado_venta" en la tabla "ventas"
UPDATE ventas
SET estado_venta = 'completado'
WHERE id_venta IN(9,2,4,7,5,6,3,1,8,19,20);

UPDATE ventas
SET estado_venta = 'devuelto,vencido'
WHERE id_venta IN (10,11,19,18,17,16,13,15,14,12);

-- 11 insertando los datos en la tabla de devoluciones
INSERT INTO devoluciones (id_venta, id_cliente, id_producto, fecha_devolucion, motivo_devolucion)
VALUES
  (6, 2, 8, '2023-09-10', 'producto incorrecto'),
  (7, 3, 10, '2023-09-11', 'defectuoso'),
  (8, 4, 12, '2023-09-12', 'no era lo que esperaba'),
  (9, 5, 14, '2023-09-13', 'inconforme'),
  (10, 6, 16, '2023-09-14', 'en mal estado'),
  (11, 7, 3, '2023-09-15', 'producto incorrecto'),
  (12, 8, 15, '2023-09-16', 'defectuoso'),
  (13, 9, 14, '2023-09-17', 'no era lo que esperaba'),
  (14, 10, 2, '2023-09-18', 'inconforme'),
  (15, 11, 6, '2023-09-19', 'en mal estado');
  
  
  -- #12 Insertar datos de sueldo 
INSERT INTO Sueldos (monto_sueldo, id_empleado)
VALUES
    (2200.00, 1),
    (2450.50, 2),
    (2650.75, 3),
    (2300.25, 4),
    (2550.00, 5),
    (2750.50, 6);

  
  
  

