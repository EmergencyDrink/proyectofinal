import 'package:flutter/material.dart';

class AcercadeScreen extends StatelessWidget {
  const AcercadeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          PersonaCard(
            nombre: 'Andy Rodríguez',
            email: 'andy.rodriguez@email.com',
            telefono: '+1 (829) 123-4567',
            direccion: 'Santo Domingo, República Dominicana',
            imagenPath: 'lib/assets/Andy_Foto.jpg',
          ),
          SizedBox(height: 30),
          PersonaCard(
            nombre: 'Aaron Carmona',
            email: 'Aaron.Carmona@email.com',
            telefono: '+1 (829) 987-6543',
            direccion: 'Santiago, República Dominicana',
            imagenPath: 'lib/assets/foto_aaron.jpg',
          ),
        ],
      ),
    );
  }
}

class PersonaCard extends StatelessWidget {
  final String nombre;
  final String email;
  final String telefono;
  final String direccion;
  final String imagenPath;

  const PersonaCard({
    super.key,
    required this.nombre,
    required this.email,
    required this.telefono,
    required this.direccion,
    required this.imagenPath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(imagenPath),
            ),
            const SizedBox(height: 10),
            Text(
              nombre,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(email),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(telefono),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(direccion),
            ),
          ],
        ),
      ),
    );
  }
}
