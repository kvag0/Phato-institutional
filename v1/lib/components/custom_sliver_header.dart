import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/screens/search_screen.dart';
import '../core/theme/app_theme.dart';
import 'feed_filter_toggle.dart';
import 'welcome_header.dart';
import '../screens/user_profile_screen.dart';
import '../widgets/category_highlights_bar.dart';

class CustomSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final ScrollController scrollController;

  const CustomSliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.scrollController,
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
      child: Column(
        children: [
          // Barra fixa do topo
          Container(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 90,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (scrollController.offset > 0) {
                              scrollController.animateTo(
                                0.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            }
                          },
                          child: Text('Phato.', style: AppTheme.logoStyle),
                        ),
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
                            onPressed: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const UserProfileScreen(),
                                ),
                              );
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
                Opacity(
                  opacity: headerFilterOpacity,
                  child: const FeedFilterToggle(),
                ),
              ],
            ),
          ),

          // Conteúdo que desaparece com o scroll
          Expanded(
            child: Opacity(
              opacity: contentOpacity,
              child: IgnorePointer(
                ignoring: contentOpacity == 0.0,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
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
    final old = oldDelegate as CustomSliverHeaderDelegate;
    return old.minHeight != minHeight ||
        old.maxHeight != maxHeight ||
        old.scrollController != scrollController;
  }
}
