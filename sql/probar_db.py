import sqlite3
import re
import os

def probar_sql():
    sql_path = os.path.join(os.path.dirname(__file__), 'rincon_libro_db.sql')
    if not os.path.exists(sql_path):
        print(f"Error: No se encontró {sql_path}")
        return

    with open(sql_path, 'r', encoding='utf-8') as f:
        sql_content = f.read()

    # Crear base de datos en memoria para pruebas rápidas en la terminal
    conn = sqlite3.connect(':memory:')
    cursor = conn.cursor()

    # Crear tablas simplificadas en SQLite para la prueba local
    cursor.executescript('''
    CREATE TABLE libros (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        autor TEXT NOT NULL,
        precio DECIMAL(10,2) NOT NULL,
        genero TEXT NOT NULL,
        imagen TEXT,
        emoji TEXT DEFAULT '❓',
        descontinuado INTEGER DEFAULT 0,
        fecha_creado DATETIME DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        rol TEXT DEFAULT 'cliente',
        fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE pedidos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        subtotal DECIMAL(10,2) NOT NULL,
        envio DECIMAL(10,2) NOT NULL,
        total DECIMAL(10,2) NOT NULL,
        fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
    );

    CREATE TABLE pedido_detalle (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pedido_id INTEGER NOT NULL,
        libro_id INTEGER NOT NULL,
        titulo TEXT NOT NULL,
        precio DECIMAL(10,2) NOT NULL,
        cantidad INTEGER NOT NULL,
        FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
        FOREIGN KEY (libro_id) REFERENCES libros(id)
    );
    ''')

    # Extraer e insertar los datos volcados (INSERT INTO)
    inserts = re.findall(r'INSERT INTO `?(\w+)`?\s*\((.*?)\)\s*VALUES\s*(.*?);', sql_content, re.DOTALL | re.IGNORECASE)
    
    for tabla, columnas, valores in inserts:
        cols_clean = ', '.join([f'`{c.strip(" `")}`' for c in columnas.split(',')])
        query = f"INSERT INTO {tabla} ({cols_clean}) VALUES {valores};"
        try:
            cursor.executescript(query)
        except Exception as e:
            print(f"Error al insertar en {tabla}: {e}")

    conn.commit()

    print("=" * 60)
    print("  PRUEBA EXITOSA DE LA BASE DE DATOS `rincon_libro_db.sql`  ")
    print("=" * 60)

    # Probar consulta a Libros
    cursor.execute("SELECT id, titulo, autor, precio, genero, emoji FROM libros LIMIT 5;")
    libros = cursor.fetchall()
    print("\n📚 TABLA `libros` (Muestra de primeros 5):")
    print("-" * 60)
    for l in libros:
        print(f"  [{l[0]}] {l[5]} '{l[1]}' por {l[2]} - ${l[3]} (Género: {l[4]})")

    # Probar consulta a Usuarios
    cursor.execute("SELECT id, nombre, email, rol FROM usuarios;")
    usuarios = cursor.fetchall()
    print("\n👤 TABLA `usuarios`:")
    print("-" * 60)
    for u in usuarios:
        print(f"  [{u[0]}] {u[1]} ({u[2]}) - Rol: {u[3]}")

    # Probar consulta a Pedidos con JOIN
    cursor.execute('''
        SELECT p.id, u.nombre, p.total, p.fecha, d.titulo, d.cantidad, d.precio
        FROM pedidos p
        JOIN usuarios u ON p.usuario_id = u.id
        JOIN pedido_detalle d ON d.pedido_id = p.id;
    ''')
    pedidos = cursor.fetchall()
    print("\n🛒 TABLA `pedidos` + `pedido_detalle` (Historial de compras):")
    print("-" * 60)
    for p in pedidos:
        print(f"  Pedido #{p[0]} | Cliente: {p[1]} | Fecha: {p[3]} | Total: ${p[2]}")
        print(f"    ↳ Artículo: {p[4]} x{p[5]} (${p[6]} c/u)")

    print("\n" + "=" * 60)

    conn.close()

if __name__ == '__main__':
    probar_sql()
