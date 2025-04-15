/*import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/api/noticia_api.dart';



///////////////// Usar para probar API///////////////////////
class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  // ignore: unused_field
  int _currentIndex = 0;
  List<dynamic> noticias = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await ApiService2.get('noticias.php');
      setState(() {
        noticias = data['datos'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Defensa Civil RD'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildImageSlider(),
                  const SizedBox(height: 20),
                  _buildNoticiasSection(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadData,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildImageSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      items: [
        'https://adamix.net/defensa_civil/img/slider1.jpg',
        'https://adamix.net/defensa_civil/img/slider2.jpg',
        'https://adamix.net/defensa_civil/img/slider3.jpg',
      ].map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildNoticiasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Últimas Noticias',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: noticias.length,
          itemBuilder: (context, index) {
            final noticia = noticias[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: noticia['foto'] != null && noticia['foto'].isNotEmpty
                    ? Image.network(noticia['foto'], width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.article),
                title: Text(noticia['titulo'] ?? 'Sin título'),
                subtitle: Text(noticia['fecha'] ?? ''),
                onTap: () {
                  _showNoticiaDetail(noticia);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _showNoticiaDetail(Map<String, dynamic> noticia) {
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
}*/