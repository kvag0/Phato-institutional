import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phato_prototype/models/highlight_moment.dart';
import '../models/highlight_timeline.dart';
import '../core/theme/app_theme.dart';
import '../data/static_data.dart';
import 'article_detail_screen.dart';

class HighlightStoryScreen extends StatefulWidget {
  final HighlightTimeline timeline;

  const HighlightStoryScreen({super.key, required this.timeline});

  @override
  State<HighlightStoryScreen> createState() => _HighlightStoryScreenState();
}

class _HighlightStoryScreenState extends State<HighlightStoryScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    _loadStory(animate: false);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.timeline.moments.length) {
            _currentIndex += 1;
            _loadStory();
          } else {
            Navigator.of(context).pop();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _loadStory({bool animate = true}) {
    _animController.stop();
    _animController.reset();
    _animController.duration = const Duration(seconds: 5);
    _animController.forward();

    if (animate) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 10),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentMoment = widget.timeline.moments[_currentIndex];
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.phatoBlack,
      child: GestureDetector(
        onTapDown: (details) => _onTapDown(details, currentMoment),
        child: Stack(
          children: [
            // Conteúdo da Página
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.timeline.moments.length,
              itemBuilder: (context, i) {
                final moment = widget.timeline.moments[i];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // Imagem de Fundo
                    Image.asset(moment.imageUrl, fit: BoxFit.cover),
                    // Gradiente para legibilidade
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.phatoBlack.withOpacity(0.0),
                            AppTheme.phatoBlack.withOpacity(0.8)
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    // Conteúdo de Texto
                    Positioned(
                      bottom: 80,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            moment.title,
                            style: AppTheme.headlineStyle.copyWith(
                                color: AppTheme.phatoLightGray, fontSize: 28),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            moment.description,
                            style: AppTheme.bodyTextStyle
                                .copyWith(color: AppTheme.phatoLightGray),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            // Barras de Progresso e Cabeçalho
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Row(
                    children: widget.timeline.moments
                        .asMap()
                        .map((i, e) {
                          return MapEntry(
                            i,
                            _AnimatedBar(
                              animController: _animController,
                              position: i,
                              currentIndex: _currentIndex,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.timeline.title,
                        style: AppTheme.secondaryTextStyle
                            .copyWith(color: AppTheme.phatoLightGray),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Icon(CupertinoIcons.clear,
                            color: AppTheme.phatoLightGray),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Botão "Ver Artigo" (se aplicável)
            if (currentMoment.articleId != null)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: CupertinoButton(
                  color: AppTheme.phatoYellow,
                  onPressed: () {
                    final article = allArticles.firstWhere(
                        (a) => a.id == currentMoment.articleId,
                        orElse: () => allArticles.first);
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) =>
                            ArticleDetailScreen(article: article),
                      ),
                    );
                  },
                  child: Text(
                    'VER ARTIGO COMPLETO',
                    style: AppTheme.bodyTextStyle
                        .copyWith(color: AppTheme.phatoBlack),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, HighlightMoment moment) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    // Se tocar no terço esquerdo, volta atrás
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory();
        }
      });
    }
    // Se tocar no terço direito, avança
    else if (dx > screenWidth * 2 / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.timeline.moments.length) {
          _currentIndex += 1;
          _loadStory();
        } else {
          // Se for o último, fecha
          Navigator.of(context).pop();
        }
      });
    }
  }
}

// Widget auxiliar para a barra de progresso animada
class _AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const _AnimatedBar({
    required this.animController,
    required this.position,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? AppTheme.phatoLightGray
                      : Colors.grey.withOpacity(0.5),
                ),
                if (position == currentIndex)
                  AnimatedBuilder(
                    animation: animController,
                    builder: (context, child) {
                      return _buildContainer(
                        constraints.maxWidth * animController.value,
                        AppTheme.phatoLightGray,
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 3.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black26, width: 0.8),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
