import 'package:flutter/material.dart';
import '../models/article.dart';

// --- INSTRUÇÕES ---
// 1. Substitua o conteúdo do seu `lib/screens/article_detail_screen.dart` por este código.
// 2. Este novo design é fiel ao do repositório original.

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Conteúdo estático de exemplo para o corpo do artigo
    const String articleBody =
        'Este é um texto de exemplo para o corpo do artigo. Ele simula o conteúdo completo de uma notícia, permitindo que a gente veja como o layout se comporta com parágrafos mais longos.\n\nA estrutura da página foi desenhada para ser limpa e focada na leitura, com uma imagem de destaque no topo que se retrai elegantemente ao rolar a tela. A barra de ações na parte inferior oferece engajamento rápido, mesmo em um protótipo estático como este.\n\nContinuaremos a refatorar o restante do aplicativo para garantir que cada tela seja uma representação fiel do design original do Phato.';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar com a imagem que colapsa
          SliverAppBar(
            expandedHeight: 250.0,
            backgroundColor: theme.scaffoldBackgroundColor,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                article.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),
          // Conteúdo do artigo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(article.title, style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 12),
                  // Fonte e tempo
                  Row(
                    children: [
                      Text(
                        article.source.toUpperCase(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('•'),
                      const SizedBox(width: 8),
                      Text(
                        article.time,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  // Corpo do artigo
                  Text(
                    articleBody,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Barra de ações inferior
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.thumb_up_outlined),
              onPressed: () {},
              tooltip: 'Gostei',
            ),
            IconButton(
              icon: const Icon(Icons.thumb_down_outlined),
              onPressed: () {},
              tooltip: 'Não Gostei',
            ),
            IconButton(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {},
              tooltip: 'Salvar',
            ),
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {},
              tooltip: 'Compartilhar',
            ),
          ],
        ),
      ),
    );
  }
}
