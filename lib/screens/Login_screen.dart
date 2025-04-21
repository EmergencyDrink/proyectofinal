import 'package:flutter/material.dart';
import '../api/api_service.dart';

//Colores
const kPrimaryColor = Color(0xFF007BFF);
const kBackgroundColor = Colors.white;
const kInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kPrimaryColor),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

    // Si la respuesta es exitosa, redirige al home
    if (response['exito'] == true) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/registro');
                        },
                        child: const Text('¿No tienes cuenta? Regístrate'),
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
        ),
      ),
    );
  }
}
