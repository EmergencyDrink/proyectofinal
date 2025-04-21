import 'package:flutter/material.dart';
import 'package:proyectofinal/screens/home_screen2.dart';
import 'package:proyectofinal/screens/registro_page.dart';
import 'package:proyectofinal/screens/registro_screen.dart';
import '/screens/home_screen.dart';
import 'package:proyectofinal/screens/recuperar_clave_page.dart';
import 'package:proyectofinal/screens/cambiar_clave_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Defensa Civil RD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      debugShowCheckedModeBanner: false,

       // 👇 Ruta inicial
      initialRoute: '/home',

      // 👇 Todas las rutas registradas aquí
      routes: {
        '/home': (context) => const HomeScreen(),
        '/recuperar': (context) => const RecuperarClavePage(),
        '/cambiar': (context) => const CambiarClavePage(),
        '/registro': (context) => const RegistroScreen(),
      },
    );
  }
}