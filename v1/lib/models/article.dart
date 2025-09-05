import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart'; // Import para IconData

// Função auxiliar para fazer o parse de datas de forma segura.
DateTime _safeParseDateTime(dynamic input, {String debugLabel = ''}) {
  if (input == null) {
    return DateTime.now();
  }
  if (input is String) {
    try {
      return DateTime.parse(input);
    } catch (e) {
      return DateTime.now();
    }
  }
  return DateTime.now();
}

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
  final Analysis? analysis; // MUDANÇA: Tornou-se opcional
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
    this.analysis, // MUDANÇA: 'required' removido
    required this.fetchedAt,
    required this.tags,
    this.language,
    required this.createdAt,
    required this.updatedAt,
  });
}

class Source {
  final String? id;
  final String name;
  final String? url;

  Source({this.id, required this.name, this.url});
}

class Analysis {
  final Facts? facts;
  final List<Narrative> narratives;
  final DateTime? analyzedAt;
  final String? geminiVersion;

  Analysis({
    this.facts,
    required this.narratives,
    this.analyzedAt,
    this.geminiVersion,
  });
}

class Facts {
  final List<String> who;
  final String? what;
  final String? when;
  final List<String> where;
  final String? why;
  final String? summary;

  Facts({
    required this.who,
    this.what,
    this.when,
    required this.where,
    this.why,
    this.summary,
  });
}

class Narrative {
  final String? perspective;
  final String? title;
  final String? summary;
  final List<String> emphasis;
  final String? interpretation;

  Narrative({
    this.perspective,
    this.title,
    this.summary,
    required this.emphasis,
    this.interpretation,
  });
}
