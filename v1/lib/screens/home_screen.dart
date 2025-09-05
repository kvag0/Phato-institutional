import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/screens/feed_tab_screen.dart';
import 'package:phato_prototype/screens/phatobot_screen.dart';
import 'package:phato_prototype/screens/user_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0: // Aba "Feed"
            return CupertinoTabView(
              builder: (context) {
                return const FeedTabScreen();
              },
            );
          case 1: // Aba "PhatoBot"
            return CupertinoTabView(
              builder: (context) {
                return const PhatoBotScreen();
              },
            );
          case 2: // Aba "Perfil"
            return CupertinoTabView(
              builder: (context) {
                return const UserProfileScreen();
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return const FeedTabScreen();
              },
            );
        }
      },
      tabBar: CupertinoTabBar(
        activeColor: AppTheme.phatoYellow,
        inactiveColor: AppTheme.phatoTextGray,
        backgroundColor: AppTheme.phatoBlack.withOpacity(0.95),
        border: null,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(CupertinoIcons.home),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(CupertinoIcons.square_grid_2x2),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(CupertinoIcons.graph_circle),
            ),
          ),
        ],
      ),
    );
  }
}
