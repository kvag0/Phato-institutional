import 'package:flutter/material.dart';

// --- INSTRUÇÕES ---
// 1. Crie um novo arquivo chamado `profile_stats.dart` dentro da sua pasta `lib/widgets/`.
// 2. Cole este código no novo arquivo.

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn('142', 'Artigos Lidos'),
          _buildStatColumn('89', 'Votos de Viés'),
          _buildStatColumn('45', 'Fontes Vistas'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[400])),
      ],
    );
  }
}
