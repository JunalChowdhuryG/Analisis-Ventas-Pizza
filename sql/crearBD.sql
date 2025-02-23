
-- Eliminar la base de datos si ya existe
DROP DATABASE IF EXISTS "ventas_de_pizzas";

-- Crear la base de datos
CREATE DATABASE "ventas_de_pizzas"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Conectarse a la base de datos
\c ventas_de_pizzas;

-- Crear la tabla de ventas de pizzas
CREATE TABLE ventas_pizzas (
    id_venta SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_pizza VARCHAR(50),
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    precio_total DECIMAL(10, 2) NOT NULL,
    tamano VARCHAR(3) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    ingredientes TEXT NOT NULL,
    nombre_pizza VARCHAR(100) NOT NULL
);

-- Cargar datos desde un archivo CSV
COPY ventas_pizzas(id_venta, id_pedido, id_pizza, cantidad, fecha, hora, precio_unitario, precio_total, tamano, categoria, ingredientes, nombre_pizza)
FROM '../datos/ventas_pizzas.csv'
DELIMITER ','
CSV HEADER;


