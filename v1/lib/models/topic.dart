import 'package:flutter/material.dart';

class Topic {
  final String id;
  final String nome;
  final String chave;
  final String icone;

  Topic({
    required this.id,
    required this.nome,
    required this.chave,
    required this.icone,
    required IconData icon,
  });

  // Mapeia os ícones de String para IconData
  IconData get iconData {
    switch (icone) {
      case 'trending_up':
        return Icons.trending_up;
      case 'gavel':
        return Icons.gavel;
      case 'science_outlined':
        return Icons.science_outlined;
      case 'palette_outlined':
        return Icons.palette_outlined;
      case 'sports_esports':
        return Icons.sports_esports;
      case 'memory':
        return Icons.memory;
      case 'health_and_safety':
        return Icons.health_and_safety;
      case 'eco':
        return Icons.eco;
      case 'public':
        return Icons.public;
      default:
        return Icons.topic; // Ícone padrão
    }
  }

  factory Topic.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Topic(
      id: documentId,
      nome: data['nome'] ?? 'Nome Desconhecido',
      chave: data['chave'] ?? '',
      icone: data['icone'] ?? 'topic',
      icon: null,
    );
  }
}
