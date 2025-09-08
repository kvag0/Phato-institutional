/// Representa um único "capítulo" ou momento dentro de uma linha do tempo de destaque.
class HighlightMoment {
  final String imageUrl;
  final String title;
  final String description;
  final String? articleId; // Ligação opcional a um artigo completo no feed

  const HighlightMoment({
    required this.imageUrl,
    required this.title,
    required this.description,
    this.articleId,
  });
}
