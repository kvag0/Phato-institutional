import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Buscar', style: AppTheme.headlineStyle),
        backgroundColor: AppTheme.phatoBlack,
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Campo de Busca
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoSearchTextField(
                controller: _searchController,
                style: AppTheme.bodyTextStyle,
              ),
            ),
            // Área de Resultados
            const Expanded(
              child: Center(
                child: Text('A busca está desativada no protótipo.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
