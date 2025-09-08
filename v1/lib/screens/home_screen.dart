import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/screens/feed_tab_screen.dart';
import 'package:phato_prototype/screens/phatobot_screen.dart';
import 'package:phato_prototype/screens/search_screen.dart';
import 'package:phato_prototype/screens/finance_screen.dart';
import 'package:phato_prototype/screens/user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late CupertinoTabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = CupertinoTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void changeTab(int index) {
    tabController.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: tabController,
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => FeedTabPage());
          case 1:
            return CupertinoTabView(builder: (context) => const SearchScreen());
          case 2:
            return CupertinoTabView(
                builder: (context) =>
                    const PhatoBotScreen(comesFromArticle: null));
          case 3:
            return CupertinoTabView(
                builder: (context) => const FinanceScreen());
          default:
            return CupertinoTabView(builder: (context) => FeedTabPage());
        }
      },
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            //label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            //label: 'Pesquisa',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            //label: 'PhatoBot',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar_alt_fill),
            //label: 'Finanças',
          ),
        ],
      ),
    );
  }
}
