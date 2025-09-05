import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/screens/feed_tab_screen.dart';
import 'package:phato_prototype/screens/phatobot_screen.dart';
import 'package:phato_prototype/screens/search_screen.dart';
import 'package:phato_prototype/screens/user_profile_screen.dart';
import '../core/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // CORREÇÃO: A classe de estado agora é pública (HomeScreenState)
  // para que outros widgets possam aceder ao seu `tabController`.
  State<HomeScreen> createState() => HomeScreenState();
}

// A classe de estado agora é pública.
class HomeScreenState extends State<HomeScreen> {
  late CupertinoTabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = CupertinoTabController();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: tabController,
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0: // Feed
            return const FeedTabPage();
          case 1: // Pesquisa
            return const SearchScreen();
          case 2: // PhatoBot
            return const PhatoBotScreen();
          case 3: // Perfil
            return const UserProfileScreen();
          default:
            return const FeedTabPage();
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
              child: Icon(CupertinoIcons.search),
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
              child: Icon(CupertinoIcons.person),
            ),
          ),
        ],
      ),
    );
  }
}
