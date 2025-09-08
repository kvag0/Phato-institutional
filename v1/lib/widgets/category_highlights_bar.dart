import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';
import '../data/static_data.dart';
import '../models/highlight_timeline.dart';
import '../screens/highlight_story_screen.dart';

class CategoryHighlightsBar extends StatelessWidget {
  const CategoryHighlightsBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Carrega as linhas do tempo dos nossos dados estáticos
    final List<HighlightTimeline> timelines = allHighlightTimelines;

    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timelines.length + 1, // +1 para o botão "Adicionar"
        padding: const EdgeInsets.only(left: 16.0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddItem();
          }
          // Ajusta o índice para aceder à lista de timelines
          final timeline = timelines[index - 1];
          return _buildHighlightItem(context, timeline);
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
          color: AppTheme.phatoGray,
        ),
        child: const Icon(
          CupertinoIcons.add,
          color: AppTheme.phatoTextGray,
          size: 32,
        ),
      ),
      onTap: () {
        // Ação de adicionar (não implementada no protótipo)
      },
    );
  }

  Widget _buildHighlightItem(BuildContext context, HighlightTimeline timeline) {
    return _buildBaseHighlight(
      title: timeline.title,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppTheme.phatoYellow, width: 2.5),
          image: DecorationImage(
            fit: BoxFit.cover,
            // Carrega a imagem de capa da timeline
            image: AssetImage(timeline.coverImageUrl),
          ),
        ),
      ),
      onTap: () {
        // Navega para a nova tela de visualização de histórias
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => HighlightStoryScreen(timeline: timeline),
          ),
        );
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
