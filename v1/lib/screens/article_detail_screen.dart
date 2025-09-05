import 'package:flutter/cupertino.dart';
import '../models/article.dart';
import '../core/theme/app_theme.dart';
import 'phatobot_screen.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Adquirir o padding inferior para ajustar a posição do botão
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          article.source.name,
          style: AppTheme.secondaryTextStyle.copyWith(fontSize: 16),
        ),
        leading: const CupertinoNavigationBarBackButton(),
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
      child: Stack(
        children: [
          // Conteúdo principal com scroll
          Positioned.fill(
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.only(
                    bottom: 80), // Espaço para o botão flutuante
                children: [
                  if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
                    // CORREÇÃO: Alterado de Image.network para Image.asset
                    Image.asset(
                      article.imageUrl!,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          color: AppTheme.phatoCardGray,
                          child: const Icon(CupertinoIcons.photo,
                              color: AppTheme.phatoTextGray),
                        );
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article.title, style: AppTheme.headlineStyle),
                        const SizedBox(height: 8),
                        Text(
                          'Por ${article.author ?? article.source.name}',
                          style: AppTheme.secondaryTextStyle
                              .copyWith(fontSize: 14),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          article.content ?? 'Conteúdo não disponível.',
                          style: AppTheme.bodyTextStyle.copyWith(height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        if (article.analysis != null)
                          _buildAnalysisSection(article.analysis!)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Botão flutuante do PhatoBot
          Positioned(
            bottom:
                bottomPadding + 16, // Posição ajustada com o padding inferior
            left: 16,
            right: 16,
            child: CupertinoButton(
              color: AppTheme.phatoYellow,
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => PhatoBotScreen(article: article),
                  ),
                );
              },
              child: Text(
                'Perguntar ao PhatoBot',
                style: AppTheme.bodyTextStyle.copyWith(
                  color: AppTheme.phatoBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAnalysisSection(Analysis analysis) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.phatoCardGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Análise Phato',
            style: AppTheme.headlineStyle.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 16),
          if (analysis.facts != null) _buildFactsSection(analysis.facts!),
          const SizedBox(height: 20),
          Text(
            'Narrativas Identificadas',
            style: AppTheme.headlineStyle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 10),
          ...analysis.narratives.map(
            (narrative) => _buildNarrativeCard(narrative),
          ),
        ],
      ),
    );
  }

  Widget _buildFactsSection(Facts facts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFactRow(CupertinoIcons.person_2, 'Quem:', facts.who.join(', ')),
        _buildFactRow(CupertinoIcons.doc_text, 'O quê:', facts.what),
        _buildFactRow(CupertinoIcons.calendar, 'Quando:', facts.when),
        _buildFactRow(CupertinoIcons.location, 'Onde:', facts.where.join(', ')),
      ],
    );
  }

  Widget _buildFactRow(IconData icon, String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.phatoYellow, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '$label ',
                style: AppTheme.bodyTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: value,
                    style: AppTheme.bodyTextStyle.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrativeCard(Narrative narrative) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            narrative.title ?? 'Título da Perspetiva',
            style: AppTheme.bodyTextStyle.copyWith(
              color: AppTheme.phatoYellow,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            narrative.summary ?? 'Sem resumo.',
            style: AppTheme.secondaryTextStyle,
          ),
        ],
      ),
    );
  }
}
