import 'package:flutter/cupertino.dart';
import '../models/article.dart';
import '../widgets/article_story_item.dart';
import '../components/custom_sliver_header.dart';
import '../data/static_data.dart'; // Importa o novo ficheiro de dados

class FeedTabPage extends StatefulWidget {
  const FeedTabPage({super.key});

  @override
  State<FeedTabPage> createState() => _FeedTabPageState();
}

class _FeedTabPageState extends State<FeedTabPage> {
  // A lista de notícias agora vem do nosso ficheiro de dados centralizado
  final List<Article> _articles = allArticles;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomSliverHeaderDelegate(
              minHeight: 60 + topPadding,
              maxHeight: 320 + topPadding,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: SafeArea(
              top: false,
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                // Usa a lista de artigos local
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  return ArticleStoryItem(article: article);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
