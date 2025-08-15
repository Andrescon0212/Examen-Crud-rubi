import 'dart:io';

// Declara esta lista global para almacenar los libros.
// Cada elemento de la lista será un mapa (Map) que representa un libro.
List<Map<String, dynamic>> biblioteca = [];

void main() {
  bool continuar = true;
  while (continuar) {
    print("\n--- Sistema de CRUD de Biblioteca ---");
    print("1. Agregar libro");
    print("2. Listar libros");
    print("3. Actualizar libro");
    print("4. Eliminar libro");
    print("5. Salir");
    stdout.write("Elige una opción: ");
    var opcion = stdin.readLineSync();

    switch (opcion) {
      case '1':
        agregarLibro();
        break;
      case '2':
        listarLibros();
        break;
      case '3':
        actualizarLibro();
        break;
      case '4':
        eliminarLibro();
        break;
      case '5':
        continuar = false;
        print("Saliendo del programa...");
        break;
      default:
        print("❌ Opción no válida. Intenta de nuevo.");
    }
  }
}

void agregarLibro() {
    print("\n--- Agregar Libro ---");
  stdout.write("Título del libro: ");
  String? titulo = stdin.readLineSync();
  stdout.write("Autor del libro: ");
  String? autor = stdin.readLineSync();
  stdout.write("Año de publicación: ");
  String? anioStr = stdin.readLineSync();

   if (titulo == null || titulo.isEmpty || autor == null || autor.isEmpty || anioStr == null || anioStr.isEmpty) {
    print("Error: Todos los campos son obligatorios. Inténtalo de nuevo.");
    return;
  }

//parsear de cadena a entero
    int? anio = int.tryParse(anioStr);
  if (anio == null) {
    print("Error: El año debe ser un número entero válido.");
    return;
  }

    Map<String, dynamic> nuevoLibro = {
    'titulo': titulo,
    'autor': autor,
    'anio': anio,
  };

    biblioteca.add(nuevoLibro);
  
  print("Libro agregado con éxito.");
}

void listarLibros() {
  if (biblioteca.isEmpty) {
    print("No hay libros en la biblioteca.");
    return;
  }

    print("\n--- Libros Registrados ---");
  // Recorre la lista con un ciclo for para acceder al índice.
  for (int i = 0; i < biblioteca.length; i++) {
    var libro = biblioteca[i]; // Accede al mapa en la posición 'i'.
    print("Índice: $i, Título: ${libro['titulo']}, Autor: ${libro['autor']}, Año: ${libro['anio']}");
  }
}

void actualizarLibro() {
  if (biblioteca.isEmpty) {
    print("\nNo hay libros para actualizar.");
    return;
  }

    stdout.write("\nIngresa el índice del libro a actualizar: ");
  String? indiceStr = stdin.readLineSync();
  int? indice = int.tryParse(indiceStr ?? '');

   // 1. Validar que el índice sea un número válido y esté dentro del rango de la lista.
  if (indice == null || indice < 0 || indice >= biblioteca.length) {
    print("Error: Índice no válido. Elige un índice entre 0 y ${biblioteca.length - 1}.");
    return;
  }

  stdout.write("Ingresa el nuevo título del libro (deja en blanco para no cambiar): ");
  String? nuevoTitulo = stdin.readLineSync();
  stdout.write("Ingresa el nuevo autor del libro (deja en blanco para no cambiar): ");
  String? nuevoAutor = stdin.readLineSync();
  stdout.write("Ingresa el nuevo año de publicación (deja en blanco para no cambiar): ");
  String? nuevoAnioStr = stdin.readLineSync();

  // 2. Acceder al mapa del libro y actualizar las propiedades si se ingresaron nuevos valores.
  if (nuevoTitulo != null && nuevoTitulo.isNotEmpty) {
    biblioteca[indice]['titulo'] = nuevoTitulo;
  }
  if (nuevoAutor != null && nuevoAutor.isNotEmpty) {
    biblioteca[indice]['autor'] = nuevoAutor;
  }
  if (nuevoAnioStr != null && nuevoAnioStr.isNotEmpty) {
    int? nuevoAnio = int.tryParse(nuevoAnioStr);
    if (nuevoAnio != null) {
      biblioteca[indice]['anio'] = nuevoAnio;
    } else {
      print("Advertencia: El año no es un número válido, no se actualizará.");
    }
  }
  
  print("Libro actualizado con éxito.");
}

void eliminarLibro() {
   if (biblioteca.isEmpty) {
    print("\nNo hay libros para eliminar.");
    return;
  }
  
  stdout.write("\nIngresa el índice del libro a eliminar: ");
  String? indiceStr = stdin.readLineSync();
  int? indice = int.tryParse(indiceStr ?? '');
  
  // 1. Validar que el índice sea un número válido y esté dentro del rango de la lista.
  if (indice == null || indice < 0 || indice >= biblioteca.length) {
    print("Error: Índice no válido. Elige un índice entre 0 y ${biblioteca.length - 1}.");
    return;
  }
  
  // 2. Eliminar el libro de la lista usando el método removeAt().
  biblioteca.removeAt(indice);
  print("Libro eliminado con éxito.");
}