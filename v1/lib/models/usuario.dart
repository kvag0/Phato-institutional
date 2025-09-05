// CÓDIGO ATUALIZADO para: lib/models/usuario.dart
class Usuario {
  final String id;
  final String email;
  final String? nome;
  final String? imageUrl;
  final int? age;
  final String subscription;
  final int level;
  final int xp;
  final int nextLevelXp;
  final Map<String, int> stats;
  final Map<String, int> topicReadCounts;

  Usuario({
    required this.id,
    required this.email,
    this.nome,
    this.imageUrl,
    this.age,
    this.subscription = 'Free',
    this.level = 1,
    this.xp = 0,
    this.nextLevelXp = 500,
    this.stats = const {
      'articlesRead': 0,
      'biasVotes': 0,
      'sourcesViewed': 0,
    },
    this.topicReadCounts = const {},
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      nome: json['nome'] as String?,
      imageUrl: json['imageUrl'] as String?,
      age: json['age'] as int?,
      subscription: json['subscription'] ?? 'Free',
      level: json['level'] ?? 1,
      xp: json['xp'] ?? 0,
      nextLevelXp: json['nextLevelXp'] ?? 500,
      stats: Map<String, int>.from(json['stats'] ?? {}),
      topicReadCounts: Map<String, int>.from(json['topicReadCounts'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nome': nome,
      'imageUrl': imageUrl,
      'age': age,
      'subscription': subscription,
      'level': level,
      'xp': xp,
      'nextLevelXp': nextLevelXp,
      'stats': stats,
      'topicReadCounts': topicReadCounts,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
