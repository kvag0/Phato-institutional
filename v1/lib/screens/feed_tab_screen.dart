import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/components/custom_sliver_header.dart';
import 'package:phato_prototype/models/article.dart'; // IMPORT ADICIONADO
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
      content:
          'A rápida evolução dos modelos de inteligência artificial generativa está a causar uma disrupção significativa em múltiplas indústrias. Desde a criação de imagens fotorrealistas a partir de simples descrições de texto, até à composição de peças musicais complexas e à escrita de guiões, a tecnologia está a redefinir os limites da criatividade digital. Empresas de software, agências de publicidade e estúdios de cinema já começaram a integrar estas ferramentas nos seus fluxos de trabalho, resultando num aumento de eficiência e em novas formas de expressão artística. No entanto, este avanço rápido também levanta debates importantes sobre direitos de autor, a ética da criação de conteúdo sintético e o potencial impacto no mercado de trabalho para artistas e criadores humanos. Especialistas apelam a uma regulamentação cuidada para garantir que a tecnologia seja usada de forma responsável, maximizando os seus benefícios enquanto se mitigam os riscos associados.',
      description:
          'Novos modelos de IA estão a criar arte, música e texto com uma qualidade sem precedentes, levantando questões sobre o futuro da criatividade humana.',
      imageUrl: 'https://placehold.co/600x800/0d0d0d/FFFFFF?text=IA+Generativa',
      fetchedAt: DateTime.now(),
      tags: ['ia', 'tecnologia', 'criatividade'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      analysis: Analysis(
        // CORREÇÃO: 'new' implícito
        facts: Facts(
          // CORREÇÃO: 'new' implícito
          who: ['Empresas de tecnologia', 'Artistas', 'Reguladores'],
          what:
              'Discussão sobre o impacto da IA Generativa na indústria criativa.',
          when: 'Atualmente',
          where: ['Global'],
        ),
        narratives: [
          Narrative(
              // CORREÇÃO: 'new' implícito
              title: 'Perspetiva Otimista',
              summary:
                  'A IA é uma ferramenta que irá potenciar a criatividade humana, permitindo a exploração de novas formas de arte e acelerando a produção.',
              emphasis: []),
          Narrative(
              // CORREÇÃO: 'new' implícito
              title: 'Perspetiva Cautelosa',
              summary:
                  'A ascensão da IA pode desvalorizar o trabalho de artistas humanos, criar desafios legais sobre propriedade intelectual e facilitar a criação de desinformação.',
              emphasis: []),
        ],
      ),
    ),
    Article(
      // CORREÇÃO: 'analysis' removido pois é opcional
      id: '2',
      title: 'Cimeira do Clima Termina com Acordo Histórico sobre Emissões',
      url: '',
      source: Source(name: 'Global News'),
      author: 'Rui Martins',
      publishedAt: DateTime(2025, 9, 4, 18, 30),
      category: 'Meio Amb.',
      content:
          'Após semanas de negociações intensas, a cimeira climática global concluiu com um acordo considerado histórico por muitos líderes mundiais. O pacto estabelece metas mais ambiciosas para a redução de emissões de gases de efeito estufa, com o objetivo de limitar o aquecimento global a 1.5°C. As nações mais desenvolvidas comprometeram-se a fornecer maior apoio financeiro aos países em desenvolvimento para a transição energética e adaptação climática. No entanto, ativistas ambientais expressam um otimismo cauteloso, apontando que o sucesso do acordo dependerá da implementação rigorosa e transparente das políticas a nível nacional. Os próximos anos serão cruciais para determinar se as promessas se traduzirão em ações concretas.',
      description:
          'Após semanas de negociação, líderes mundiais concordam em metas mais rígidas para a redução de gases de efeito estufa até 2035.',
      imageUrl: 'https://placehold.co/600x800/1E40AF/FFFFFF?text=Cimeira+Clima',
      fetchedAt: DateTime.now(),
      tags: ['clima', 'sustentabilidade', 'política'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Article(
      // CORREÇÃO: 'analysis' removido pois é opcional
      id: '3',
      title: 'Mercado de Ações Reage a Novos Dados da Inflação',
      url: '',
      source: Source(name: 'Finance Today'),
      author: 'Beatriz Costa',
      publishedAt: DateTime(2025, 9, 5, 9, 15),
      category: 'Economia',
      content:
          'Os mercados financeiros globais registaram uma volatilidade acrescida após a divulgação dos últimos dados da inflação, que superaram as expectativas dos analistas. Os números indicam uma pressão contínua sobre os preços, levando a especulações sobre possíveis novas subidas das taxas de juro pelos bancos centrais. Os setores mais sensíveis a custos de financiamento, como tecnologia e imobiliário, foram os que mais sofreram. Analistas financeiros estão divididos: alguns acreditam que é um pico temporário, enquanto outros temem o início de um período de estagflação. A incerteza deverá dominar o sentimento dos investidores nas próximas semanas.',
      description:
          'Investidores mostram-se cautelosos após a divulgação de números da inflação acima do esperado, com setores de tecnologia e bens de consumo a sentir o maior impacto.',
      imageUrl: 'https://placehold.co/600x800/B91C1C/FFFFFF?text=Mercado+Ações',
      fetchedAt: DateTime.now(),
      tags: ['economia', 'inflação', 'mercado financeiro'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Article(
      // CORREÇÃO: 'analysis' removido pois é opcional
      id: '4',
      title: 'Exploração Espacial: Nova Sonda Chega a Júpiter',
      url: '',
      source: Source(name: 'Science Weekly'),
      author: 'Carlos Ferreira',
      publishedAt: DateTime(2025, 9, 3, 22, 0),
      category: 'Ciência',
      content:
          'A comunidade científica celebra a chegada bem-sucedida da sonda "Juno II" à órbita de Júpiter. A missão, que demorou cinco anos a chegar ao seu destino, tem como objetivo principal estudar a composição da atmosfera do gigante gasoso, o seu campo magnético e as suas auroras polares. As primeiras imagens e dados já começaram a chegar ao centro de controlo da missão, prometendo revelar novos segredos sobre a formação do nosso sistema solar. A "Juno II" está equipada com instrumentos de última geração que permitirão uma análise muito mais detalhada do que qualquer missão anterior. Os cientistas estão particularmente entusiasmados com a possibilidade de entender melhor a misteriosa Grande Mancha Vermelha.',
      description:
          'A sonda "Juno II" entrou com sucesso na órbita de Júpiter e começa a enviar as primeiras imagens de alta resolução das suas tempestades.',
      imageUrl: 'https://placehold.co/600x800/4A044E/FFFFFF?text=Sonda+Júpiter',
      fetchedAt: DateTime.now(),
      tags: ['espaço', 'ciência', 'astronomia'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Article(
      // CORREÇÃO: 'analysis' removido pois é opcional
      id: '5',
      title: 'Final do Campeonato de Futebol Surpreende com Reviravolta',
      url: '',
      source: Source(name: 'Sports Central'),
      author: 'Miguel Sousa',
      publishedAt: DateTime(2025, 9, 4, 23, 45),
      category: 'Desporto',
      content:
          'A final do campeonato nacional de futebol foi um verdadeiro espetáculo de emoções, decidido apenas nos últimos momentos da partida. A equipa da casa, que esteve a vencer por dois golos de diferença durante a maior parte do jogo, sofreu uma reviravolta impressionante no tempo de compensação. Com dois golos marcados nos minutos 92 e 95, a equipa visitante conseguiu virar o resultado e sagrar-se campeã, para choque e desilusão dos milhares de adeptos presentes no estádio. O treinador vencedor descreveu o feito como "um milagre" e elogiou a "fé inabalável" dos seus jogadores, que nunca deixaram de acreditar.',
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
