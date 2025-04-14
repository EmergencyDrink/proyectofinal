class Miembro {
  final String id;
  final String nombre;
  final String apellido;
  final String cargo;
  final String foto;

  Miembro({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.cargo,
    required this.foto,
  });

  factory Miembro.fromJson(Map<String, dynamic> json) {
    return Miembro(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      cargo: json['cargo'] ?? '',
      foto: json['foto'] ?? '',
    );
  }
}