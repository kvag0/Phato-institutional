import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // (CORRIGIDO) Adiciona estilo explícito para evitar conflitos de tema.
        middle: Text('Assinatura',
            style: AppTheme.headlineStyle.copyWith(fontSize: 18)),
      ),
      child: Center(
        child: Text('Tela de Assinatura', style: AppTheme.bodyTextStyle),
      ),
    );
  }
}
