import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';

// Modelo simples para os dados de um destaque
class Highlight {
  final String title;
  final String imagePath;

  Highlight({required this.title, required this.imagePath});
}

class CategoryHighlightsBar extends StatelessWidget {
  const CategoryHighlightsBar({super.key});

  // Lista estática de destaques que agora usa imagens locais.
  static final List<Highlight> _highlights = [
    Highlight(title: 'Economia', imagePath: 'assets/highlights/economia.png'),
    Highlight(title: 'Política', imagePath: 'assets/highlights/politica.png'),
    Highlight(
        title: 'Meio Amb.', imagePath: 'assets/highlights/meio-ambiente.png'),
    Highlight(
        title: 'Tecnologia', imagePath: 'assets/highlights/tecnologia.png'),
    Highlight(title: 'Desporto', imagePath: 'assets/highlights/desporto.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _highlights.length + 1, // +1 para o botão "Adicionar"
        padding: const EdgeInsets.only(left: 16.0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddItem();
          }
          final highlight = _highlights[index - 1];
          return _buildHighlightItem(highlight);
        },
      ),
    );
  }

  Widget _buildAddItem() {
    return _buildBaseHighlight(
      title: 'Adicionar',
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.phatoTextGray, width: 2),
        ),
        child: const Center(
          child: Icon(
            CupertinoIcons.add,
            color: AppTheme.phatoTextGray,
            size: 32,
          ),
        ),
      ),
      onTap: () {
        /* Sem ação por agora */
      },
    );
  }

  Widget _buildHighlightItem(Highlight highlight) {
    return _buildBaseHighlight(
      title: highlight.title,
      child: ClipOval(
        // Usamos ClipOval para garantir que a imagem fique dentro do círculo
        child: Image.asset(
          highlight.imagePath,
          fit: BoxFit.cover,
          width: 70, // Tamanho explícito para a imagem
          height: 70,
          // CORREÇÃO: Adicionamos um errorBuilder para lidar com imagens em falta.
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.phatoCardGray,
                border: Border.all(color: AppTheme.phatoYellow, width: 2.5),
              ),
            );
          },
        ),
      ),
      onTap: () {
        /* Sem ação por agora */
      },
    );
  }

  Widget _buildBaseHighlight({
    required String title,
    required Widget child,
    required VoidCallback onTap,
  }) {
    const double circleSize = 70.0;
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Envolvemos o 'child' (a imagem) num Container com a borda amarela.
          Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.phatoYellow, width: 2.5),
            ),
            child: child,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppTheme.secondaryTextStyle.copyWith(fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
