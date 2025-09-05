import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/models/topic.dart';
import 'package:phato_prototype/models/usuario.dart';

// Dados mockados para o protótipo
final mockUser = Usuario(
  id: '1',
  nome: 'Leitor Beta',
  email: 'beta@phato.app',
  imageUrl: 'https://placehold.co/100x100/2a2a2a/ffffff?text=User',
  subscription: 'Pro',
  level: 5,
  xp: 120,
  nextLevelXp: 200,
  stats: {
    'articlesRead': 84,
    'biasVotes': 32,
    'sourcesViewed': 50,
  },
  topicReadCounts: {
    'tecnologia': 30,
    'economia': 25,
    'ciencia': 15,
    'politica': 8,
    'esportes': 6,
  },
);

final List<Topic> mockTopics = [
  Topic(
      nome: 'Tecnologia',
      chave: 'tecnologia',
      icon: CupertinoIcons.desktopcomputer,
      id: '',
      icone: ''),
  Topic(
      nome: 'Economia',
      chave: 'economia',
      icon: CupertinoIcons.money_dollar_circle,
      id: '',
      icone: ''),
  Topic(
      nome: 'Ciência',
      chave: 'ciencia',
      icon: CupertinoIcons.lab_flask,
      id: '',
      icone: ''),
  Topic(
      nome: 'Política',
      chave: 'politica',
      icon: CupertinoIcons.person_3_fill,
      id: '',
      icone: ''),
  Topic(
      nome: 'Esportes',
      chave: 'esportes',
      icon: CupertinoIcons.sportscourt,
      id: '',
      icone: ''),
  Topic(
      nome: 'Meio Ambiente',
      chave: 'meio_ambiente',
      icon: CupertinoIcons.leaf_arrow_circlepath,
      id: '',
      icone: ''),
];

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Perfil'),
          ),
          SliverToBoxAdapter(child: _buildHeader(context, mockUser)),
          SliverPersistentHeader(
            delegate: _SliverAppBarDelegate(
              CupertinoTabBar(
                currentIndex: _tabController.index,
                onTap: (index) {
                  setState(() {
                    _tabController.index = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      label: 'ESTATÍSTICAS',
                      icon: Icon(CupertinoIcons.chart_bar_square)),
                  BottomNavigationBarItem(
                      label: 'CONQUISTAS', icon: Icon(CupertinoIcons.rosette)),
                  BottomNavigationBarItem(
                      label: 'ATIVIDADE', icon: Icon(CupertinoIcons.bell)),
                ],
              ),
            ),
            pinned: true,
          )
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildStatsTab(context, mockUser, mockTopics),
            const Center(child: Text("Conquistas")),
            const Center(child: Text("Atividade")),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Usuario usuario) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppTheme.phatoGray,
            backgroundImage: NetworkImage(usuario.imageUrl!),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                usuario.nome ?? 'Utilizador Phato',
                style: AppTheme.headlineStyle.copyWith(fontSize: 22),
              ),
              if (usuario.subscription == 'Pro') ...[
                const SizedBox(width: 8),
                const Icon(CupertinoIcons.checkmark_seal_fill,
                    color: AppTheme.phatoYellow, size: 22)
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTab(
      BuildContext context, Usuario usuario, List<Topic> allTopics) {
    // Lógica para separar os tópicos
    final totalArticlesRead = usuario.stats['articlesRead'] ?? 0;
    final List<Topic> strongInterests = [];
    final List<Topic> topicsToExplore = [];

    for (var topic in allTopics) {
      final count = usuario.topicReadCounts[topic.chave] ?? 0;
      if (count > 0) {
        if ((count / totalArticlesRead) >= 0.10) {
          strongInterests.add(topic);
        } else {
          topicsToExplore.add(topic);
        }
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Seus Interesses",
              style: AppTheme.headlineStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 12),
          ...strongInterests.map((topic) => _buildTopicInterestRow(context,
              topic, usuario.topicReadCounts[topic.chave]!, totalArticlesRead)),
          const SizedBox(height: 32),
          Text("Tópicos a Explorar",
              style: AppTheme.headlineStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 12),
          ...topicsToExplore.map((topic) => _buildTopicInterestRow(context,
              topic, usuario.topicReadCounts[topic.chave]!, totalArticlesRead)),
        ],
      ),
    );
  }

  Widget _buildTopicInterestRow(
      BuildContext context, Topic topic, int count, int total) {
    final double progress = total > 0 ? count / total : 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.phatoCardGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(topic.icon, color: AppTheme.phatoYellow, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '${topic.nome} ($count artigos)',
                  style: AppTheme.bodyTextStyle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.phatoGray,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppTheme.phatoYellow),
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final CupertinoTabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: AppTheme.phatoBlack, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
