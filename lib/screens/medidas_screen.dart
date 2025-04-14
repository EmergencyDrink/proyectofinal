// TODO Implement this library.
import 'package:flutter/material.dart';
import '/api/api_service.dart';

class MedidasScreen extends StatefulWidget {
  const MedidasScreen({super.key});

  @override
  State<MedidasScreen> createState() => _MedidasScreenState();
}

class _MedidasScreenState extends State<MedidasScreen> {
  List<dynamic> _medidas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMedidas();
  }

  Future<void> _loadMedidas() async {
    try {
      final medidas = await ApiService.getMedidas();
      setState(() {
        _medidas = medidas;
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
        title: const Text('Medidas Preventivas'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemCount: _medidas.length,
              itemBuilder: (context, index) {
                final medida = _medidas[index];
                return Card(
                  child: InkWell(
                    onTap: () => _showMedidaDetail(medida),
                    child: Column(
                      children: [
                        Expanded(
                          child: medida['foto'] != null && medida['foto'].isNotEmpty
                              ? Image.network(
                                  medida['foto'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : const Icon(Icons.warning, size: 50),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            medida['titulo'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showMedidaDetail(Map<String, dynamic> medida) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(medida['titulo']),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (medida['foto'] != null && medida['foto'].isNotEmpty)
                Image.network(medida['foto']),
              const SizedBox(height: 16),
              Text(medida['descripcion']),
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