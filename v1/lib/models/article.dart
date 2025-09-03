// --- INSTRUÇÕES ---
// 1. Substitua o conteúdo do seu `lib/models/article.dart` por este código.
// 2. A adição do construtor `const` aqui resolverá todos os erros do `feed_screen.dart`.

class Article {
  final String id;
  final String title;
  final String source;
  final String time;
  final String imageUrl;
  final String content;

  // CORREÇÃO AQUI: Adicionamos a palavra-chave `const` ao construtor.
  // Isso permite que objetos `Article` sejam criados em tempo de compilação,
  // o que é necessário para listas constantes, como as que usamos na FeedScreen.
  const Article({
    required this.id,
    required this.title,
    required this.source,
    required this.time,
    required this.imageUrl,
    required this.content,
  });
}
