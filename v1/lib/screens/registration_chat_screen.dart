import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/widgets/chat_bubble.dart';

// ENUM para gerir os passos do registo
enum RegistrationStep {
  awaitingName,
  awaitingEmailChoice,
  awaitingEmailInput,
  awaitingPassword,
  awaitingPasswordConfirmation,
  creatingAccount,
}

class ChatMessage {
  final Widget content;
  final MessageSender sender;
  ChatMessage({required this.content, required this.sender});
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
  final String _email = '';
  String _name = '';
  String _password = '';

  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    if (_messages.isEmpty) {
      _addBotMessage(
          'Olá! Bem-vindo(a) ao Phato. Vamos criar a tua conta num instante.',
          delay: 500);
      _askForName(delay: 2500);
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

  // Função para mostrar alertas no estilo Cupertino
  void _showCupertinoAlert(String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _handleSendMessage({String? preDefinedText}) async {
    final text = preDefinedText ?? _messageController.text.trim();
    if (text.isEmpty || _currentStep == RegistrationStep.creatingAccount) {
      return;
    }

    final userInput = text;
    if (preDefinedText == null) {
      _messageController.clear();
    }

    final messageContent = Text(
      _currentStep == RegistrationStep.awaitingPassword ||
              _currentStep == RegistrationStep.awaitingPasswordConfirmation
          ? '*' * userInput.length
          : userInput,
      style: AppTheme.bodyTextStyle.copyWith(color: AppTheme.phatoBlack),
    );

    setState(() {
      _messages.add(
          ChatMessage(content: messageContent, sender: MessageSender.user));
    });
    _scrollToBottom();

    // Lógica de fluxo de conversação
    switch (_currentStep) {
      case RegistrationStep.awaitingName:
        _name = userInput;
        _currentStep = RegistrationStep.awaitingEmailChoice;
        _askForEmail();
        break;
      case RegistrationStep.awaitingEmailChoice:
        _addBotMessage(
            "Por favor, escolha uma das opções acima ou digite o seu email.");
        break;
      case RegistrationStep.awaitingEmailInput:
        _currentStep = RegistrationStep.awaitingPassword;
        _askForPassword();
        break;
      case RegistrationStep.awaitingPassword:
        _password = userInput;
        _currentStep = RegistrationStep.awaitingPasswordConfirmation;
        _askForPasswordConfirmation();
        break;
      case RegistrationStep.awaitingPasswordConfirmation:
        if (userInput != _password) {
          _addBotMessage(
              'As senhas não coincidem. Por favor, digite a sua senha segura novamente.');
          _currentStep = RegistrationStep.awaitingPassword;
        } else {
          _currentStep = RegistrationStep.creatingAccount;
          _addBotMessage(
              'Perfeito, $_name! A finalizar o seu registo, por favor aguarde...');

          // Simula a criação de conta e navega para a home
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          });
        }
        break;
      case RegistrationStep.creatingAccount:
        break;
    }
  }

  void _addBotMessage(String text, {int delay = 1200, Widget? child}) {
    Future.delayed(Duration(milliseconds: delay), () {
      if (!mounted) return;
      setState(() {
        final content = child ?? Text(text, style: AppTheme.bodyTextStyle);
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
  void _askForEmail() => _addBotMessage('',
      child: _SocialLoginOptions(
        onSelectEmail: _onSelectEmailOption,
        onShowAlert: () =>
            _showCupertinoAlert('Função Mock', 'Login com Google (mock)!'),
      ));
  void _askForPassword() {
    _addBotMessage('Obrigado! Para proteger a tua conta...');
    _addBotMessage('Crie uma senha segura.', delay: 2000);
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
            Container(height: 1, color: AppTheme.phatoGray.withOpacity(0.5)),
            _buildMessageInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageRow(ChatMessage message) {
    final isUser = message.sender == MessageSender.user;

    final Widget avatar = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isUser
            ? AppTheme.phatoYellow.withAlpha(50)
            : AppTheme.phatoCardGray,
        shape: BoxShape.circle,
      ),
      child: isUser
          ? const Icon(CupertinoIcons.person_fill, color: AppTheme.phatoYellow)
          : const Center(child: Text('🦆', style: TextStyle(fontSize: 24))),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: avatar,
            ),
          Flexible(
            child: ChatBubble(
              sender: message.sender,
              child: message.content,
            ),
          ),
          if (isUser)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: avatar,
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    String hintText;
    TextInputType keyboardType;
    bool obscureText;
    bool isEnabled = _currentStep != RegistrationStep.creatingAccount;

    switch (_currentStep) {
      case RegistrationStep.awaitingName:
        hintText = 'Digite o seu nome...';
        keyboardType = TextInputType.name;
        obscureText = false;
        break;
      case RegistrationStep.awaitingEmailChoice:
        hintText = 'Escolha uma opção acima...';
        keyboardType = TextInputType.none;
        obscureText = false;
        break;
      case RegistrationStep.awaitingEmailInput:
        hintText = 'Digite o seu email...';
        keyboardType = TextInputType.emailAddress;
        obscureText = false;
        break;
      case RegistrationStep.awaitingPassword:
        hintText = 'Digite a sua senha...';
        keyboardType = TextInputType.visiblePassword;
        obscureText = true;
        break;
      case RegistrationStep.awaitingPasswordConfirmation:
        hintText = 'Confirme a sua senha...';
        keyboardType = TextInputType.visiblePassword;
        obscureText = true;
        break;
      default:
        hintText = 'Aguarde...';
        keyboardType = TextInputType.none;
        obscureText = false;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: AppTheme.phatoBlack,
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: _messageController,
              enabled: isEnabled,
              placeholder: hintText,
              style: AppTheme.bodyTextStyle,
              keyboardType: keyboardType,
              obscureText: obscureText,
              onSubmitted: (_) => _handleSendMessage(),
              decoration: BoxDecoration(
                color: isEnabled ? AppTheme.phatoCardGray : AppTheme.phatoGray,
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          const SizedBox(width: 8.0),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: isEnabled ? _handleSendMessage : null,
            child: Icon(CupertinoIcons.arrow_up_circle_fill,
                size: 32,
                color:
                    isEnabled ? AppTheme.phatoYellow : AppTheme.phatoTextGray),
          ),
        ],
      ),
    );
  }
}

class _SocialLoginOptions extends StatelessWidget {
  final VoidCallback onSelectEmail;
  final VoidCallback onShowAlert;

  const _SocialLoginOptions({
    required this.onSelectEmail,
    required this.onShowAlert,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Entendido. Para o email, pode digitá-lo ou usar uma das opções de acesso rápido:',
            style: AppTheme.bodyTextStyle),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
              color: CupertinoColors.white,
              onPressed: onShowAlert,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Adicione a imagem do logo do Google aqui se tiver
                  Text('Continuar com Google',
                      style: AppTheme.bodyTextStyle.copyWith(
                          color: AppTheme.phatoBlack,
                          fontWeight: FontWeight.bold)),
                ],
              )),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
              color: CupertinoColors.white,
              onPressed: onShowAlert,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.bell,
                      color: AppTheme.phatoBlack), // Icone temporario
                  const SizedBox(width: 8),
                  Text('Continuar com Apple',
                      style: AppTheme.bodyTextStyle.copyWith(
                          color: AppTheme.phatoBlack,
                          fontWeight: FontWeight.bold)),
                ],
              )),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: Container(height: 1, color: AppTheme.phatoGray)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("OU", style: AppTheme.secondaryTextStyle)),
            Expanded(child: Container(height: 1, color: AppTheme.phatoGray)),
          ],
        ),
        const SizedBox(height: 12),
        Center(
          child: CupertinoButton(
            onPressed: onSelectEmail,
            child: Text(
              'Prefiro usar o meu email',
              style: AppTheme.bodyTextStyle.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppTheme.phatoTextGray,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
