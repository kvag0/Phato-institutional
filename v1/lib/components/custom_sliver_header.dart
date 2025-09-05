import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/screens/search_screen.dart';
import '../core/theme/app_theme.dart';
import '../screens/home_screen.dart'; // Import necessário para aceder a HomeScreenState
import '../widgets/category_highlights_bar.dart';
import 'feed_filter_toggle.dart';
import 'welcome_header.dart';

class CustomSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;

  const CustomSliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = (shrinkOffset / (maxHeight - minHeight)).clamp(0.0, 1.0);
    final contentOpacity = (1.0 - (progress * 2)).clamp(0.0, 1.0);
    final headerFilterOpacity = ((progress - 0.5) * 2).clamp(0.0, 1.0);

    return Container(
      color: AppTheme.phatoBlack,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Conteúdo que desaparece
          Positioned(
            top: minHeight,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              physics:
                  const NeverScrollableScrollPhysics(), // Impede o scroll manual
              child: Opacity(
                opacity: contentOpacity,
                child: IgnorePointer(
                  ignoring: contentOpacity == 0.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WelcomeHeader(),
                      const CategoryHighlightsBar(),
                      const FeedFilterToggle(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Cabeçalho fixo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppTheme.phatoBlack,
              height: minHeight,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 16,
                right: 16,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Logo e Ícones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 90,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Phato', style: AppTheme.logoStyle),
                        ),
                      ),
                      SizedBox(
                        width: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CupertinoButton(
                              padding: const EdgeInsets.all(4.0),
                              onPressed: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => const SearchScreen(),
                                  ),
                                );
                              },
                              child: const Icon(
                                CupertinoIcons.search,
                                color: AppTheme.phatoTextGray,
                              ),
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.all(4.0),
                              // CORREÇÃO: A lógica agora procura pelo estado público `HomeScreenState`
                              // para encontrar o controlador e mudar de aba programaticamente.
                              onPressed: () {
                                final homeScreenState = context
                                    .findAncestorStateOfType<HomeScreenState>();
                                homeScreenState?.tabController.index = 3;
                              },
                              child: const Icon(
                                CupertinoIcons.person,
                                color: AppTheme.phatoTextGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Filtros que aparecem
                  Opacity(
                    opacity: headerFilterOpacity,
                    child: const FeedFilterToggle(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
