import 'package:flutter/material.dart';
import '../api/api_service.dart';

//Colores
const kPrimaryColor = Color(0xFF007BFF);
const kBackgroundColor = Colors.white;
const kInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kPrimaryColor),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

class CambiarClavePage extends StatefulWidget {
  const CambiarClavePage({super.key});

  @override
  State<CambiarClavePage> createState() => _CambiarClavePageState();
}

class _CambiarClavePageState extends State<CambiarClavePage> {
  final _formKey = GlobalKey<FormState>();
  final cedulaController = TextEditingController();
  final nuevaClaveController = TextEditingController();

  void cambiarClave() async {
    if (!_formKey.currentState!.validate()) return;

    final response = await ApiService.cambiarClave(
      cedulaController.text.trim(),
      nuevaClaveController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['mensaje'] ?? 'Error')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(title: const Text("Cambiar Clave"), backgroundColor: kPrimaryColor),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(Icons.lock, size: 70, color: kPrimaryColor),
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
                    controller: nuevaClaveController,
                    decoration: const InputDecoration(
                      labelText: "Nueva Clave",
                      border: kInputBorder,
                    ),
                    obscureText: true,
                    validator: (value) =>
                        value == null || value.length < 4 ? "Mínimo 4 caracteres" : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: cambiarClave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text("Cambiar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

