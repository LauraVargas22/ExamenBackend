CREATE DATABASE concesionarioCampusCar;
USE concesionarioCampusCar;

CREATE TABLE concesionario (
    nit INT PRIMARY KEY,
    razon_social VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono INT NOT NULL
);

CREATE TABLE vendedores(
    id INT PRIMARY KEY AUTO_INCREMENT,
    documento_identidad INT NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    nit_concesionario INT NOT NULL,
    CONSTRAINT FOREIGN KEY (nit_concesionario) REFERENCES concesionario(nit)
);

CREATE TABLE vehiculos(
    vin INT PRIMARY KEY UNIQUE,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INT NOT NULL,
    precio FLOAT NOT NULL,
    color VARCHAR(50) NOT NULL,
    estado ENUM('Nuevo', 'Usado') NOT NULL,
    nit_concesionario INT NOT NULL,
    CONSTRAINT FOREIGN KEY (nit_concesionario) REFERENCES concesionario(nit)
);

CREATE TABLE cliente(
    id INT PRIMARY KEY AUTO_INCREMENT,
    documento_identidad INT NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    telefono INT NOT NULL
);

CREATE TABLE servicio(
    id_servicio INT PRIMARY KEY AUTO_INCREMENT,
    tipo_servicio VARCHAR(50) NOT NULL,
    precio_servicio FLOAT NOT NULL
);

CREATE TABLE venta(
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    total_transaccion FLOAT NOT NULL,
    metodo_pago ENUM('Efectivo', 'Tarjeta', 'Transferencia') NOT NULL,
    fecha_venta DATE NOT NULL,
    CONSTRAINT FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    CONSTRAINT FOREIGN KEY (id_vendedor) REFERENCES vendedores(id)
);

CREATE TABLE mantenimiento(
    id_mantenimiento INT PRIMARY KEY AUTO_INCREMENT,
    id_vehiculo INT NOT NULL,
    fecha_servicio DATE NOT NULL,
    costo FLOAT NOT NULL,
    CONSTRAINT FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(vin)
);

CREATE TABLE detalle_mantenimiento(
    id_detalleMantenimiento INT PRIMARY KEY AUTO_INCREMENT,
    id_mantenimiento INT NOT NULL,
    id_servicio INT NOT NULL,
    costo_unitario FLOAT NOT NULL,
    descripcion VARCHAR(50),
    CONSTRAINT FOREIGN KEY (id_mantenimiento) REFERENCES mantenimiento(id_mantenimiento),
    CONSTRAINT FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);

