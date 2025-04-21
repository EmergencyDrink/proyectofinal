<<<<<<< HEAD
import 'package:flutter/material.dart';
import '../api/api_service.dart';

//Colores
const kPrimaryColor = Color(0xFF007BFF);
const kBackgroundColor = Colors.white;
const kInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kPrimaryColor),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);


=======
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


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../api/api_service.dart';

>>>>>>> cb4563d7d0c18333622b4fbe144e0beba00026e6
class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
<<<<<<< HEAD
  final _formKey = GlobalKey<FormState>();
  final cedulaController = TextEditingController();
  final claveController = TextEditingController();

  void iniciarSesion() async {
    if (!_formKey.currentState!.validate()) return;

    final cedula = cedulaController.text.trim();
    final clave = claveController.text.trim();

    final response = await ApiService.iniciarSesion(cedula, clave);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response['mensaje'] ?? 'Error'),
        backgroundColor: response['exito'] == true ? Colors.green : Colors.red,
      ),
    );
=======
  // Variables para el mapa
  GoogleMapController? _mapController;
  bool _isMapReady = false;
  final Set<Marker> _markers = {};
  LatLng _initialPosition = const LatLng(18.4861, -69.9312); // RD coordinates

  // Variables para albergues
  List<dynamic> _albergues = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAlbergues();
  }

  Future<void> _loadAlbergues() async {
    try {
      final data = await ApiService.getAlbergues();
      setState(() {
        _albergues = data;
        _isLoading = false;
      });
      _updateMarkers();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar albergues: $e')),
      );
    }
  }

  void _updateMarkers() {
    final markers = <Marker>{};
    for (final albergue in _albergues) {
      final lat = double.tryParse(albergue['latitud'] ?? '0') ?? 0;
      final lng = double.tryParse(albergue['longitud'] ?? '0') ?? 0;
      
      if (lat != 0 && lng != 0) {
        markers.add(
          Marker(
            markerId: MarkerId(albergue['id'] ?? 'marker_${markers.length}'),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: albergue['nombre'] ?? 'Albergue',
              snippet: albergue['ciudad'] ?? '',
            ),
          ),
        );
      }
    }
    setState(() {
      _markers.clear();
      _markers.addAll(markers);
    });
>>>>>>> cb4563d7d0c18333622b4fbe144e0beba00026e6
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.person, size: 80, color: kPrimaryColor),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: cedulaController,
                        decoration: const InputDecoration(
                          labelText: "Cédula",
                          border: kInputBorder,
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? "Campo requerido" : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: claveController,
                        decoration: const InputDecoration(
                          labelText: "Clave",
                          border: kInputBorder,
                        ),
                        obscureText: true,
                        validator: (value) =>
                            value == null || value.isEmpty ? "Campo requerido" : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: iniciarSesion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Iniciar Sesión"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/recuperar'),
                        child: const Text("¿Olvidaste tu clave?"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/cambiar'),
                        child: const Text("Cambiar clave"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
=======
      appBar: AppBar(
        title: const Text('Albergues - Mapa'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(
          child: _buildMap(),
        ),
        _buildAlberguesList(),
      ],
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: (controller) {
        _mapController = controller;
        setState(() => _isMapReady = true);
      },
      initialCameraPosition: CameraPosition(
        target: _initialPosition,
        zoom: 7,
      ),
      markers: _markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onCameraIdle: () {
        // Opcional: actualizar posición cuando el mapa deja de moverse
      },
    );
  }

  Widget _buildAlberguesList() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _albergues.length,
        itemBuilder: (context, index) {
          final albergue = _albergues[index];
          return _buildAlbergueCard(albergue);
        },
      ),
    );
  }

  Widget _buildAlbergueCard(Map<String, dynamic> albergue) {
    final lat = double.tryParse(albergue['latitud'] ?? '0') ?? 0;
    final lng = double.tryParse(albergue['longitud'] ?? '0') ?? 0;
    final hasLocation = lat != 0 && lng != 0;

    return GestureDetector(
      onTap: () {
        if (hasLocation && _isMapReady) {
          _mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14),
          );
        }
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              albergue['nombre'] ?? 'Albergue',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              albergue['ciudad'] ?? 'Ciudad no especificada',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const Spacer(),
            if (hasLocation)
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.blue),
                  const SizedBox(width: 4),
                  const Text('Ver en mapa', style: TextStyle(fontSize: 12)),
                ],
              ),
          ],
>>>>>>> cb4563d7d0c18333622b4fbe144e0beba00026e6
        ),
      ),
    );
  }
<<<<<<< HEAD
}


=======

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
>>>>>>> cb4563d7d0c18333622b4fbe144e0beba00026e6
