import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/screens/phatobot_screen.dart';
import 'dart:async';
import 'package:phato_prototype/widgets/chat_bubble.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/screens/home_screen.dart';

enum RegistrationStep {
  awaitingName,
  awaitingAge,
  awaitingEmailChoice,
  awaitingEmailInput,
  awaitingPassword,
  awaitingPasswordConfirmation,
  creatingAccount,
}

class RegistrationChatScreen extends StatefulWidget {
  const RegistrationChatScreen({super.key});

  @override
  State<RegistrationChatScreen> createState() => _RegistrationChatScreenState();
}

class _RegistrationChatScreenState extends State<RegistrationChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  RegistrationStep _currentStep = RegistrationStep.awaitingName;
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    if (_messages.isEmpty) {
      _addBotMessage('Olá! Bem-vindo(a) ao Phato. Vamos criar a tua conta.',
          delay: 500);
      _askForName(delay: 3500);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSendMessage({String? preDefinedText}) async {
    final text = preDefinedText ?? _messageController.text.trim();
    if (text.isEmpty || _currentStep == RegistrationStep.creatingAccount)
      return;

    if (preDefinedText == null) {
      _messageController.clear();
    }

    final messageContent = Text(
      _currentStep == RegistrationStep.awaitingPassword ||
              _currentStep == RegistrationStep.awaitingPasswordConfirmation
          ? '••••••••'
          : text,
      style: AppTheme.bodyTextStyle,
    );

    setState(() {
      _messages.add(
          ChatMessage(content: messageContent, sender: MessageSender.user));
    });
    _scrollToBottom();

    // Lógica do fluxo de registro
    switch (_currentStep) {
      case RegistrationStep.awaitingName:
        _currentStep = RegistrationStep.awaitingAge;
        _askForAge();
        break;
      case RegistrationStep.awaitingAge:
        _currentStep = RegistrationStep.awaitingEmailChoice;
        _askForEmail();
        break;
      case RegistrationStep.awaitingEmailChoice:
        _addBotMessage("Por favor, escolha uma das opções acima.");
        break;
      case RegistrationStep.awaitingEmailInput:
        _currentStep = RegistrationStep.awaitingPassword;
        _askForPassword();
        break;
      case RegistrationStep.awaitingPassword:
        _currentStep = RegistrationStep.awaitingPasswordConfirmation;
        _askForPasswordConfirmation();
        break;
      case RegistrationStep.awaitingPasswordConfirmation:
        _currentStep = RegistrationStep.creatingAccount;
        _addBotMessage('Perfeito! A finalizar o seu registo...');
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          }
        });
        break;
      case RegistrationStep.creatingAccount:
        break;
    }
  }

  void _addBotMessage(String text, {int delay = 1200, Widget? child}) {
    Future.delayed(Duration(milliseconds: delay), () {
      if (!mounted) return;
      setState(() {
        final content = child ??
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  text,
                  textStyle: GoogleFonts.quicksand(
                      fontSize: 15, color: AppTheme.phatoBlack),
                  speed: const Duration(milliseconds: 35),
                ),
              ],
              isRepeatingAnimation: false,
              totalRepeatCount: 1,
            );
        _messages.add(ChatMessage(content: content, sender: MessageSender.bot));
      });
      _scrollToBottom();
    });
  }

  void _onSelectEmailOption() {
    _handleSendMessage(preDefinedText: "Quero usar o meu email");
    _addBotMessage("Sem problemas. Por favor, digite o teu email abaixo.");
    setState(() {
      _currentStep = RegistrationStep.awaitingEmailInput;
    });
  }

  void _askForName({int delay = 1200}) =>
      _addBotMessage('Qual é o teu nome?', delay: delay);
  void _askForAge() => _addBotMessage('E qual é a tua idade?');
  void _askForEmail() => _addBotMessage('',
      child: _SocialLoginOptions(onSelectEmail: _onSelectEmailOption));
  void _askForPassword() {
    _addBotMessage(
        'Obrigado! Para proteger a tua conta, crie uma senha segura.');
  }

  void _askForPasswordConfirmation() =>
      _addBotMessage('Digite a senha novamente, só para confirmar.');

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Criação de Conta'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageRow(message);
                },
              ),
            ),
            Container(height: 1, color: AppTheme.phatoGray.withOpacity(0.2)),
            _buildMessageInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageRow(ChatMessage message) {
    final isUser = message.sender == MessageSender.user;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: ChatBubble(
              sender: message.sender,
              child: message.content,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    bool isEnabled = _currentStep != RegistrationStep.creatingAccount &&
        _currentStep != RegistrationStep.awaitingEmailChoice;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: AppTheme.phatoBlack,
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: _messageController,
              enabled: isEnabled,
              placeholder: 'Digite sua mensagem...',
              style: AppTheme.bodyTextStyle,
              onSubmitted: isEnabled ? (_) => _handleSendMessage() : null,
            ),
          ),
          const SizedBox(width: 8.0),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: isEnabled ? _handleSendMessage : null,
            child: Icon(
              CupertinoIcons.arrow_up_circle_fill,
              size: 32,
              color: isEnabled ? AppTheme.phatoYellow : AppTheme.phatoGray,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialLoginOptions extends StatelessWidget {
  final VoidCallback onSelectEmail;

  const _SocialLoginOptions({required this.onSelectEmail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Para o email, pode digitá-lo ou usar uma das opções de acesso rápido:',
          style:
              GoogleFonts.quicksand(fontSize: 15, color: AppTheme.phatoBlack),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            color: AppTheme.phatoLightGray,
            onPressed: onSelectEmail, // Mock
            child: Text('Continuar com Google',
                style: AppTheme.bodyTextStyle
                    .copyWith(color: AppTheme.phatoBlack)),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            color: AppTheme.phatoLightGray,
            onPressed: onSelectEmail, // Mock
            child: Text('Continuar com Apple',
                style: AppTheme.bodyTextStyle
                    .copyWith(color: AppTheme.phatoBlack)),
          ),
        ),
        const SizedBox(height: 12),
        CupertinoButton(
          onPressed: onSelectEmail,
          child: Text(
            'Prefiro usar o meu email',
            style: AppTheme.bodyTextStyle.copyWith(
              color: AppTheme.phatoBlack,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
