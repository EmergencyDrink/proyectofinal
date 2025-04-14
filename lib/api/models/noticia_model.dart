class Noticia {
  final String id;
  final String titulo;
  final String descripcion;
  final String fecha;
  final String foto;

  Noticia({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.foto,
  });

  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      fecha: json['fecha'] ?? '',
      foto: json['foto'] ?? '',
    );
  }
}