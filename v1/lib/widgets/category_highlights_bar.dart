import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';
import '../data/static_data.dart';
import '../models/highlight_timeline.dart';
import '../screens/highlight_story_screen.dart';

class CategoryHighlightsBar extends StatelessWidget {
  const CategoryHighlightsBar({super.key});

  String _formatTitle(String title) {
    return title.replaceFirst(' ', '\n');
  }

  @override
  Widget build(BuildContext context) {
    final List<HighlightTimeline> timelines = allHighlightTimelines;

    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timelines.length + 1,
        padding: const EdgeInsets.only(left: 16.0),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddItem();
          }
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
          color: AppTheme.phatoGray.withOpacity(0.5),
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

  Widget _buildHighlightItem(BuildContext context, HighlightTimeline timeline) {
    return _buildBaseHighlight(
      title: timeline.title,
      child: ClipOval(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            //border: Border.all(color: AppTheme.phatoYellow, width: 2.5),
          ),
          child: Image.asset(
            timeline.coverImageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppTheme.phatoGray,
                child: const Icon(
                  CupertinoIcons.photo,
                  color: AppTheme.phatoTextGray,
                ),
              );
            },
          ),
        ),
      ),
      onTap: () {
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
        // (ALTERADO) Alinha os itens pelo topo.
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: circleSize, height: circleSize, child: child),
          const SizedBox(height: 6),
          Text(
            _formatTitle(title),
            maxLines: 2,
            textAlign: TextAlign.center,
            style: AppTheme.secondaryTextStyle.copyWith(
              fontSize: 14,
              // (NOVO) Reduz o espaçamento entre as linhas.
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
