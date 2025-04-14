class Video {
  final String id;
  final String titulo;
  final String descripcion;
  final String url;
  final String miniatura;

  Video({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.url,
    required this.miniatura,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      url: json['url'] ?? '',
      miniatura: json['miniatura'] ?? '',
    );
  }
}