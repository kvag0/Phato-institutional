import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/components/custom_sliver_header.dart';
import 'package:phato_prototype/models/article.dart';
import 'package:phato_prototype/widgets/article_story_item.dart';

class FeedTabScreen extends StatefulWidget {
  const FeedTabScreen({super.key});

  @override
  State<FeedTabScreen> createState() => _FeedTabScreenState();
}

class _FeedTabScreenState extends State<FeedTabScreen> {
  // Lista de notícias estáticas para o protótipo
  final List<Article> _staticArticles = [
    Article(
      id: '1',
      title: 'Avanços em IA Generativa Transformam a Indústria Criativa',
      url: '',
      source: Source(name: 'Tech Chronicle'),
      author: 'Ana Cordeiro',
      publishedAt: DateTime(2025, 9, 5, 10, 0),
      category: 'Tecnologia',
      content: '...',
      description:
          'Novos modelos de IA estão a criar arte, música e texto com uma qualidade sem precedentes, levantando questões sobre o futuro da criatividade humana.',
      imageUrl: 'https://placehold.co/600x800/0d0d0d/FFFFFF?text=IA+Generativa',
      fetchedAt: DateTime.now(),
      tags: ['ia', 'tecnologia', 'criatividade'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Article(
      id: '2',
      title: 'Cimeira do Clima Termina com Acordo Histórico sobre Emissões',
      url: '',
      source: Source(name: 'Global News'),
      author: 'Rui Martins',
      publishedAt: DateTime(2025, 9, 4, 18, 30),
      category: 'Meio Amb.',
      content: '...',
      description:
          'Após semanas de negociação, líderes mundiais concordam em metas mais rígidas para a redução de gases de efeito estufa até 2035.',
      imageUrl: 'https://placehold.co/600x800/1E40AF/FFFFFF?text=Cimeira+Clima',
      fetchedAt: DateTime.now(),
      tags: ['clima', 'sustentabilidade', 'política'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Article(
      id: '3',
      title: 'Mercado de Ações Reage a Novos Dados da Inflação',
      url: '',
      source: Source(name: 'Finance Today'),
      author: 'Beatriz Costa',
      publishedAt: DateTime(2025, 9, 5, 9, 15),
      category: 'Economia',
      content: '...',
      description:
          'Investidores mostram-se cautelosos após a divulgação de números da inflação acima do esperado, com setores de tecnologia e bens de consumo a sentir o maior impacto.',
      imageUrl: 'https://placehold.co/600x800/B91C1C/FFFFFF?text=Mercado+Ações',
      fetchedAt: DateTime.now(),
      tags: ['economia', 'inflação', 'mercado financeiro'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Article(
      id: '4',
      title: 'Exploração Espacial: Nova Sonda Chega a Júpiter',
      url: '',
      source: Source(name: 'Science Weekly'),
      author: 'Carlos Ferreira',
      publishedAt: DateTime(2025, 9, 3, 22, 0),
      category: 'Ciência',
      content: '...',
      description:
          'A sonda "Juno II" entrou com sucesso na órbita de Júpiter e começa a enviar as primeiras imagens de alta resolução das suas tempestades.',
      imageUrl: 'https://placehold.co/600x800/4A044E/FFFFFF?text=Sonda+Júpiter',
      fetchedAt: DateTime.now(),
      tags: ['espaço', 'ciência', 'astronomia'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Article(
      id: '5',
      title: 'Final do Campeonato de Futebol Surpreende com Reviravolta',
      url: '',
      source: Source(name: 'Sports Central'),
      author: 'Miguel Sousa',
      publishedAt: DateTime(2025, 9, 4, 23, 45),
      category: 'Desporto',
      content: '...',
      description:
          'Uma reviravolta nos últimos minutos de jogo garantiu a vitória inesperada à equipa visitante, para desespero dos adeptos da casa.',
      imageUrl: 'https://placehold.co/600x800/047857/FFFFFF?text=Final+Futebol',
      fetchedAt: DateTime.now(),
      tags: ['futebol', 'desporto', 'campeonato'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomSliverHeaderDelegate(
              minHeight: 60 + topPadding,
              maxHeight: 320 + topPadding,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _staticArticles.length,
              itemBuilder: (context, index) {
                final article = _staticArticles[index];
                return ArticleStoryItem(article: article);
              },
            ),
          ),
        ],
      ),
    );
  }
}
