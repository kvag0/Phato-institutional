import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';

class CategoryHighlightsBar extends StatelessWidget {
  const CategoryHighlightsBar({super.key});

  final List<String> _highlightTitles = const [
    'Economia',
    'Política',
    'Meio Amb.',
    'Tecnologia',
    'Esportes',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _highlightTitles.length + 1, // +1 para o botão "Adicionar"
        padding: const EdgeInsets.only(left: 16.0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddItem();
          }
          final title = _highlightTitles[index - 1];
          return _buildHighlightItem(title,
              hasBorder: index == 1); // Simula o primeiro item selecionado
        },
      ),
    );
  }

  Widget _buildAddItem() {
    return _buildBaseHighlight(
      title: 'Adicionar',
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.phatoCardGray,
        ),
        child: const Icon(
          CupertinoIcons.add,
          color: AppTheme.phatoTextGray,
          size: 32,
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildHighlightItem(String title, {bool hasBorder = false}) {
    return _buildBaseHighlight(
      title: title,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: hasBorder
                ? Border.all(color: AppTheme.phatoYellow, width: 2.5)
                : null,
            image: const DecorationImage(
              image: NetworkImage('https://placehold.co/140x140/2a2a2a/2a2a2a'),
              fit: BoxFit.cover,
            )),
      ),
      onTap: () {},
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
          SizedBox(width: circleSize, height: circleSize, child: child),
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
