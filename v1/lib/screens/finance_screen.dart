import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Finanças', style: AppTheme.headlineStyle),
        backgroundColor: AppTheme.phatoBlack,
        border: null,
      ),
      child: const Center(
        child: Text('Página de Finanças em construção.'),
      ),
    );
  }
}
