import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String cedula = '';
  String correo = '';
  String clave = '';

  Future<void> registrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // URL de la API de registro
      const url = 'https://adamix.net/defensa_civil/def/registro.php';

      try {
        // Enviar datos a la API
        final response = await http.post(
          Uri.parse(url),
          body: {
            'nombre': nombre,
            'cedula': cedula,
            'correo': correo,
            'clave': clave,
          },
        );

        // Si la respuesta es exitosa, continuar con el registro
        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          // Verifica si la respuesta contiene éxito
          if (data['success'] == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('¡Registro exitoso!')),
            );

            // Regresar al login después de 2 segundos
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context); // vuelve atrás
            });
          } else {
            // Si la respuesta no es exitosa, muestra el mensaje de error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['message'] ?? 'Error al registrar')),
            );
          }
        } else {
          throw Exception('Error al conectar con el servidor');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error de conexión')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cédula'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Ingrese su cédula';
                  if (value.length != 11) return 'La cédula debe tener 11 dígitos';
                  return null;
                },
                onSaved: (value) => cedula = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) => value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                onSaved: (value) => clave = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: registrarUsuario,
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
