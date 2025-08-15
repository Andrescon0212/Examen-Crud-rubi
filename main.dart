import 'dart:io';
List<Map<String, dynamic>> tienda = [];

void main() {
  bool continuar = true;
  while (continuar) {
    print("\n--- Sistema de CRUD de una tienda ---");
    print("1. Agregar producto");
    print("2. Listar producto");
    print("3. Actualizar producto");
    print("4. Eliminar producto");
    print("5. Salir");
    stdout.write("Elige una opción: ");
    var opcion = stdin.readLineSync();

switch (opcion) {
      case '1':
        agregarProducto();
        break;
      case '2':
        listarProductos();
        break;
      case '3':
        actualizarProducto();
        break;
      case '4':
        eliminarProducto();
        break;
      case '5':
        continuar = false;
        print("Usted salío del programa");
        break;
      default:
        print("Opción no válida. Intenta de nuevo.");
    }
  }
}

void agregarProducto(){
print ("n\nAgregar Producto ");
  stdout.write("Nombre del producto: ");
  String? nombre = stdin.readLineSync();
  stdout.write("Precio del producto: ");
  String? precioStr = stdin.readLineSync();
  stdout.write("Cantidad del producto: ");
  String? cantidadStr = stdin.readLineSync();

  if (nombre == null || nombre.isEmpty || precioStr == null || precioStr.isEmpty || cantidadStr == null || cantidadStr.isEmpty) {
    print("Error: Todos los campos son obligatorios. Inténtalo nuevamente.");
    return;
  }

  double? precio = double.tryParse(precioStr);
  int? cantidad = int.tryParse(cantidadStr);

  if (precio == null || cantidad == null) {
    print("Error: El precio debe ser un número válido y la cantidad debe ser un número entero válido por el.");
    return;
  }

  Map<String, dynamic> nuevoProducto = {
    'nombre': nombre,
    'precio': precio,
    'cantidad': cantidad
  };

  tienda.add(nuevoProducto);
  print("Producto agregado exitosamente.");

}

void listarProductos() {
  print ("\nListar Productos");
  if (tienda.isEmpty) {
    print("No hay productos en el inventario");
    return;
  }
  for (var producto in tienda) {
    print("Nombre: ${producto['nombre']}, Precio: ${producto['precio']}, Cantidad: ${producto['cantidad']}");
  }
}

void actualizarProducto() {
  print ("\nActualizar Producto");
  if (tienda.isEmpty) {
    print("No hay productos en el inventario");
    return;
  }
  stdout.write("Ingrese el nombre del producto para actualizar: ");
  String? nombre = stdin.readLineSync();

  var producto = tienda.firstWhere((p) => p['nombre'] == nombre, orElse: () => {});
  if (producto.isEmpty) {
    print("El producto no fue encontrado");
    return;
  }

  stdout.write("Nuevo nombre: ");
  String? nuevoNombre = stdin.readLineSync();
  stdout.write("Nuevo precio: ");
  String? nuevoPrecioStr = stdin.readLineSync();
  stdout.write("Nueva cantidad: ");
  String? nuevaCantidadStr = stdin.readLineSync();

  if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
    producto['nombre'] = nuevoNombre;
  }
  if (nuevoPrecioStr != null && nuevoPrecioStr.isNotEmpty) {
    double? nuevoPrecio = double.tryParse(nuevoPrecioStr);
    if (nuevoPrecio != null) {
      producto['precio'] = nuevoPrecio;
    } else {
      print("Error: El precio debe ser un número validado por el sistema.");
    }
  }
  if (nuevaCantidadStr != null && nuevaCantidadStr.isNotEmpty) {
    int? nuevaCantidad = int.tryParse(nuevaCantidadStr);
    if (nuevaCantidad != null) {
      producto['cantidad'] = nuevaCantidad;
    } else {
      print("Error: La cantidad debe ser un entero válido.");
    }
  }

  print("El producto se ha actualizado exitosamente.");
}

void eliminarProducto() {
  print ("\n Eliminar un Producto ");
  if (tienda.isEmpty) {
    print("No hay productos en el inventario");
    return;
  }
  stdout.write("Ingrese el nombre del producto para eliminarlo: ");
  String? nombre = stdin.readLineSync();

  var producto = tienda.firstWhere((p) => p['nombre'] == nombre, orElse: () => {});
  if (producto.isEmpty) {
    print("Producto no encontrado");
    return;
  }

  tienda.remove(producto);
  print("Producto eliminado exitosamente.");
}