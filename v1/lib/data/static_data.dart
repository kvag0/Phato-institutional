import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/models/article.dart';
import 'package:phato_prototype/models/highlight_moment.dart';
import 'package:phato_prototype/models/highlight_timeline.dart';
import 'package:phato_prototype/models/topic.dart';
import 'package:phato_prototype/models/usuario.dart';

// (NOVO) Adiciona as definições das classes que estavam em falta.

/// Representa um "emblema" ou conquista que o utilizador pode ganhar.
class Achievement {
  final String name;
  final IconData icon;
  final Color color;
  const Achievement(
      {required this.name, required this.icon, required this.color});
}

/// Representa um item na lista de atividades recentes do utilizador.
class ActivityItem {
  final String title;
  final IconData icon;
  final String timestamp;
  const ActivityItem(
      {required this.title, required this.icon, required this.timestamp});
}

/// Um modelo de dados combinado para exibir estatísticas de tópicos no perfil.
class TopicData {
  final String name;
  final String chave;
  final IconData icon;
  final int count;
  const TopicData(
      {required this.name,
      required this.chave,
      required this.icon,
      required this.count});
}

// --- DADOS ESTÁTICOS ---

final Usuario staticUser = Usuario(
  id: 'user_123',
  nome: 'Caio Sobrinho',
  email: 'caio@phato.app',
  imageUrl: 'assets/user_avatar.png',
  subscription: 'Pro',
  level: 12,
  xp: 340,
  nextLevelXp: 500,
  stats: {
    'articlesRead': 82,
    'biasVotes': 45,
    'sourcesViewed': 30,
  },
  topicReadCounts: {
    'clima': 15,
    'quantico': 25,
    'imobiliario': 10,
    'sns': 32,
  },
);

final List<Topic> allTopics = [
  Topic(nome: 'Crise Climática', chave: 'clima', icon: CupertinoIcons.flame),
  Topic(
      nome: 'Avanços Quânticos',
      chave: 'quantico',
      icon: CupertinoIcons.tuningfork),
  Topic(
      nome: 'Bolha Imobiliária',
      chave: 'imobiliario',
      icon: CupertinoIcons.house),
  Topic(nome: 'Reforma do SNS', chave: 'sns', icon: CupertinoIcons.heart),
];

const List<Achievement> staticAchievements = [
  Achievement(
      name: 'Leitor Bronze',
      icon: CupertinoIcons.rosette,
      color: Color(0xffcd7f32)),
  Achievement(
      name: 'Leitor Prata',
      icon: CupertinoIcons.rosette,
      color: Color(0xffc0c0c0)),
  Achievement(
      name: 'Leitor Ouro',
      icon: CupertinoIcons.rosette,
      color: Color(0xffffd700)),
  Achievement(
      name: 'Curioso',
      icon: CupertinoIcons.search,
      color: CupertinoColors.systemBlue),
  Achievement(
      name: 'Político',
      icon: CupertinoIcons.person_3,
      color: CupertinoColors.systemRed),
  Achievement(
      name: 'Cientista',
      icon: CupertinoIcons.lab_flask,
      color: CupertinoColors.systemGreen),
];

const List<ActivityItem> staticActivities = [
  ActivityItem(
      title: 'Você ganhou o emblema "Leitor Ouro"',
      icon: CupertinoIcons.rosette,
      timestamp: 'Hoje'),
  ActivityItem(
      title: 'Você leu 10 artigos sobre "SNS"',
      icon: CupertinoIcons.heart,
      timestamp: 'Ontem'),
  ActivityItem(
      title: 'Você leu o seu primeiro artigo sobre "Clima"',
      icon: CupertinoIcons.flame,
      timestamp: 'Há 3 dias'),
];

/// Lista centralizada de todos os artigos para o protótipo.
final List<Article> allArticles = [
  Article(
    id: '1',
    title: 'Cimeira do Clima: Nações Chegam a Acordo Histórico',
    url: '',
    source: Source(name: 'Observador'),
    author: 'Ana Garcia',
    publishedAt: DateTime(2025, 9, 5),
    category: 'Mundo',
    content:
        'Após semanas de negociações intensas, líderes de 190 países chegaram a um acordo histórico na Cimeira do Clima. O pacto visa limitar o aquecimento global a 1.5°C, com compromissos ambiciosos para a redução de emissões e o investimento em energias renováveis. Ativistas celebram o acordo como um "passo gigante para a humanidade", mas alertam que a implementação será o verdadeiro desafio.',
    description:
        'Acordo histórico na Cimeira do Clima visa limitar aquecimento global com metas ambiciosas de redução de emissões.',
    imageUrl: 'assets/noticia1.png',
    tags: ['clima', 'acordo', 'sustentabilidade'],
    language: 'pt',
    fetchedAt: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    analysis: Analysis(
      facts: Facts(
        who: ['Líderes de 190 países', 'Ativistas'],
        what: 'Acordo climático para limitar o aquecimento global a 1.5°C.',
        when: '2025-09-05',
        where: ['Cimeira do Clima'],
        summary:
            'Líderes mundiais assinaram um acordo para combater as alterações climáticas, focando na redução de emissões e energias renováveis.',
      ),
      narratives: [
        Narrative(
          title: 'Perspetiva Otimista',
          summary:
              'O acordo é visto como um momento de viragem e uma vitória da diplomacia global, demonstrando que a cooperação internacional é possível para resolver os maiores desafios do planeta.',
          emphasis: [],
        ),
        Narrative(
          title: 'Perspetiva Cética',
          summary:
              'Críticos apontam que acordos semelhantes falharam no passado por falta de mecanismos de fiscalização e que os compromissos podem não ser suficientes para evitar as piores consequências das alterações climáticas.',
          emphasis: [],
        ),
      ],
    ),
  ),
  Article(
    id: '2',
    title: 'Portugal Lidera Inovação em Tecnologia Quântica na Europa',
    url: '',
    source: Source(name: 'Público'),
    author: 'Rui Martins',
    publishedAt: DateTime(2025, 9, 4),
    category: 'Tecnologia',
    content:
        'Um novo centro de investigação em computação quântica, sediado em Lisboa, posiciona Portugal na vanguarda da tecnologia europeia. O projeto, financiado por fundos comunitários e privados, atraiu talentos de todo o mundo e promete acelerar o desenvolvimento de processadores quânticos, com aplicações potenciais em medicina, finanças e inteligência artificial. O governo destaca o investimento como um pilar estratégico para a economia digital do país.',
    description:
        'Novo centro de investigação em Lisboa coloca Portugal na vanguarda da computação quântica europeia.',
    imageUrl: 'assets/noticia2.png',
    tags: ['tecnologia', 'quântica', 'inovação'],
    language: 'pt',
    fetchedAt: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Article(
    id: '3',
    title: 'Mercado Imobiliário Desacelera em Grandes Cidades',
    url: '',
    source: Source(name: 'Jornal de Negócios'),
    author: 'Sofia Almeida',
    publishedAt: DateTime(2025, 9, 3),
    category: 'Economia',
    content:
        'Os preços das casas nas principais áreas metropolitanas de Portugal mostraram sinais de desaceleração no último trimestre. Segundo dados do Instituto Nacional de Estatística, o aumento homólogo foi o mais baixo dos últimos três anos. Especialistas apontam a subida das taxas de juro e a diminuição do poder de compra como os principais fatores para esta tendência, prevendo uma estabilização do mercado nos próximos meses.',
    description:
        'Preços das casas nas grandes cidades portuguesas mostram o menor aumento homólogo dos últimos três anos, indicando estabilização do mercado.',
    imageUrl: 'assets/noticia3.png',
    tags: ['imobiliário', 'economia', 'juros'],
    language: 'pt',
    fetchedAt: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Article(
    id: '4',
    title: 'Reforma do Sistema de Saúde Aprovada em Votação Final',
    url: '',
    source: Source(name: 'Diário de Notícias'),
    author: 'Carlos Pereira',
    publishedAt: DateTime(2025, 9, 2),
    category: 'Política',
    content:
        'O parlamento aprovou a proposta de lei para a reforma do Serviço Nacional de Saúde (SNS). As principais alterações incluem a centralização da gestão de hospitais, a criação de unidades de saúde familiares com maior autonomia e um reforço do investimento na saúde mental. O governo defende que a reforma irá modernizar o SNS, enquanto a oposição critica a medida como um passo para a privatização.',
    description:
        'Parlamento aprova reforma do SNS com foco na centralização da gestão hospitalar e reforço da saúde mental, gerando debate político.',
    imageUrl: 'assets/noticia4.png',
    tags: ['saúde', 'política', 'sns'],
    language: 'pt',
    fetchedAt: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Article(
    id: '5',
    title: 'Descoberta de Nova Espécie Marinha na Costa dos Açores',
    url: '',
    source: Source(name: 'National Geographic'),
    author: 'Mariana Costa',
    publishedAt: DateTime(2025, 9, 1),
    category: 'Meio Amb.',
    content:
        'Uma equipa de biólogos marinhos da Universidade dos Açores anunciou a descoberta de uma nova espécie de peixe-lanterna a mais de 800 metros de profundidade. A espécie, batizada de "Luminosphaera azorica", possui órgãos bioluminescentes únicos, que os cientistas acreditam serem usados para comunicação em águas profundas. A descoberta reforça a importância da região como um hotspot de biodiversidade marinha a ser preservado.',
    description:
        'Cientistas descobrem nova espécie de peixe bioluminescente nas águas profundas dos Açores, destacando a biodiversidade local.',
    imageUrl: 'assets/noticia5.png',
    tags: ['ciência', 'mar', 'biodiversidade'],
    language: 'pt',
    fetchedAt: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

/// Lista centralizada de todas as linhas do tempo dos destaques para o protótipo.
final List<HighlightTimeline> allHighlightTimelines = [
  const HighlightTimeline(
    title: 'Crise Climática',
    coverImageUrl:
        '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/highlights/meio-ambiente.png',
    moments: [
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/clima_1.png',
        title: 'Acordo de Paris',
        description:
            'Em 2015, o mundo uniu-se para estabelecer a meta de limitar o aquecimento global, um marco na diplomacia climática.',
      ),
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/clima_2.png',
        title: 'Relatório Chocante do IPCC',
        description:
            'O mais recente relatório do Painel Intergovernamental sobre Mudanças Climáticas alertou para consequências "irreversíveis" se não houver ação imediata.',
      ),
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/clima_3.png',
        title: 'A Cimeira Decisiva',
        description:
            'Líderes mundiais reúnem-se para solidificar compromissos e transformar metas em ações concretas. O futuro do planeta está em jogo.',
        articleId: '1', // LIGAÇÃO AO ARTIGO COMPLETO
      ),
    ],
  ),
  const HighlightTimeline(
    title: 'Avanços Quânticos',
    coverImageUrl:
        '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/highlights/tecnologia.png',
    moments: [
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/quantico_1.png',
        title: 'O Início da Corrida',
        description:
            'As primeiras experiências provaram que a computação quântica era teoricamente possível, dando início a uma nova corrida tecnológica global.',
      ),
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/quantico_2.png',
        title: 'Supremacia Quântica',
        description:
            'Gigantes da tecnologia anunciaram ter atingido a "supremacia quântica", com computadores a resolver problemas impossíveis para máquinas clássicas.',
      ),
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/quantico_3.png',
        title: 'O Polo Europeu',
        description:
            'Com um novo centro de investigação de ponta, Portugal emerge como um líder inesperado na inovação quântica europeia.',
        articleId: '2', // LIGAÇÃO AO ARTIGO COMPLETO
      ),
    ],
  ),
  const HighlightTimeline(
    title: 'Bolha Imobiliária?',
    coverImageUrl:
        '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/highlights/economia.png',
    moments: [
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/imobiliario_1.png',
        title: 'A Escalada de Preços',
        description:
            'Nos últimos anos, a procura crescente e a falta de oferta levaram a uma subida vertiginosa dos preços das casas nas grandes cidades.',
      ),
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/imobiliario_2.png',
        title: 'O Impacto dos Juros',
        description:
            'Em resposta à inflação, os bancos centrais subiram as taxas de juro, tornando o crédito à habitação significativamente mais caro.',
      ),
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/imobiliario_3.png',
        title: 'Sinais de Arrefecimento',
        description:
            'Pela primeira vez em três anos, o crescimento dos preços abrandou, levantando a questão: será o fim da bolha ou apenas uma pausa?',
        articleId: '3',
      ),
    ],
  ),
  const HighlightTimeline(
    title: 'Reforma do SNS',
    coverImageUrl:
        '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/highlights/politica.png',
    moments: [
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/sns_1.png',
        title: 'O Ponto de Partida',
        description:
            'O Serviço Nacional de Saúde, outrora um modelo, enfrentava desafios de sustentabilidade, listas de espera e falta de profissionais.',
      ),
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/sns_2.png',
        title: 'O Debate no Parlamento',
        description:
            'A proposta de reforma gerou um dos debates mais acesos da legislatura, opondo visões sobre o futuro da saúde pública em Portugal.',
      ),
      HighlightMoment(
        imageUrl:
            '/Users/caiosobrinho/Downloads/Phato-institutional/v1/assets/timelines/sns_3.png',
        title: 'A Votação Final',
        description:
            'Com a aprovação final da lei, inicia-se um novo capítulo para o SNS, com promessas de modernização e críticas sobre o seu rumo.',
        articleId: '4',
      ),
    ],
  ),
];
