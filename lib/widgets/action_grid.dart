import 'package:flutter/material.dart';
import '/screens/albergues_screen.dart';
import '/screens/medidas_screen.dart';
import '/screens/registro_screen.dart';
import '/screens/miembros_screen.dart';
import '../../widgets/shared/custom_card.dart';

class ActionGrid extends StatelessWidget {
  const ActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: const [
          ActionButton(
            icon: Icons.home_work,
            color: Colors.orange,
            title: 'Albergues',
            targetScreen: AlberguesScreen(),
          ),
          ActionButton(
            icon: Icons.warning,
            color: Colors.red,
            title: 'Medidas',
            targetScreen: MedidasScreen(),
          ),
          ActionButton(
            icon: Icons.person_add,
            color: Colors.green,
            title: 'Voluntario',
            targetScreen: RegistroScreen(),
          ),
          ActionButton(
            icon: Icons.people,
            color: Colors.blue,
            title: 'Miembros',
            targetScreen: MiembrosScreen(),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final Widget targetScreen;

  const ActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.targetScreen,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => targetScreen),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}