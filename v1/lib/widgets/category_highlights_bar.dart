import 'package:flutter/material.dart';
import '../models/category.dart'; // CORRIGIDO: Caminho do import

// --- INSTRUÇÕES ---
// Substitua o conteúdo do seu `lib/widgets/category_highlights_bar.dart` por este código.

class CategoryHighlightsBar extends StatelessWidget {
  // CORRIGIDO: Removido construtor `const` do widget e tornado a lista `const`
  CategoryHighlightsBar({super.key});

  final List<Category> _categories = const [
    Category(name: 'Tecnologia', icon: Icons.computer),
    Category(name: 'Economia', icon: Icons.monetization_on),
    Category(name: 'Ciência', icon: Icons.science),
    Category(name: 'Internacional', icon: Icons.public),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16.0 : 8.0,
              right: index == _categories.length - 1 ? 16.0 : 8.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Icon(
                    category.icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
