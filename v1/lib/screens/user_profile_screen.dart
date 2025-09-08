import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';
import '../data/static_data.dart';
import '../models/topic.dart';
import '../models/usuario.dart';
import 'settings_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _selectedSegment = 0;
  final Usuario usuario = staticUser;

  void _showXpInfoPopup(BuildContext context, String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: const Text('Entendi'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Perfil',
            style: AppTheme.headlineStyle.copyWith(fontSize: 18)),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.settings),
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, usuario),
            _buildSegmentedControl(context),
            Expanded(
              child: _buildSelectedTabView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedTabView() {
    switch (_selectedSegment) {
      case 0:
        return _buildStatsTab(context, usuario, allTopics);
      case 1:
        return _buildAchievementsTab(context, usuario, staticAchievements);
      case 2:
        return _buildActivityTab(context, staticActivities);
      default:
        return Container();
    }
  }

  Widget _buildHeader(BuildContext context, Usuario usuario) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: AppTheme.phatoGray,
              shape: BoxShape.circle,
              image: usuario.imageUrl != null && usuario.imageUrl!.isNotEmpty
                  ? DecorationImage(
                      image: AssetImage(usuario.imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: usuario.imageUrl == null || usuario.imageUrl!.isEmpty
                ? const Icon(
                    CupertinoIcons.person_fill,
                    size: 50,
                    color: AppTheme.phatoLightGray,
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                usuario.nome ?? 'Utilizador Phato',
                style: AppTheme.headlineStyle.copyWith(fontSize: 22),
              ),
              if (usuario.subscription == 'Pro') ...[
                const SizedBox(width: 8),
                const Icon(
                  CupertinoIcons.checkmark_seal_fill,
                  color: AppTheme.phatoYellow,
                  size: 22,
                )
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CupertinoSlidingSegmentedControl<int>(
        groupValue: _selectedSegment,
        backgroundColor: AppTheme.phatoGray,
        thumbColor: AppTheme.phatoYellow,
        padding: const EdgeInsets.all(4),
        children: {
          0: Text(
            'Estatísticas',
            style: AppTheme.bodyTextStyle.copyWith(
              color: AppTheme.phatoBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          1: Text(
            'Conquistas',
            style: AppTheme.bodyTextStyle.copyWith(
              color: AppTheme.phatoBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          2: Text(
            'Atividade',
            style: AppTheme.bodyTextStyle.copyWith(
              color: AppTheme.phatoBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        },
        onValueChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedSegment = value;
            });
          }
        },
      ),
    );
  }

  Widget _buildStatsTab(
      BuildContext context, Usuario usuario, List<Topic> allTopics) {
    final totalArticlesRead = usuario.stats['articlesRead'] ?? 0;
    final List<TopicData> allTopicsData = allTopics.map((topic) {
      return TopicData(
        name: topic.nome,
        chave: topic.chave,
        icon: topic.icon,
        count: usuario.topicReadCounts[topic.chave] ?? 0,
      );
    }).toList();

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionTitleWithHelp(
          context,
          'Seus Interesses',
          'XP em Seus Interesses',
          'Tópicos que representam 10% ou mais das suas leituras. Ler mais artigos destes tópicos garante +10 XP.',
        ),
        const SizedBox(height: 12),
        ...allTopicsData.map((topic) =>
            _buildTopicInterestRow(context, topic, totalArticlesRead)),
      ],
    );
  }

  Widget _buildTopicInterestRow(
      BuildContext context, TopicData topic, int total) {
    final double progress = total > 0 ? topic.count / total : 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.phatoGray,
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
                  '${topic.name} (${topic.count} artigos)',
                  style: AppTheme.bodyTextStyle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Barra de progresso personalizada
          CustomProgressBar(progress: progress),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab(
      BuildContext context, Usuario usuario, List<Achievement> achievements) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildLevelCard(
            context, usuario.level, usuario.xp, usuario.nextLevelXp),
        const SizedBox(height: 32),
        Text(
          'Meus Emblemas (${achievements.length})',
          style: AppTheme.headlineStyle.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemCount: achievements.length,
          itemBuilder: (context, index) =>
              _buildAchievementBadge(context, achievements[index]),
        ),
      ],
    );
  }

  Widget _buildLevelCard(
      BuildContext context, int level, int currentXp, int nextLevelXp) {
    final double progress = nextLevelXp > 0 ? currentXp / nextLevelXp : 0;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.phatoGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NÍVEL $level',
            style: AppTheme.secondaryTextStyle
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Leitor Mestre',
            style: AppTheme.headlineStyle.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 16),
          CustomProgressBar(progress: progress, height: 12),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$currentXp / $nextLevelXp XP',
                style: AppTheme.secondaryTextStyle,
              ),
              Text(
                '${nextLevelXp - currentXp} para o próximo nível',
                style: AppTheme.secondaryTextStyle,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(BuildContext context, Achievement achievement) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: achievement.color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(achievement.icon, color: achievement.color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          achievement.name,
          textAlign: TextAlign.center,
          style: AppTheme.secondaryTextStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildActivityTab(
      BuildContext context, List<ActivityItem> activities) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: activities.length,
      itemBuilder: (context, index) =>
          _buildActivityListItem(context, activities[index]),
    );
  }

  Widget _buildActivityListItem(BuildContext context, ActivityItem activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppTheme.phatoGray,
              shape: BoxShape.circle,
            ),
            child: Icon(activity.icon, color: AppTheme.phatoYellow),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title, style: AppTheme.bodyTextStyle),
                const SizedBox(height: 4),
                Text(activity.timestamp, style: AppTheme.secondaryTextStyle),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitleWithHelp(BuildContext context, String title,
      String popupTitle, String popupContent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: AppTheme.headlineStyle.copyWith(fontSize: 18)),
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.question_circle,
            color: AppTheme.phatoTextGray,
            size: 20,
          ),
          onPressed: () => _showXpInfoPopup(context, popupTitle, popupContent),
        ),
      ],
    );
  }
}

// Widget personalizado para a barra de progresso para evitar dependências do Material.
class CustomProgressBar extends StatelessWidget {
  final double progress;
  final double height;

  const CustomProgressBar({
    super.key,
    required this.progress,
    this.height = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Container(
        height: height,
        color: AppTheme.phatoBlack,
        child: Align(
          alignment: Alignment.centerLeft,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                color: AppTheme.phatoYellow,
              );
            },
          ),
        ),
      ),
    );
  }
}
