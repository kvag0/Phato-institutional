import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          article.source.name,
          style: AppTheme.secondaryTextStyle.copyWith(fontSize: 16),
        ),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.bookmark,
                color: AppTheme.phatoTextGray,
              ),
              onPressed: () {},
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.share,
                color: AppTheme.phatoTextGray,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
              Image.network(
                article.imageUrl!,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.title, style: AppTheme.headlineStyle),
                  const SizedBox(height: 8),
                  Text(
                    'Por ${article.author ?? article.source.name} - ${article.publishedAt.day}/${article.publishedAt.month}/${article.publishedAt.year}',
                    style: AppTheme.secondaryTextStyle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    article.description ?? 'Conteúdo não disponível.',
                    style: AppTheme.bodyTextStyle,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
