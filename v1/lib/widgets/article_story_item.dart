import 'package:flutter/cupertino.dart';
import '../models/article.dart';
import '../core/theme/app_theme.dart';
import '../screens/article_detail_screen.dart';

class ArticleStoryItem extends StatelessWidget {
  final Article article;

  const ArticleStoryItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ArticleDetailScreen(article: article),
          ),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // IMAGEM DE FUNDO
          if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
            Image.asset(
              article.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppTheme.phatoCardGray,
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.photo,
                      color: AppTheme.phatoTextGray,
                      size: 50,
                    ),
                  ),
                );
              },
            )
          else
            Container(color: AppTheme.phatoBlack),

          // GRADIENTE PARA LEGIBILIDADE
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.phatoBlack.withOpacity(0.0),
                  AppTheme.phatoBlack.withOpacity(0.2),
                  AppTheme.phatoBlack.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // CONTEÚDO DE TEXTO
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categoria
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.phatoYellow,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.phatoYellow, width: 1),
                  ),
                  child: Text(
                    article.category.toUpperCase(),
                    style: AppTheme.bodyTextStyle.copyWith(
                      color: AppTheme.phatoBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Título
                Text(
                  article.title,
                  style: AppTheme.headlineStyle.copyWith(
                    fontSize: 26,
                    color: AppTheme.phatoLightGray,
                    shadows: [
                      const Shadow(
                        blurRadius: 6.0,
                        color: AppTheme.phatoBlack,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                //Descrição
                Flexible(
                  child: Text(
                    article.description ?? 'Sem resumo disponível.',
                    style: AppTheme.bodyTextStyle.copyWith(
                      color: AppTheme.phatoLightGray,
                      fontSize: 16,
                      height: 1.4,
                      shadows: [
                        const Shadow(
                          blurRadius: 4.0,
                          color: AppTheme.phatoBlack,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
