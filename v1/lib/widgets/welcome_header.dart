import 'package:flutter/material.dart';

// --- INSTRUÇÕES ---
// 1. Crie uma nova pasta `widgets` dentro de `lib`.
// 2. Crie um novo arquivo chamado `welcome_header.dart` dentro da pasta `lib/widgets/`.
// 3. Cole este código no novo arquivo.

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bom dia,',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[400]),
          ),
          Text(
            'Usuário Phato',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
