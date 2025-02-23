-- Seleccionar toda la tabla de ventas de pizzas
-- SELECT * FROM ventas_pizzas;

/*------------ KPI's ------------*/

-- 1) Ingresos Totales
SELECT
    SUM(precio_total) AS ingresos_totales
FROM 
    ventas_pizzas;

-- 2) Valor Promedio por Pedido
SELECT
    SUM(precio_total) / COUNT(DISTINCT id_pedido) AS valor_promedio_pedido
FROM
    ventas_pizzas;

-- 3) Total de Pizzas Vendidas
SELECT
    SUM(cantidad) AS total_pizzas_vendidas
FROM
    ventas_pizzas;

-- 4) Total de Pedidos
SELECT
    COUNT(DISTINCT id_pedido) AS total_pedidos
FROM
    ventas_pizzas;

-- 5) Promedio de Pizzas por Pedido
SELECT
    ROUND(
        ROUND(SUM(cantidad),2) / ROUND(COUNT(DISTINCT id_pedido),2), 2
    ) AS promedio_pizzas_por_pedido
FROM
    ventas_pizzas;

/*------------------------------------------------------------------------------*/

-- 6) Tendencia Diaria de Pedidos Totales
SELECT
    TO_CHAR(fecha, 'Day') AS dia_pedido,
    COUNT(DISTINCT id_pedido) AS total_pedidos
FROM
    ventas_pizzas
GROUP BY
    dia_pedido
ORDER BY
    total_pedidos DESC;

-- 7) Tendencia Mensual de Pedidos Totales
SELECT
    TO_CHAR(fecha, 'Month') AS nombre_mes,
    COUNT(DISTINCT id_pedido) AS total_pedidos
FROM
    ventas_pizzas
GROUP BY
    nombre_mes
ORDER BY 
    total_pedidos DESC;

-- 8) % de Ventas por Categoria de Pizza
SELECT
    categoria,
    ROUND(SUM(precio_total) * 100 / (SELECT SUM(precio_total) FROM ventas_pizzas), 2) 
    AS porcentaje_ventas
FROM
    ventas_pizzas
GROUP BY
    categoria;

-- 9) % de Ventas por Tamano de Pizza
SELECT 
    tamano, 
    ROUND(SUM(precio_total) * 100 / (SELECT SUM(precio_total) FROM ventas_pizzas), 2) 
    AS porcentaje_ventas
FROM
    ventas_pizzas
GROUP BY
    tamano
ORDER BY
    porcentaje_ventas DESC;

-- 10) Top 5 Pizzas Mas Vendidas por Ingresos
SELECT
    nombre_pizza, SUM(precio_total) AS ingresos_totales
FROM
    ventas_pizzas
GROUP BY 
    nombre_pizza
ORDER BY
    ingresos_totales DESC
LIMIT 5;

-- 11) Bottom 5 Pizzas Menos Vendidas por Ingresos
SELECT
    nombre_pizza, SUM(precio_total) AS ingresos_totales
FROM
    ventas_pizzas
GROUP BY 
    nombre_pizza
ORDER BY
    ingresos_totales
LIMIT 5;

-- 12) Top 5 Pizzas Mas Vendidas por Cantidad
SELECT
    nombre_pizza, SUM(cantidad) AS cantidad_total
FROM
    ventas_pizzas
GROUP BY 
    nombre_pizza
ORDER BY
    cantidad_total DESC
LIMIT 5;

-- 13) Bottom 5 Pizzas Menos Vendidas por Cantidad
SELECT
    nombre_pizza, SUM(cantidad) AS cantidad_total
FROM
    ventas_pizzas
GROUP BY 
    nombre_pizza
ORDER BY
    cantidad_total
LIMIT 5;

-- 14) Top 5 Pizzas Mas Vendidas por Pedidos Totales
SELECT
    nombre_pizza, COUNT(DISTINCT id_pedido) AS total_pedidos
FROM
    ventas_pizzas
GROUP BY 
    nombre_pizza
ORDER BY
    total_pedidos DESC
LIMIT 5;

-- 15) Bottom 5 Pizzas Menos Vendidas por Pedidos Totales
SELECT
    nombre_pizza, COUNT(DISTINCT id_pedido) AS total_pedidos
FROM
    ventas_pizzas
GROUP BY 
    nombre_pizza
ORDER BY
    total_pedidos
LIMIT 5;

-- 16) Numero de Clientes por Dia y Horas Mas Ocupadas
SELECT
    fecha,
    COUNT(DISTINCT id_pedido) AS num_clientes
FROM
    ventas_pizzas
GROUP BY
    fecha
ORDER BY
    fecha;

SELECT
    EXTRACT(HOUR FROM hora) AS hora_pedido,
    COUNT(DISTINCT id_pedido) AS num_pedidos
FROM
    ventas_pizzas
GROUP BY
    hora_pedido
ORDER BY
    num_pedidos DESC;

-- 17) Tendencias Estacionales
SELECT
    EXTRACT(MONTH FROM fecha) AS mes,
    COUNT(DISTINCT id_pedido) AS total_pedidos
FROM
    ventas_pizzas
GROUP BY
    mes
ORDER BY
    mes;

-- 18) Promedio de Pedidos Diarios
WITH pedidos_diarios AS (
    SELECT
        fecha,
        COUNT(DISTINCT id_pedido) AS total_pedidos_diarios
    FROM
        ventas_pizzas
    GROUP BY
        fecha
)
SELECT
    AVG(total_pedidos_diarios) AS promedio_pedidos_dia
FROM
    pedidos_diarios;

-- 19) Promedio de Pizzas Vendidas por Dia
WITH promedio_pizza AS (
    SELECT fecha,
           COUNT(cantidad) AS pizzas_diarias
    FROM ventas_pizzas
    GROUP BY fecha
)
SELECT
    AVG(pizzas_diarias) AS promedio_pizzas_dia
FROM promedio_pizza;


