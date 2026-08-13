
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nivel ENUM('NORMAL', 'PLATINUM', 'GOLD') DEFAULT 'NORMAL', #Se guarda como dato en usuario y se calcula cada cierto tiempo para mantenerlo actualizado, porque sino se debería calcularlo cada vez que se requiera.
    reputacion DECIMAL(5,2) DEFAULT 0.00, #Yo diría que sea un dato en usuario. El cual se actualiza cada cierto tiempo o cada que se realiza una transaccion, si fuese un calculo en lugar de un dato guardado, se tendría que calcular la reputacion cada que se requiera.
    cantidad_ventas INT DEFAULT 0,
    facturacion DECIMAL(15,2) DEFAULT 0.00,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);

#son una unidad por publicación.
CREATE TABLE publicaciones (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_categoria INT NOT NULL,
    id_usuario_vendedor INT NOT NULL,
    precio DECIMAL(15,2) NOT NULL,
    nivel_publicacion ENUM('BRONCE', 'PLATA', 'ORO', 'PLATINO') NOT NULL DEFAULT 'BRONCE', #yo diría que sea un campo de publicacion. Esto para que sea más facil el ordenarlos segun el nivel de publicacion. Osea que no se tenga que acceder a otra tabla por cada publicacion para obtener un solo valor.
    estado ENUM('ACTIVA', 'FINALIZADA') NOT NULL DEFAULT 'ACTIVA',
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_finalizacion DATETIME NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_usuario_vendedor) REFERENCES usuarios(id_usuario)
);

#dos distintos para poder distinguir facilmente una de la otra, si estuvieran las dos en una sería dificil saber si es una subasta o una venta directa.

CREATE TABLE ventas_directas (
    id_publicacion INT PRIMARY KEY,
    FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion)
);


#no, simplemente que guarde la oferta más grande y listo. Como tal no nos sirve almacenar datos sobre el historial de pujas sobre una subasta, en el caso de se requiera en el futuro una funcionalidad relacionada a eso se implementará.
CREATE TABLE subastas (
    id_publicacion INT PRIMARY KEY,
    oferta_maxima DECIMAL(15,2) NULL,
    id_usuario_ofertante INT NULL,
    FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion),
    FOREIGN KEY (id_usuario_ofertante) REFERENCES usuarios(id_usuario)
);

#Yo diria que sean separados. Ya que si se hacen juntos quedaría el espacio de respuesta vacío hasta que se responda, además de que puede llevar a casos donde una pregunta esté vacia pero la respuesta no.
CREATE TABLE preguntas (
    id_pregunta INT AUTO_INCREMENT PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    pregunta TEXT NOT NULL,
    fecha_pregunta DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE respuestas (
    id_respuesta INT AUTO_INCREMENT PRIMARY KEY,
    id_pregunta INT NOT NULL UNIQUE,
    id_usuario_vendedor INT NOT NULL,
    respuesta TEXT NOT NULL,
    fecha_respuesta DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta),
    FOREIGN KEY (id_usuario_vendedor) REFERENCES usuarios(id_usuario)
);
# sirve para mantener un historial de transacciones de un usuario o vendedor
CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario_comprador INT NOT NULL,
    id_usuario_vendedor INT NOT NULL,
    monto DECIMAL(15,2) NOT NULL,
    medio_pago ENUM('TARJETA_CREDITO', 'TARJETA_DEBITO', 'PAGO_FACIL', 'RAPIPAGO') NOT NULL,
    medio_envio ENUM('OCA', 'CORREO_ARGENTINO') NOT NULL,
    estado ENUM('PENDIENTE', 'CONCRETADA', 'CANCELADA') NOT NULL DEFAULT 'PENDIENTE',
    fecha_transaccion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion),
    FOREIGN KEY (id_usuario_comprador) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_usuario_vendedor) REFERENCES usuarios(id_usuario)
);
CREATE TABLE calificaciones (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_transaccion INT NOT NULL,
    id_usuario_calificado INT NOT NULL,
    id_usuario_calificador INT NOT NULL,
    operacion_concretada BOOLEAN NOT NULL,
    satisfaccion TINYINT NOT NULL,
    fecha_calificacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_transaccion) REFERENCES transacciones(id_transaccion),
    FOREIGN KEY (id_usuario_calificado) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_usuario_calificador) REFERENCES usuarios(id_usuario),
    CHECK (satisfaccion BETWEEN 0 AND 100),
    UNIQUE (id_transaccion, id_usuario_calificado)
);



/*
 1- 2-  3- 4- 5-6- 7-  8-yo diría que sea un campo de publicacion. Esto para que sea más facil el ordenarlos segun el nivel de publicacion. Osea que no se tenga que acceder a otra tabla por cada publicacion para obtener un solo valor.
 */