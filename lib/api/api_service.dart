import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://adamix.net/defensa_civil/def/';

  // Métodos GET
  static Future<List<dynamic>> getNoticias() async {
    try {
      final response = await http.get(
        Uri.parse('${_baseUrl}noticias.php'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['exito'] == true) {
          return data['datos'];
        }
        throw Exception(data['mensaje'] ?? 'Error desconocido');
      } else {
        throw Exception('Error HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al cargar noticias: $e');
    }
  }

  static Future<List<dynamic>> getAlbergues() async {
    final response = await http.get(Uri.parse('${_baseUrl}albergues.php'));
    return _handleListResponse(response);
  }

  static Future<List<dynamic>> getMedidas() async {
    final response = await http.get(Uri.parse('${_baseUrl}medidas_preventivas.php'));
    return _handleListResponse(response);
  }

  static Future<List<dynamic>> getMiembros() async {
    final response = await http.get(Uri.parse('${_baseUrl}miembros.php'));
    return _handleListResponse(response);
  }

  // Métodos POST
  static Future<Map<String, dynamic>> registrarVoluntario({
    required String cedula,
    required String nombre,
    required String apellido,
    required String clave,
    required String correo,
    required String telefono,
  }) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}registro.php'),
      body: {
        'cedula': cedula,
        'nombre': nombre,
        'apellido': apellido,
        'clave': clave,
        'correo': correo,
        'telefono': telefono,
      },
    );
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> iniciarSesion({
    required String cedula,
    required String clave,
  }) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}iniciar_sesion.php'),
      body: {
        'cedula': cedula,
        'clave': clave,
      },
    );
    return _handleResponse(response);
  }

  // Helpers
  static List<dynamic> _handleListResponse(http.Response response) {
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['exito'] == true) {
        return data['datos'];
      }
      throw Exception(data['mensaje']);
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }
}