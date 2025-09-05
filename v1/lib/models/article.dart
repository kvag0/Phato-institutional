class Article {
  final String id;
  final String title;
  final String url;
  final Source source;
  final String? author;
  final DateTime publishedAt;
  final String category;
  final String? content;
  final String? description;
  final String? imageUrl;
  // Analysis foi removido para simplificar o protótipo
  final DateTime fetchedAt;
  final List<String> tags;
  final String? language;
  final DateTime createdAt;
  final DateTime updatedAt;

  Article({
    required this.id,
    required this.title,
    required this.url,
    required this.source,
    this.author,
    required this.publishedAt,
    required this.category,
    this.content,
    this.description,
    this.imageUrl,
    required this.fetchedAt,
    required this.tags,
    this.language,
    required this.createdAt,
    required this.updatedAt,
  });

  get analysis => null;
}

class Source {
  final String? id;
  final String name;
  final String? url;

  Source({this.id, required this.name, this.url});
}
