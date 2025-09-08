import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Editar Perfil'),
      ),
      child: Center(
        child: Text('Tela de Editar Perfil', style: AppTheme.bodyTextStyle),
      ),
    );
  }
}
