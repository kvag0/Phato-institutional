import 'package:flutter/cupertino.dart';

// Modelo de dados para os tópicos/categorias
class Topic {
  final String nome;
  final String chave;
  final IconData icon; // O campo 'icon' está definido aqui

  Topic({
    required this.nome,
    required this.chave,
    required this.icon,
  });
}
