class Servicio {
  final String id;
  final String nombre;
  final String descripcion;

  Servicio({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) {
    return Servicio(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
    );
  }
}