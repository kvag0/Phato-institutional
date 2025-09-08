import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import 'edit_profile_screen.dart';
import 'subscription_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _breakingNewsEnabled = true;
  bool _dailySummaryEnabled = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.phatoBlack,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Configurações',
            style: AppTheme.headlineStyle.copyWith(fontSize: 18)),
        backgroundColor: AppTheme.phatoBlack,
        border: null,
      ),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 24),
            _buildSectionHeader('Notificações'),
            _buildSettingsGroup([
              _buildSwitchTile(
                  'Ativar Notificações',
                  'Receber todas as notificações push',
                  _notificationsEnabled, (value) {
                setState(() {
                  _notificationsEnabled = value;
                  if (!value) {
                    _breakingNewsEnabled = false;
                    _dailySummaryEnabled = false;
                  }
                });
              }),
              _buildSwitchTile(
                  'Notícias de Última Hora',
                  'Alertas para eventos importantes',
                  _breakingNewsEnabled,
                  _notificationsEnabled
                      ? (value) => setState(() => _breakingNewsEnabled = value)
                      : null),
              _buildSwitchTile(
                  'Resumo Diário',
                  'Um resumo das notícias do dia',
                  _dailySummaryEnabled,
                  _notificationsEnabled
                      ? (value) => setState(() => _dailySummaryEnabled = value)
                      : null),
            ]),
            const SizedBox(height: 32),
            _buildSectionHeader('Conta'),
            _buildSettingsGroup([
              _buildNavigationTile('Editar Perfil', CupertinoIcons.person, () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const EditProfileScreen()));
              }),
              _buildNavigationTile(
                  'Gerir Assinatura', CupertinoIcons.creditcard, () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const SubscriptionScreen()));
              }),
              _buildNavigationTile('Alterar Senha', CupertinoIcons.lock, () {}),
            ]),
            const SizedBox(height: 32),
            _buildSectionHeader('Geral'),
            _buildSettingsGroup([
              _buildNavigationTile(
                  'Convidar Amigos', CupertinoIcons.person_2, () {}),
              _buildNavigationTile(
                  'Termos de Serviço', CupertinoIcons.doc_text, () {}),
              _buildNavigationTile(
                  'Política de Privacidade', CupertinoIcons.shield, () {}),
            ]),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CupertinoButton(
                color: CupertinoColors.systemRed,
                onPressed: () {
                  // Lógica de logout
                },
                // (CORRIGIDO) Adiciona estilo explícito ao texto do botão.
                child: Text('Terminar Sessão',
                    style: AppTheme.bodyTextStyle
                        .copyWith(color: CupertinoColors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: AppTheme.secondaryTextStyle.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppTheme.phatoGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(children.length * 2 - 1, (index) {
          if (index.isEven) {
            return children[index ~/ 2];
          }
          return const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Divider(
              height: 1,
              color: AppTheme.phatoBlack,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSwitchTile(
      String title, String subtitle, bool value, Function(bool)? onChanged) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.bodyTextStyle),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTheme.secondaryTextStyle),
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            activeColor: AppTheme.phatoYellow,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.phatoTextGray),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: AppTheme.bodyTextStyle)),
            const Icon(CupertinoIcons.right_chevron,
                color: AppTheme.phatoTextGray, size: 16),
          ],
        ),
      ),
    );
  }
}
