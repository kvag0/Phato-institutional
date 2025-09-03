import 'package:flutter/material.dart';

// --- INSTRUÇÕES ---
// Substitua o conteúdo do seu `lib/models/category.dart` por este código.

class Category {
  final String name;
  final IconData icon;

  // CORRIGIDO: Adicionado construtor `const`
  const Category({required this.name, required this.icon});
}
