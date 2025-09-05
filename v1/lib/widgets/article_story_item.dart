import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/models/article.dart';
import 'package:phato_prototype/screens/article_detail_screen.dart';

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
          // Camada 1: Imagem de Fundo com Tratamento de Erro
          if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
            Image.network(
              article.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: AppTheme.phatoBlack);
              },
            )
          else
            Container(color: AppTheme.phatoBlack),

          // Camada 2: Filtro escuro sobre a imagem
          Container(
            color: AppTheme.phatoBlack.withOpacity(0.5),
          ),

          // Camada 3: Conteúdo de Texto
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 100.0, bottom: 150.0),
            // CORREÇÃO FINAL: Usamos um LayoutBuilder com um SingleChildScrollView
            // para garantir que o conteúdo se alinhe em baixo e seja rolável
            // se o espaço for insuficiente, resolvendo o overflow em todos os casos.
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Categoria
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.phatoYellow.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppTheme.phatoYellow, width: 1),
                            ),
                            child: Text(
                              article.category.toUpperCase(),
                              style: AppTheme.bodyTextStyle.copyWith(
                                color: AppTheme.phatoYellow,
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
                              color: AppTheme.phatoTextGray,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),

                          // Descrição
                          Text(
                            article.description ?? 'Sem resumo disponível.',
                            style: AppTheme.bodyTextStyle.copyWith(
                              color: AppTheme.phatoTextGray.withOpacity(0.8),
                              fontSize: 16,
                              height: 1.4,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
