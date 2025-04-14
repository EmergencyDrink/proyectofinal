import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'albergues_screen.dart';
import 'medidas_screen.dart';
import 'registro_screen.dart';
import 'miembros_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<String> _sliderImages = [
    'https://adamix.net/defensa_civil/img/slider1.jpg',
    'https://adamix.net/defensa_civil/img/slider2.jpg',
    'https://adamix.net/defensa_civil/img/slider3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Defensa Civil RD'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Carrusel de imágenes
            _buildImageSlider(),
            
            // Sección de acciones rápidas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Acciones Rápidas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButtons(),
                ],
              ),
            ),
            
            // Divider
            const Divider(thickness: 1, height: 20),
            
            // Sección de noticias destacadas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Noticias Recientes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Ver todas'),
                      ),
                    ],
                  ),
                  _buildNewsPreview(),
                ],
              ),
            ),
            
            // Sección de emergencia
            _buildEmergencySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _sliderImages.map((imageUrl) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _sliderImages.asMap().entries.map((entry) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildActionCard(
          icon: Icons.home_work,
          color: Colors.orange,
          title: 'Albergues',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AlberguesScreen()),
          ),
        ),
        _buildActionCard(
          icon: Icons.warning,
          color: Colors.red,
          title: 'Medidas',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MedidasScreen()),
          ),
        ),
        _buildActionCard(
          icon: Icons.person_add,
          color: Colors.green,
          title: 'Voluntario',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistroScreen()),
          ),
        ),
        _buildActionCard(
          icon: Icons.people,
          color: Colors.blue,
          title: 'Miembros',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MiembrosScreen()),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsPreview() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              'https://adamix.net/defensa_civil/img/noticia_ejemplo.jpg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Defensa Civil realiza simulacro nacional',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'El ejercicio busca preparar a la población ante posibles desastres naturales...',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hace 2 días',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Leer más'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencySection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, color: Colors.red[700]),
              const SizedBox(width: 8),
              Text(
                'Emergencias',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'En caso de emergencia, contacta inmediatamente a Defensa Civil:',
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.phone, color: Colors.white),
                  label: const Text(
                    'Llamar al 911',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: Colors.red[700]!),
                  ),
                  icon: Icon(Icons.info, color: Colors.red[700]),
                  label: Text(
                    'Más información',
                    style: TextStyle(color: Colors.red[700]),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}