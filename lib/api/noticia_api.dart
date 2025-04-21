

////////////Prueba de API//////////////////

/*import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService2 {
  static const String _baseUrl = 'https://adamix.net/defensa_civil/def/';

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl$endpoint'));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      body: body,
    );
    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar datos: ${response.statusCode}');
    }
  }
}*/