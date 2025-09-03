import 'package:flutter/material.dart';
import '../models/article.dart';

// --- INSTRUÇÕES ---
// 1. Crie uma nova pasta `widgets` dentro da sua pasta `lib`.
// 2. Crie um novo arquivo chamado `highlight_card.dart` dentro de `lib/widgets/`.
// 3. Cole este código no novo arquivo.

class HighlightCard extends StatelessWidget {
  final Article article;

  const HighlightCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Imagem de fundo
            Image.network(
              article.imageUrl,
              fit: BoxFit.cover,
              // Fallback em caso de erro de imagem
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                );
              },
            ),
            // Gradiente para legibilidade do texto
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),
            // Conteúdo de texto
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                article.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 10.0, color: Colors.black)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
