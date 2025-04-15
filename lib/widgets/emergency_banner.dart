import 'package:flutter/material.dart';
import '../../widgets/shared/custom_card.dart';

class EmergencyBanner extends StatelessWidget {
  const EmergencyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomCard(
        color: Colors.red[50],
        borderColor: Colors.red[100],
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _EmergencyHeader(),
              const SizedBox(height: 12),
              Text(
                'En caso de emergencia, contacta inmediatamente a Defensa Civil:',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              const _EmergencyButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmergencyHeader extends StatelessWidget {
  const _EmergencyHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.warning_amber, color: Colors.red[700]),
        const SizedBox(width: 8),
        Text(
          'Emergencias',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red[700],
          ),
        ),
      ],
    );
  }
}

class _EmergencyButtons extends StatelessWidget {
  const _EmergencyButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.phone, color: Colors.white),
            label: const Text(
              'Llamar al 911',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(color: Colors.red[700]!),
            ),
            icon: Icon(Icons.info, color: Colors.red[700]),
            label: Text(
              'Más información',
              style: TextStyle(color: Colors.red[700]),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}