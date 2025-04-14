class Medida {
  final String id;
  final String titulo;
  final String descripcion;
  final String foto;

  Medida({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.foto,
  });

  factory Medida.fromJson(Map<String, dynamic> json) {
    return Medida(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      foto: json['foto'] ?? '',
    );
  }
}