import 'highlight_moment.dart';

/// Representa uma linha do tempo completa de um destaque, que agrupa vários momentos.
class HighlightTimeline {
  final String title;
  final String coverImageUrl;
  final List<HighlightMoment> moments;

  const HighlightTimeline({
    required this.title,
    required this.coverImageUrl,
    required this.moments,
  });
}
