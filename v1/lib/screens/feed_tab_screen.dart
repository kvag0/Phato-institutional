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
  // (NOVO) Cria um ScrollController para controlar a posição do scroll.
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final List<Article> articles = allArticles;

    return CupertinoPageScaffold(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomSliverHeaderDelegate(
              minHeight: 60 + topPadding,
              maxHeight:
                  295 + topPadding, //310 para mostrar "pra voce | sua regiao"
              scrollController: _scrollController,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ArticleStoryItem(article: article);
              },
            ),
          ),
        ],
      ),
    );
  }
}
