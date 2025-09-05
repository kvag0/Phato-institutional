import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/models/article.dart';
import 'package:phato_prototype/screens/phatobot_screen.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('d MMMM yyyy', 'pt_BR');

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
              onPressed: () {},
              child: const Icon(CupertinoIcons.bookmark,
                  color: AppTheme.phatoTextGray),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: const Icon(CupertinoIcons.share,
                  color: AppTheme.phatoTextGray),
            ),
          ],
        ),
      ),
      child: Stack(
        children: [
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 80), // Espaço para o botão
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
                        'Por ${article.author ?? article.source.name} - ${formatter.format(article.publishedAt)}',
                        style:
                            AppTheme.secondaryTextStyle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 24),
                      if (article.analysis != null)
                        _buildAnalysisSection(article.analysis!)
                      else
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: AppTheme.phatoCardGray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'A análise para este artigo ainda não está disponível.',
                            style: AppTheme.bodyTextStyle,
                          ),
                        ),
                      const SizedBox(height: 24),
                      Text(
                        article.content ?? 'Conteúdo do artigo não disponível.',
                        style: AppTheme.bodyTextStyle.copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Botão flutuante do PhatoBot
          Positioned(
            bottom: 20,
            right: 20,
            child: CupertinoButton(
              color: AppTheme.phatoYellow,
              borderRadius: BorderRadius.circular(30),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => PhatoBotScreen(article: article),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CupertinoIcons.chat_bubble_2_fill,
                      color: AppTheme.phatoBlack),
                  const SizedBox(width: 8),
                  Text(
                    'Perguntar ao PhatoBot',
                    style: AppTheme.bodyTextStyle.copyWith(
                      color: AppTheme.phatoBlack,
                      fontWeight: FontWeight.bold,
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
        _buildFactRow(CupertinoIcons.group, 'Quem:', facts.who.join(', ')),
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
