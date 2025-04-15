import 'package:flutter/material.dart';
import 'package:proyectofinal/widgets/action_grid.dart';
import 'package:proyectofinal/widgets/emergency_banner.dart';
import 'package:proyectofinal/widgets/header_slider.dart';
import 'package:proyectofinal/widgets/news_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderSlider(),
            _SectionTitle('Acciones Rápidas'),
            ActionGrid(),
            Divider(thickness: 1, height: 20),
            NewsSection(),  // Sección de noticias importada
            EmergencyBanner(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Defensa Civil RD'),
      centerTitle: true,
      backgroundColor: Colors.blue[800],
      elevation: 0,
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