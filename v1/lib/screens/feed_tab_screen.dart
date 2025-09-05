import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/models/article.dart';
import 'package:phato_prototype/widgets/article_story_item.dart';
import 'package:phato_prototype/widgets/category_highlights_bar.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:intl/intl.dart';

// Lista de notícias estáticas para o protótipo
final List<Article> _mockArticles = [
  Article(
    id: '1',
    title: 'Avanços em IA Generativa Podem Mudar o Mercado de Trabalho',
    url: '',
    source: Source(name: 'Tech News'),
    author: 'Ana Coda',
    publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
    category: 'Tecnologia',
    description:
        'Novas IAs generativas estão automatizando tarefas criativas, levantando debates sobre o futuro de diversas profissões e a necessidade de novas habilidades.',
    imageUrl: 'https://placehold.co/600x800/2a2a2a/ffffff?text=IA',
    fetchedAt: DateTime.now(),
    tags: ['IA', 'Tecnologia', 'Futuro'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Article(
    id: '2',
    title:
        'Cientistas Descobrem Novo Exoplaneta com Potencial para Água Líquida',
    url: '',
    source: Source(name: 'Space Today'),
    publishedAt: DateTime.now().subtract(const Duration(days: 1)),
    category: 'Ciência',
    description:
        'Um novo planeta, apelidado de "Aqua-Mundo", foi localizado a 40 anos-luz de distância e parece ter as condições ideais para a existência de oceanos.',
    imageUrl: 'https://placehold.co/600x800/2a2a2a/ffffff?text=Espaço',
    fetchedAt: DateTime.now(),
    tags: ['Espaço', 'Ciência'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Article(
    id: '3',
    title: 'Banco Central Anuncia Medidas para Conter a Inflação',
    url: '',
    source: Source(name: 'Economia Global'),
    author: 'Mercado Financeiro',
    publishedAt: DateTime.now().subtract(const Duration(minutes: 30)),
    category: 'Economia',
    description:
        'Em resposta à alta dos preços, o Banco Central elevou a taxa de juros e anunciou novas políticas para estabilizar a economia nos próximos meses.',
    imageUrl: 'https://placehold.co/600x800/2a2a2a/ffffff?text=Economia',
    fetchedAt: DateTime.now(),
    tags: ['Economia', 'Finanças'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Article(
    id: '4',
    title: 'Final do Campeonato de E-Sports Quebra Recordes de Audiência',
    url: '',
    source: Source(name: 'Game Mania'),
    publishedAt: DateTime.now().subtract(const Duration(days: 2)),
    category: 'Esportes',
    description:
        'A grande final do torneio mundial de "Cyber Arena" atraiu milhões de espectadores online, consolidando os e-sports como um dos maiores entretenimentos da atualidade.',
    imageUrl: 'https://placehold.co/600x800/2a2a2a/ffffff?text=E-Sports',
    fetchedAt: DateTime.now(),
    tags: ['Games', 'E-sports'],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

class FeedTabScreen extends StatefulWidget {
  const FeedTabScreen({super.key});

  @override
  State<FeedTabScreen> createState() => _FeedTabScreenState();
}

class _FeedTabScreenState extends State<FeedTabScreen> {
  final PageController _pageController = PageController();
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page == null) return;
      // Entra em tela cheia após o primeiro item
      if (_pageController.page! > 0.5 && !_isFullScreen) {
        setState(() => _isFullScreen = true);
      } else if (_pageController.page! <= 0.5 && _isFullScreen) {
        setState(() => _isFullScreen = false);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usamos um PageView para o scroll vertical de notícias
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _mockArticles.length + 1, // +1 para a tela inicial do feed
      itemBuilder: (context, index) {
        if (index == 0) {
          // A primeira "página" é o feed normal com cabeçalho
          return _buildStandardFeed();
        }
        // As páginas seguintes são as notícias em tela cheia
        final article = _mockArticles[index - 1];
        return ArticleStoryItem(article: article);
      },
    );
  }

  // Widget para o feed padrão (primeira página)
  Widget _buildStandardFeed() {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Phato'),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeHeader(),
                const CategoryHighlightsBar(),
                _buildFeedTabs(),
                // Mostra a primeira notícia do mock como um card
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ArticleStoryItem(article: _mockArticles[0]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    final String formattedDate =
        DateFormat('d MMMM y', 'pt_BR').format(DateTime.now());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedDate.toUpperCase(),
            style: AppTheme.secondaryTextStyle.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            'Bem-vindo ao Phato',
            style: AppTheme.headlineStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildFeedTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: CupertinoSlidingSegmentedControl<int>(
        groupValue: 0,
        children: const {
          0: Text('Para Você'),
          1: Text('Para Sua Região'),
        },
        onValueChanged: (value) {
          // Lógica do seletor (não implementada para o protótipo)
        },
      ),
    );
  }
}
