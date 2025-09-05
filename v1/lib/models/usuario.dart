// Modelo de dados para o usuário (sem dependências do Firebase)
class Usuario {
  final String id;
  final String? nome;
  final String? email;
  final String? imageUrl;
  final String? subscription;
  final int level;
  final int xp;
  final int nextLevelXp;
  final Map<String, int> stats;
  final Map<String, int> topicReadCounts;

  Usuario({
    required this.id,
    this.nome,
    this.email,
    this.imageUrl,
    this.subscription,
    required this.level,
    required this.xp,
    required this.nextLevelXp,
    required this.stats,
    required this.topicReadCounts,
  });
}
