import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HeaderSlider extends StatefulWidget {
  const HeaderSlider({super.key});

  @override
  State<HeaderSlider> createState() => _HeaderSliderState();
}

class _HeaderSliderState extends State<HeaderSlider> {
  int _currentIndex = 0;
  final List<String> _images = [
    'lib/assets/defensa1.jpg', // Rutas corregidas (sin / inicial)
    'lib/assets/defensa2.jpg',
    'lib/assets/defensa3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            onPageChanged: (index, _) => setState(() => _currentIndex = index),
          ),
          items: _images.map((imagePath) => _buildImageContainer(imagePath)).toList(),
        ),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath), // Usa AssetImage para imágenes locales
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _images.asMap().entries.map((entry) {
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
    );
  }
}