class Feriado {
  final int? id;
  final String nombre;
  final String fecha;
  final String descripcion;
  final String urlImagen;

  Feriado({this.id, required this.nombre, required this.fecha, required this.descripcion, required this.urlImagen});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'fecha': fecha,
      'descripcion': descripcion,
      'urlImagen': urlImagen,
    };
  }
}
