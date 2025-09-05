import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/components/custom_sliver_header.dart';
import 'package:phato_prototype/models/article.dart';
import 'package:phato_prototype/widgets/article_story_item.dart';

class FeedTabPage extends StatefulWidget {
  const FeedTabPage({super.key});

  @override
  State<FeedTabPage> createState() => _FeedTabPageState();
}

class _FeedTabPageState extends State<FeedTabPage> {
  final List<Article> _staticArticles = [
    Article(
      id: '1',
      title: 'Avanços em IA Generativa Transformam a Indústria Criativa',
      url: '',
      source: Source(name: 'Tech Chronicle'),
      author: 'Ana Cordeiro',
      publishedAt: DateTime(2025, 9, 5, 10, 0),
      category: 'Tecnologia',
      content:
          'A rápida evolução dos modelos de inteligência artificial generativa está a causar uma disrupção significativa em múltiplas indústrias...',
      description:
          'Novos modelos de IA estão a criar arte, música e texto com uma qualidade sem precedentes, levantando questões sobre o futuro da criatividade humana.',
      imageUrl: 'assets/noticia1.png',
      fetchedAt: DateTime.now(),
      tags: ['ia', 'tecnologia', 'criatividade'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      analysis: Analysis(
        facts: Facts(
          who: ['Empresas de tecnologia', 'Artistas', 'Reguladores'],
          what:
              'Discussão sobre o impacto da IA Generativa na indústria criativa.',
          when: 'Atualmente',
          where: ['Global'],
        ),
        narratives: [
          Narrative(
              title: 'Perspetiva Otimista',
              summary:
                  'A IA é uma ferramenta que irá potenciar a criatividade humana...',
              emphasis: []),
          Narrative(
              title: 'Perspetiva Cautelosa',
              summary:
                  'A ascensão da IA pode desvalorizar o trabalho de artistas humanos...',
              emphasis: []),
        ],
      ),
    ),
    Article(
      id: '2',
      title: 'Cimeira do Clima Termina com Acordo Histórico sobre Emissões',
      url: '',
      source: Source(name: 'Global News'),
      author: 'Rui Martins',
      publishedAt: DateTime(2025, 9, 4, 18, 30),
      category: 'Meio Amb.',
      content:
          'Após semanas de negociações intensas, a cimeira climática global concluiu com um acordo considerado histórico...',
      description:
          'Líderes mundiais concordam em metas mais rígidas para a redução de gases de efeito estufa.',
      imageUrl: 'assets/noticia2.png',
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
      content:
          'Os mercados financeiros globais registaram uma volatilidade acrescida após a divulgação dos últimos dados da inflação...',
      description:
          'Investidores mostram-se cautelosos após a divulgação de números da inflação acima do esperado.',
      imageUrl: 'assets/noticia3.png',
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
      content:
          'A comunidade científica celebra a chegada bem-sucedida da sonda "Juno II" à órbita de Júpiter...',
      description:
          'A sonda "Juno II" entrou com sucesso na órbita de Júpiter e começa a enviar as primeiras imagens.',
      imageUrl: 'assets/noticia4.png',
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
      content:
          'A final do campeonato nacional de futebol foi um verdadeiro espetáculo de emoções, decidido apenas nos últimos momentos...',
      description:
          'Uma reviravolta nos últimos minutos de jogo garantiu a vitória inesperada à equipa visitante.',
      imageUrl: 'assets/noticia5.png',
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
      // A CORREÇÃO PRINCIPAL ESTÁ AQUI: Adicionamos um SafeArea.
      // O SafeArea garante que o conteúdo não fique por baixo das barras do sistema
      // (como a barra de navegação inferior ou o "notch" do iPhone).
      // Desativamos o SafeArea para o topo (top: false) porque o nosso
      // cabeçalho personalizado (CustomSliverHeaderDelegate) já trata do espaçamento
      // da barra de status.
      child: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverHeaderDelegate(
                minHeight: 60 + topPadding,
                maxHeight: 370 + topPadding,
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
      ),
    );
  }
}
