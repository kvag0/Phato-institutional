import 'package:flutter/cupertino.dart';
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
      icon: CupertinoIcons.desktopcomputer),
  Topic(
      nome: 'Economia',
      chave: 'economia',
      icon: CupertinoIcons.money_dollar_circle),
  Topic(nome: 'Ciência', chave: 'ciencia', icon: CupertinoIcons.lab_flask),
  Topic(
      nome: 'Política', chave: 'politica', icon: CupertinoIcons.person_3_fill),
  Topic(nome: 'Esportes', chave: 'esportes', icon: CupertinoIcons.sportscourt),
  Topic(
      nome: 'Meio Ambiente',
      chave: 'meio_ambiente',
      icon: CupertinoIcons.leaf_arrow_circlepath),
];

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int _selectedSegment = 0;

  final Map<int, Widget> _segmentTabs = const {
    0: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('ESTATÍSTICAS')),
    1: Padding(
        padding: EdgeInsets.symmetric(vertical: 8), child: Text('CONQUISTAS')),
    2: Padding(
        padding: EdgeInsets.symmetric(vertical: 8), child: Text('ATIVIDADE')),
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Perfil'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.settings),
              onPressed:
                  null, // Ação de configurações desabilitada no protótipo
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeader(context, mockUser),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl<int>(
                      groupValue: _selectedSegment,
                      children: _segmentTabs,
                      onValueChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedSegment = value;
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    switch (_selectedSegment) {
      case 1:
        return const Center(child: Text("Emblemas e conquistas aqui."));
      case 2:
        return const Center(child: Text("Histórico de atividades aqui."));
      case 0:
      default:
        return _buildStatsTab(context, mockUser, mockTopics);
    }
  }

  Widget _buildHeader(BuildContext context, Usuario usuario) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.phatoGray,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(usuario.imageUrl!),
            ),
          ),
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
    );
  }

  Widget _buildStatsTab(
      BuildContext context, Usuario usuario, List<Topic> allTopics) {
    final totalArticlesRead = usuario.stats['articlesRead'] ?? 0;
    final List<Topic> strongInterests = [];
    final List<Topic> topicsToExplore = [];

    for (var topic in allTopics) {
      final count = usuario.topicReadCounts[topic.chave] ?? 0;
      if (count > 0 && totalArticlesRead > 0) {
        if ((count / totalArticlesRead) >= 0.10) {
          strongInterests.add(topic);
        } else {
          topicsToExplore.add(topic);
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Seus Interesses",
              style: AppTheme.headlineStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 12),
          if (strongInterests.isEmpty)
            const Text("Leia mais para definirmos seus interesses!")
          else
            ...strongInterests.map((topic) => _buildTopicInterestRow(
                context,
                topic,
                usuario.topicReadCounts[topic.chave]!,
                totalArticlesRead)),
          const SizedBox(height: 32),
          Text("Tópicos a Explorar",
              style: AppTheme.headlineStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 12),
          if (topicsToExplore.isEmpty)
            const Text("Você já leu sobre todos os tópicos!")
          else
            ...topicsToExplore.map((topic) => _buildTopicInterestRow(
                context,
                topic,
                usuario.topicReadCounts[topic.chave]!,
                totalArticlesRead)),
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
          // Usando um Container com bordas arredondadas para o progresso
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppTheme.phatoGray,
            ),
            child: FractionallySizedBox(
              widthFactor: progress,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppTheme.phatoYellow,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
