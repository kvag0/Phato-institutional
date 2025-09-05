// CÓDIGO COMPLETO E CORRIGIDO para: lib/screens/user_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phato_mvp/models/usuario.dart';
import 'package:phato_mvp/models/topic.dart';
import 'package:phato_mvp/services/user_service.dart';
import 'package:phato_mvp/services/topic_service.dart';
import 'package:phato_mvp/screens/settings_screen.dart';

// Modelos de dados para as abas
class Achievement {
  final String name;
  final IconData icon;
  final Color color;
  const Achievement({required this.name, required this.icon, required this.color});
}
class ActivityItem {
  final String title;
  final IconData icon;
  final String timestamp;
  const ActivityItem({required this.title, required this.icon, required this.timestamp});
}
class TopicData {
  final String name;
  final String chave;
  final IconData icon;
  final int count;
  const TopicData({required this.name, required this.chave, required this.icon, required this.count});
}

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});
  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> with SingleTickerProviderStateMixin {
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

  void _showXpInfoPopup(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardTheme.color,
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        content: Text(content, style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('ENTENDI', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showTopicNavigationPopup(BuildContext context, String topic) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardTheme.color,
        title: Text('Explorar Tópico', style: Theme.of(context).textTheme.titleLarge),
        content: Text('Deseja ver mais notícias sobre "$topic"?', style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Navegando para $topic (a ser implementado)...')));
            },
            child: const Text('Navegar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfileAsyncValue = ref.watch(userProfileProvider);
    final allTopicsAsyncValue = ref.watch(allTopicsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Perfil', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: userProfileAsyncValue.when(
        data: (usuario) {
          if (usuario == null) return const Center(child: Text('Não foi possível carregar o perfil.'));
          
          return allTopicsAsyncValue.when(
            data: (allTopics) => _buildProfileView(context, usuario, allTopics),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Erro ao carregar temas: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erro ao carregar perfil: $error')),
      ),
    );
  }
  
  Widget _buildProfileView(BuildContext context, Usuario usuario, List<Topic> allTopics) {
    const List<Achievement> achievements = [
      Achievement(name: 'Leitor Bronze', icon: Icons.military_tech, color: Color(0xffcd7f32)),
      Achievement(name: 'Leitor Prata', icon: Icons.military_tech, color: Color(0xffc0c0c0)),
    ];
    const List<ActivityItem> mockActivities = [
      ActivityItem(title: 'Você ganhou o emblema "Leitor Ouro"', icon: Icons.military_tech, timestamp: 'Hoje'),
    ];
    
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(child: _buildHeader(context, usuario)),
        SliverPersistentHeader(
          delegate: _SliverAppBarDelegate(
            TabBar(
              controller: _tabController,
              labelStyle: GoogleFonts.leagueSpartan(fontWeight: FontWeight.bold),
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey.shade400,
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: const [Tab(text: 'ESTATÍSTICAS'), Tab(text: 'CONQUISTAS'), Tab(text: 'ATIVIDADE')],
            ),
          ),
          pinned: true,
        )
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStatsTab(context, usuario, allTopics),
          _buildAchievementsTab(context, usuario, achievements),
          _buildActivityTab(context, mockActivities),
        ],
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
            backgroundColor: Colors.grey.shade800,
            backgroundImage: usuario.imageUrl != null && usuario.imageUrl!.isNotEmpty
                ? NetworkImage(usuario.imageUrl!)
                : null,
            child: usuario.imageUrl == null || usuario.imageUrl!.isEmpty
                ? const Icon(Icons.person, size: 50, color: Colors.white70)
                : null,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                usuario.nome ?? 'Utilizador Phato',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (usuario.subscription == 'Pro') ...[
                const SizedBox(width: 8),
                Icon(Icons.verified, color: Theme.of(context).colorScheme.primary, size: 22)
              ]
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatsTab(BuildContext context, Usuario usuario, List<Topic> allTopics) {
    final totalArticlesRead = usuario.stats['articlesRead'] ?? 0;
    
    // 1. Junta os dados do utilizador com a lista mestra de temas
    final List<TopicData> allTopicsData = allTopics.map((topic) {
      return TopicData(
        name: topic.nome,
        chave: topic.chave,
        icon: topic.iconData,
        count: usuario.topicReadCounts[topic.chave] ?? 0,
      );
    }).toList();

    // 2. Prepara as 3 listas que serão preenchidas
    final List<TopicData> strongInterests = [];
    final List<TopicData> topicsToExplore = [];
    final List<TopicData> neverReadTopics = [];

    // 3. Lógica de divisão corrigida e explícita
    for (var topicData in allTopicsData) {
      if (topicData.count == 0) {
        neverReadTopics.add(topicData);
      } else {
        // Só calcula a percentagem se o total de leituras for maior que zero para evitar divisão por zero
        final percentage = (totalArticlesRead > 0) ? topicData.count / totalArticlesRead : 0;
        
        if (percentage >= 0.10) {
          strongInterests.add(topicData);
        } else {
          topicsToExplore.add(topicData);
        }
      }
    }
    
    // 4. Ordena as listas para uma melhor apresentação
    strongInterests.sort((a, b) => b.count.compareTo(a.count));
    topicsToExplore.sort((a, b) => b.count.compareTo(a.count));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 2.0,
            children: [
              _buildStatCard(context, Icons.article_outlined, (usuario.stats['articlesRead'] ?? 0).toString(), 'Artigos Lidos'),
              _buildStatCard(context, Icons.how_to_vote_outlined, (usuario.stats['biasVotes'] ?? 0).toString(), 'Votos de Viés'),
              _buildStatCard(context, Icons.explore_outlined, (usuario.stats['sourcesViewed'] ?? 0).toString(), 'Fontes Vistas'),
              _buildStatCard(context, Icons.military_tech_outlined, 'Nível ${usuario.level}', 'Leitor Mestre'),
            ],
          ),
          const SizedBox(height: 32),

          // Secção "Seus Interesses"
          _buildSectionTitleWithHelp(context, 'Seus Interesses', 'XP em Seus Interesses', 'Tópicos que representam 10% ou mais das suas leituras. Ler mais artigos destes tópicos garante +10 XP.'),
          const SizedBox(height: 12),
          if (strongInterests.isEmpty)
            const Text('Leia artigos para descobrir os seus interesses!', style: TextStyle(color: Colors.grey))
          else
            Column(children: strongInterests.map((topic) => GestureDetector(onTap: () => _showTopicNavigationPopup(context, topic.name), child: _buildTopicInterestRow(context, topic, totalArticlesRead))).toList()),
          
          const SizedBox(height: 32),

          // Secção "Tópicos a Explorar"
          _buildSectionTitleWithHelp(context, 'Tópicos a Explorar', 'XP em Tópicos a Explorar', 'Tópicos que você leu, mas que representam menos de 10% do seu total. Ler artigos destes tópicos garante +20 XP!'),
          const SizedBox(height: 12),
          if (topicsToExplore.isEmpty && strongInterests.isNotEmpty)
            const Text('Você está a focar-se nos seus interesses. Explore novos temas!', style: TextStyle(color: Colors.grey))
          else
            Column(children: topicsToExplore.map((topic) => GestureDetector(onTap: () => _showTopicNavigationPopup(context, topic.name), child: _buildTopicInterestRow(context, topic, totalArticlesRead))).toList()),
            
          const SizedBox(height: 32),
          
          // Secção "Temas Nunca Explorados"
          _buildSectionTitleWithHelp(context, 'Temas Nunca Explorados', 'XP em Temas Nunca Explorados', 'Ler o seu primeiro artigo de um destes temas garante +30 XP!'),
          const SizedBox(height: 12),
          if (neverReadTopics.isEmpty)
            const Text('Você já explorou todos os nossos tópicos. Parabéns!', style: TextStyle(color: Colors.grey))
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.0),
              itemCount: neverReadTopics.length,
              itemBuilder: (context, index) {
                final topic = neverReadTopics[index];
                return GestureDetector(onTap: () => _showTopicNavigationPopup(context, topic.name), child: _buildNeverExploredTopicCard(context, topic));
              },
            ),
        ],
      ),
    );
  }
  
  Widget _buildAchievementsTab(BuildContext context, Usuario usuario, List<Achievement> achievements) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLevelCard(context, usuario.level, usuario.xp, usuario.nextLevelXp),
          const SizedBox(height: 32),
          Text('Meus Emblemas (${achievements.length})', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
            itemCount: achievements.length,
            itemBuilder: (context, index) => _buildAchievementBadge(context, achievements[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab(BuildContext context, List<ActivityItem> activities) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: activities.length,
      itemBuilder: (context, index) => _buildActivityListItem(context, activities[index]),
    );
  }

  Widget _buildStatCard(BuildContext context, IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Theme.of(context).cardTheme.color, borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTopicInterestRow(BuildContext context, TopicData topic, int total) {
    final double progress = total > 0 ? topic.count / total : 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Theme.of(context).cardTheme.color, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(topic.icon, color: Theme.of(context).colorScheme.primary, size: 28),
              const SizedBox(width: 16),
              Expanded(child: Text('${topic.name} (${topic.count} artigos)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
              IconButton(icon: const Icon(Icons.more_horiz), color: Colors.grey, onPressed: () {}),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: progress, backgroundColor: Colors.grey.shade800, valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary), minHeight: 8, borderRadius: BorderRadius.circular(4)),
        ],
      ),
    );
  }
  
  Widget _buildNeverExploredTopicCard(BuildContext context, TopicData topic) {
    return Card(
      elevation: 2.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(topic.icon, color: Theme.of(context).colorScheme.primary, size: 32),
          const SizedBox(height: 8),
          Text(topic.name, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, int level, int currentXp, int nextLevelXp) {
    final double progress = nextLevelXp > 0 ? currentXp / nextLevelXp : 0;
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NÍVEL $level', style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            Text('Leitor Mestre', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            LinearProgressIndicator(value: progress, minHeight: 12, borderRadius: BorderRadius.circular(6), backgroundColor: Colors.grey.shade800, valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$currentXp / $nextLevelXp XP', style: Theme.of(context).textTheme.bodySmall),
                Text('${nextLevelXp - currentXp} para o próximo nível', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }
  
  Widget _buildAchievementBadge(BuildContext context, Achievement achievement) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: achievement.color.withOpacity(0.15),
          child: Icon(achievement.icon, color: achievement.color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(achievement.name, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _buildActivityListItem(BuildContext context, ActivityItem activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).cardTheme.color,
          child: Icon(activity.icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(activity.title, style: Theme.of(context).textTheme.bodyLarge),
        subtitle: Text(activity.timestamp, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
      ),
    );
  }

  Widget _buildSectionTitleWithHelp(BuildContext context, String title, String popupTitle, String popupContent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        IconButton(
          icon: Icon(Icons.help_outline, color: Colors.grey.shade600, size: 20),
          onPressed: () => _showXpInfoPopup(context, popupTitle, popupContent),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }  
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Theme.of(context).scaffoldBackgroundColor, child: _tabBar);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}