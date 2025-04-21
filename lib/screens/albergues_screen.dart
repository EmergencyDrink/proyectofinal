import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../api/api_service.dart';

class AlberguesScreen extends StatefulWidget {
  const AlberguesScreen({super.key});

  @override
  State<AlberguesScreen> createState() => _AlberguesScreenState();
}

class _AlberguesScreenState extends State<AlberguesScreen> {
  List<dynamic> _albergues = [];
  bool _isLoading = true;
  String _errorMessage = '';
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

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
        _updateMarkers();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar albergues: $e';
        _isLoading = false;
      });
    }
  }

  void _updateMarkers() {
    _markers.clear();
    for (final albergue in _albergues) {
      final lat = double.tryParse(albergue['lat'] ?? '0') ?? 0;
      final lng = double.tryParse(albergue['lng'] ?? '0') ?? 0;
      
      if (lat != 0 && lng != 0) {
        _markers.add(
          Marker(
            markerId: MarkerId(albergue['id'] ?? ''),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: albergue['edificio'] ?? 'Albergue',
              snippet: albergue['ciudad'] ?? '',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albergues Disponibles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAlbergues,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(child: Text(_errorMessage));
    }

    return Column(
      children: [
        _buildMapSection(),
        _buildListSection(),
      ],
    );
  }

  Widget _buildMapSection() {
    return SizedBox(
      height: 250,
      child: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition: const CameraPosition(
          target: LatLng(18.4861, -69.9312), // Coordenadas de RD
          zoom: 7,
        ),
        markers: _markers,
        myLocationEnabled: true,
      ),
    );
  }

  Widget _buildListSection() {
    return Expanded(
      child: ListView.builder(
        itemCount: _albergues.length,
        itemBuilder: (context, index) {
          final albergue = _albergues[index];
          return _buildAlbergueCard(albergue);
        },
      ),
    );
  }

  Widget _buildAlbergueCard(Map<String, dynamic> albergue) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: const Icon(Icons.home_work, color: Colors.blue),
        title: Text(
          albergue['edificio'] ?? 'Albergue sin nombre',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ciudad: ${albergue['ciudad'] ?? 'No especificada'}'),
            Text('Tel: ${albergue['telefono'] ?? 'N/A'}'),
          ],
        ),
        onTap: () => _showAlbergueDetails(albergue),
      ),
    );
  }

  void _showAlbergueDetails(Map<String, dynamic> albergue) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detalles del Albergue',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildDetailRow(Icons.home, 'Nombre:', albergue['edificio']),
              _buildDetailRow(Icons.location_city, 'Ciudad:', albergue['ciudad']),
              _buildDetailRow(Icons.location_on, 'Dirección:', albergue['direccion']),
              _buildDetailRow(Icons.phone, 'Teléfono:', albergue['telefono']),
              _buildDetailRow(Icons.people, 'Capacidad:', albergue['capacidad']),
              const SizedBox(height: 16),
              if (albergue['lat'] != null && albergue['lng'] != null)
                ElevatedButton(
                  onPressed: () => _zoomToLocation(
                    double.parse(albergue['lat']),
                    double.parse(albergue['lng']),
                  ),
                  child: const Text('Ver en mapa'),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(value ?? 'No disponible'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _zoomToLocation(double lat, double lng) {
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14),
    );
    Navigator.pop(context); // Cierra el bottom sheet
  }
}