
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/api/api_service.dart';

class AlberguesScreen extends StatefulWidget {
  const AlberguesScreen({super.key});

  @override
  State<AlberguesScreen> createState() => _AlberguesScreenState();
}

class _AlberguesScreenState extends State<AlberguesScreen> {
  // ignore: unused_field
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  List<dynamic> _albergues = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAlbergues();
  }

  Future<void> _loadAlbergues() async {
    try {
      final albergues = await ApiService.getAlbergues();
      setState(() {
        _albergues = albergues;
        _isLoading = false;
      });
      _updateMarkers();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _updateMarkers() {
    _markers.clear();
    for (final albergue in _albergues) {
      final lat = double.tryParse(albergue['latitud'] ?? '0') ?? 0;
      final lng = double.tryParse(albergue['longitud'] ?? '0') ?? 0;
      
      if (lat != 0 && lng != 0) {
        _markers.add(
          Marker(
            markerId: MarkerId(albergue['id']),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: albergue['nombre'],
              snippet: albergue['ciudad'],
            ),
          ),
        );
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albergues'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(18.4861, -69.9312), // RD coordinates
                      zoom: 8,
                    ),
                    markers: _markers,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _albergues.length,
                    itemBuilder: (context, index) {
                      final albergue = _albergues[index];
                      return ListTile(
                        title: Text(albergue['nombre']),
                        subtitle: Text(albergue['ciudad']),
                        onTap: () {
                          _showAlbergueDetail(albergue);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  void _showAlbergueDetail(Map<String, dynamic> albergue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(albergue['nombre']),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ciudad: ${albergue['ciudad']}'),
              Text('Dirección: ${albergue['direccion']}'),
              Text('Responsable: ${albergue['responsable']}'),
              Text('Teléfono: ${albergue['telefono']}'),
              Text('Capacidad: ${albergue['capacidad']}'),
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