class Albergue {
  final String id;
  final String nombre;
  final String ciudad;
  final String direccion;
  final String responsable;
  final String telefono;
  final String capacidad;
  final String latitud;
  final String longitud;

  Albergue({
    required this.id,
    required this.nombre,
    required this.ciudad,
    required this.direccion,
    required this.responsable,
    required this.telefono,
    required this.capacidad,
    required this.latitud,
    required this.longitud,
  });

  factory Albergue.fromJson(Map<String, dynamic> json) {
    return Albergue(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      ciudad: json['ciudad'] ?? '',
      direccion: json['direccion'] ?? '',
      responsable: json['responsable'] ?? '',
      telefono: json['telefono'] ?? '',
      capacidad: json['capacidad'] ?? '',
      latitud: json['latitud'] ?? '0',
      longitud: json['longitud'] ?? '0',
    );
  }
}