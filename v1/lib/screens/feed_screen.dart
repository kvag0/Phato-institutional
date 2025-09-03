import 'package:flutter/material.dart';
import '../models/article.dart';
import '../widgets/highlight_card.dart';
import '../widgets/article_card.dart';

// --- INSTRUÇÕES ---
// 1. Crie um novo arquivo chamado `feed_screen.dart` dentro de `lib/screens/`.
// 2. Cole este código no novo arquivo.

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  // --- DADOS ESTÁTICOS (MOCK DATA) ---

  // 4 Destaques para a barra superior
  final List<Article> _highlights = const [
    Article(
      id: 'h1',
      title:
          'Como a nova política de juros pode impactar seus investimentos a longo prazo',
      source: 'Valor Econômico',
      time: 'Agora',
      imageUrl: 'https://placehold.co/600x400/000000/FFFFFF?text=Juros',
      content: 'Conteúdo completo sobre a política de juros...',
    ),
    Article(
      id: 'h2',
      title:
          'Avanços na exploração espacial: O que esperar da missão a Marte em 2027',
      source: 'Space News',
      time: '15 min',
      imageUrl: 'https://placehold.co/600x400/DD2A2A/FFFFFF?text=Marte',
      content: 'Conteúdo completo sobre a missão a Marte...',
    ),
    Article(
      id: 'h3',
      title:
          'Sustentabilidade na moda: Marcas brasileiras que estão fazendo a diferença',
      source: 'Vogue Brasil',
      time: '45 min',
      imageUrl: 'https://placehold.co/600x400/4CAF50/FFFFFF?text=Moda',
      content: 'Conteúdo completo sobre sustentabilidade...',
    ),
    Article(
      id: 'h4',
      title:
          'Criptomoedas: Volatilidade do mercado acende alerta entre investidores',
      source: 'InfoMoney',
      time: '1 h',
      imageUrl: 'https://placehold.co/600x400/FFC107/000000?text=Cripto',
      content: 'Conteúdo completo sobre criptomoedas...',
    ),
  ];

  // 3 Notícias para o feed principal
  final List<Article> _articles = const [
    Article(
      id: 'a1',
      title:
          'Reforma Tributária: Entenda o que muda para o seu bolso a partir de 2026',
      source: 'G1 Política',
      time: '2 h',
      imageUrl: 'https://placehold.co/400x400/3F51B5/FFFFFF?text=Reforma',
      content:
          'A reforma tributária, promulgada pelo Congresso Nacional, promete simplificar o sistema de impostos do Brasil com a criação do Imposto sobre Valor Agregado (IVA). A transição começará em 2026 e deve durar até 2033. Especialistas debatem os impactos na cesta básica e nos preços dos serviços...',
    ),
    Article(
      id: 'a2',
      title:
          'Crise Hídrica no Sudeste: Reservatórios atingem níveis críticos e especialistas alertam para risco de racionamento',
      source: 'Folha de S.Paulo',
      time: '3 h',
      imageUrl: 'https://placehold.co/400x400/03A9F4/FFFFFF?text=Água',
      content:
          'Com a falta de chuvas e o aumento do consumo, os principais reservatórios do sistema Cantareira, que abastece a Grande São Paulo, operam com menos de 30% da capacidade. O governo estadual ainda não confirmou, mas um plano de contingência já está sendo preparado...',
    ),
    Article(
      id: 'a3',
      title:
          'Inteligência Artificial no Brasil: Novo marco legal busca equilibrar inovação e ética',
      source: 'Agência Brasil',
      time: '5 h',
      imageUrl: 'https://placehold.co/400x400/9C27B0/FFFFFF?text=IA',
      content:
          'Um novo projeto de lei para regulamentar o uso de Inteligência Artificial está em tramitação avançada. O texto visa criar diretrizes para o desenvolvimento e uso de sistemas de IA, focando em transparência, responsabilidade e proteção de dados, sem frear a inovação tecnológica no país...',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Cabeçalho com saudação
          SliverAppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            pinned: true,
            expandedHeight: 120.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              title: Text(
                'Bom dia, Usuário!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: false,
            ),
          ),
          // Seção de Destaques
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Destaques do Dia',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: _highlights.length,
                itemBuilder: (context, index) {
                  return HighlightCard(article: _highlights[index]);
                },
              ),
            ),
          ),
          // Seção "Para Você"
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Text(
                'Para Você',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Lista de Notícias
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ArticleCard(article: _articles[index]);
            }, childCount: _articles.length),
          ),
        ],
      ),
    );
  }
}
