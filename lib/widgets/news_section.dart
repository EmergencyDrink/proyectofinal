import 'package:flutter/material.dart';
import '../../api/api_service.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({super.key});

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  List<dynamic> noticias = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNoticias();
  }

  Future<void> _loadNoticias() async {
    try {
      final data = await ApiService.getNoticias();
      setState(() {
        noticias = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar noticias: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Últimas Noticias'),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: noticias.length,
                itemBuilder: (context, index) => _NoticiaCard(noticia: noticias[index]),
              ),
        _RefreshButton(onPressed: _loadNoticias),
      ],
    );
  }
}

class _NoticiaCard extends StatelessWidget {
  final Map<String, dynamic> noticia;

  const _NoticiaCard({required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: noticia['foto'] != null && noticia['foto'].isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  noticia['foto'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(Icons.article, size: 40),
        title: Text(
          noticia['titulo'] ?? 'Sin título',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(noticia['fecha'] ?? 'Fecha no disponible'),
            const SizedBox(height: 4),
            Text(
              noticia['contenido'] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        onTap: () => _showNoticiaDetail(context, noticia),
      ),
    );
  }

  void _showNoticiaDetail(BuildContext context, Map<String, dynamic> noticia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(noticia['titulo'] ?? 'Noticia'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (noticia['foto'] != null && noticia['foto'].isNotEmpty)
                Image.network(noticia['foto']),
              const SizedBox(height: 16),
              Text(noticia['contenido'] ?? 'No hay descripción disponible'),
              const SizedBox(height: 8),
              Text('Fecha: ${noticia['fecha'] ?? 'Desconocida'}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

class _RefreshButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _RefreshButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
          icon: const Icon(Icons.refresh, size: 16),
          label: const Text('Actualizar'),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}