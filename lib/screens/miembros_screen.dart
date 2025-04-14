import 'package:flutter/material.dart';
import '/api/api_service.dart';

class MiembrosScreen extends StatefulWidget {
  const MiembrosScreen({super.key});

  @override
  State<MiembrosScreen> createState() => _MiembrosScreenState();
}

class _MiembrosScreenState extends State<MiembrosScreen> {
  List<dynamic> _miembros = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMiembros();
  }

  Future<void> _loadMiembros() async {
    try {
      final miembros = await ApiService.getMiembros();
      setState(() {
        _miembros = miembros;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
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
        title: const Text('Miembros del Equipo'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _miembros.length,
              itemBuilder: (context, index) {
                final miembro = _miembros[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: miembro['foto'] != null && miembro['foto'].isNotEmpty
                          ? NetworkImage(miembro['foto'])
                          : null,
                      child: miembro['foto'] == null || miembro['foto'].isEmpty
                          ? Text(miembro['nombre'][0])
                          : null,
                    ),
                    title: Text('${miembro['nombre']} ${miembro['apellido']}'),
                    subtitle: Text(miembro['cargo']),
                  ),
                );
              },
            ),
    );
  }
}