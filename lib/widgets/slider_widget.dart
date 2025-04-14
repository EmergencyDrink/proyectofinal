// TODO Implement this library.
import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final String imagePath;  // Asegúrate que este parámetro exista
  
  const SliderWidget({
    Key? key,
    required this.imagePath,  // Y que esté marcado como required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),  // Aquí se usa imagePath
        ),
      ),
    );
  }
}