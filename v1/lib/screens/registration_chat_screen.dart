// CÓDIGO FINAL E CORRIGIDO para: lib/screens/registration_chat_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:phato_mvp/widgets/chat_bubble.dart';
import 'package:phato_mvp/services/auth_service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

// ENUM ATUALIZADO com um novo estado para gerir o fluxo corretamente
enum RegistrationStep {
  awaitingName,
  awaitingAge,
  awaitingEmailChoice, // Estado para mostrar as opções (Google, Apple, link)
  awaitingEmailInput,  // NOVO ESTADO: Agora esperamos pela digitação do email
  awaitingPassword,
  awaitingPasswordConfirmation,
  creatingAccount,
}

class ChatMessage {
  final Widget content;
  final MessageSender sender;
  ChatMessage({required this.content, required this.sender});
}

class RegistrationChatScreen extends ConsumerStatefulWidget {
  const RegistrationChatScreen({super.key});

  @override
  ConsumerState<RegistrationChatScreen> createState() => _RegistrationChatScreenState();
}

class _RegistrationChatScreenState extends ConsumerState<RegistrationChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  RegistrationStep _currentStep = RegistrationStep.awaitingName;
  String _email = '';
  String _name = '';
  String _password = '';
  int? _age;

  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    if (_messages.isEmpty) {
      _addBotMessage('Olá! Bem-vindo(a) ao Phato. Vamos criar a tua conta num instante.', delay: 500);
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

  void _handleGoogleSignIn() async {
    try {
      await ref.read(authServiceProvider).signInWithGoogle();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao fazer login com Google: $e')),
        );
      }
    }
  }

  void _handleSendMessage({String? preDefinedText}) async {
    final text = preDefinedText ?? _messageController.text.trim();
    if (text.isEmpty || _currentStep == RegistrationStep.creatingAccount) return;

    final userInput = text;
    if (preDefinedText == null) {
      _messageController.clear();
    }
    
    final messageContent = Text(
      _currentStep == RegistrationStep.awaitingPassword || _currentStep == RegistrationStep.awaitingPasswordConfirmation
          ? '*' * userInput.length
          : userInput,
      style: GoogleFonts.quicksand(
        fontSize: 15,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );

    setState(() {
      _messages.add(ChatMessage(content: messageContent, sender: MessageSender.user));
    });
    _scrollToBottom();
    
    // LÓGICA ATUALIZADA com o novo estado
    switch (_currentStep) {
      case RegistrationStep.awaitingName:
        _name = userInput;
        _currentStep = RegistrationStep.awaitingAge;
        _askForAge();
        break;
      case RegistrationStep.awaitingAge:
        final age = int.tryParse(userInput);
        if (age == null || age <= 0) {
          _addBotMessage('Ups, isso não parece uma *idade válida*. Por favor, insira apenas números.');
        } else {
          _age = age;
          _currentStep = RegistrationStep.awaitingEmailChoice;
          _askForEmail();
        }
        break;
      // Neste estado, a app espera por um clique nos botões/link, não por texto.
      case RegistrationStep.awaitingEmailChoice:
        _addBotMessage("Por favor, escolha uma das opções acima ou digite o seu email.");
        break;
      // AGORA, este estado trata da digitação do email
      case RegistrationStep.awaitingEmailInput:
        _email = userInput;
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
          _addBotMessage('As senhas não coincidem. Por favor, digite a sua *senha segura* novamente.');
          _currentStep = RegistrationStep.awaitingPassword;
        } else {
          _currentStep = RegistrationStep.creatingAccount;
          _addBotMessage('Perfeito! A finalizar o seu registo, por favor aguarde...');
          
          try {
            final authService = ref.read(authServiceProvider);
            // MUDANÇA AQUI: Passamos os novos dados (name e age) para a função
            await authService.registerWithEmailAndPassword(_email, _password, _name, _age!);
            
            _addBotMessage('Conta criada com sucesso! A redirecionar...');
            
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
            });
          } catch (e) {
            _addBotMessage('Ocorreu um *erro*: ${e.toString().split('] ').last}. Vamos tentar de novo.');
            _addBotMessage('Por favor, insira o seu *nome*.', delay: 2500);
            _currentStep = RegistrationStep.awaitingName;
          }
        }
        break;
      case RegistrationStep.creatingAccount:
        break;
    }
  }

  void _addBotMessage(String text, {int delay = 1200, Widget? child, bool isBold = false}) {
     Future.delayed(Duration(milliseconds: delay), () {
      if(!mounted) return;
      setState(() {
        final content = child ?? (isBold 
          ? Text(text, style: GoogleFonts.quicksand(fontSize: 15, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold))
          : AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  text,
                  textStyle: GoogleFonts.quicksand(fontSize: 15, color: Theme.of(context).colorScheme.onPrimary),
                  speed: const Duration(milliseconds: 35),
                ),
              ],
              isRepeatingAnimation: false, totalRepeatCount: 1,
            )
        );
        _messages.add(ChatMessage(content: content, sender: MessageSender.bot));
      });
      _scrollToBottom();
    });
  }

  // LÓGICA ATUALIZADA para o clique no link de email
  void _onSelectEmailOption() {
    _handleSendMessage(preDefinedText: "Quero usar o meu email");
    _addBotMessage("Sem problemas. Por favor, digite o teu email abaixo.", isBold: true);
    setState(() {
      _currentStep = RegistrationStep.awaitingEmailInput;
    });
  }

  void _askForName({int delay = 1200}) => _addBotMessage('Qual é o teu nome?', delay: delay, isBold: true);
  void _askForAge() => _addBotMessage('Prazer, $_name! E qual é a tua idade?', delay: 1200);
  void _askForEmail() => _addBotMessage('', child: _SocialLoginOptions(onSelectEmail: _onSelectEmailOption, onGoogleSignIn: _handleGoogleSignIn));
  void _askForPassword() {
    _addBotMessage('Obrigado! Para proteger a tua conta...');
    _addBotMessage('Crie uma senha segura.', delay: 2000, isBold: true);
  }
  void _askForPasswordConfirmation() => _addBotMessage('Digite a senha novamente, só para confirmar.', isBold: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criação de Conta'), centerTitle: true),
      body: Column(
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
          const Divider(height: 1, thickness: 1),
          _buildMessageInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageRow(ChatMessage message) {
    final isUser = message.sender == MessageSender.user;
    
    final Widget avatar = CircleAvatar(
      backgroundColor: isUser ? Theme.of(context).colorScheme.primary.withAlpha(50) : Theme.of(context).cardTheme.color,
      child: isUser
          ? Icon(Icons.person, color: Theme.of(context).colorScheme.primary)
          : const Text('🦆', style: TextStyle(fontSize: 24)),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) avatar,
          Flexible(
            child: ChatBubble(
              sender: message.sender,
              child: message.content,
            ),
          ),
          if (isUser) avatar,
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
      case RegistrationStep.awaitingAge:
        hintText = 'Digite a sua idade...';
        keyboardType = TextInputType.number;
        obscureText = false;
        break;
      // O estado de escolha não permite digitar
      case RegistrationStep.awaitingEmailChoice:
        hintText = 'Escolha uma opção acima...';
        keyboardType = TextInputType.none;
        obscureText = false;
        break;
      // NOVO: O hint text para quando o bot pede o email
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
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                enabled: isEnabled,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: isEnabled ? Theme.of(context).cardTheme.color : Colors.grey.shade800,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                keyboardType: keyboardType,
                obscureText: obscureText,
                onSubmitted: (_) => _handleSendMessage(),
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton(
              icon: Icon(Icons.send, color: isEnabled ? Theme.of(context).colorScheme.primary : Colors.grey),
              onPressed: isEnabled ? _handleSendMessage : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialLoginOptions extends StatelessWidget {
  final VoidCallback onSelectEmail;
  final VoidCallback onGoogleSignIn;

  const _SocialLoginOptions({
    required this.onSelectEmail,
    required this.onGoogleSignIn,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      side: BorderSide(color: Colors.grey.shade300),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );

    final buttonTextStyle = GoogleFonts.quicksand(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Colors.black87,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Entendido. Para o email, pode digitá-lo ou usar uma das opções de acesso rápido:',
              textStyle: GoogleFonts.quicksand(fontSize: 15, color: Theme.of(context).colorScheme.onPrimary),
              speed: const Duration(milliseconds: 35),
            ),
          ],
          isRepeatingAnimation: false, totalRepeatCount: 1,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: buttonStyle,
            onPressed: onGoogleSignIn,
            icon: Image.asset('assets/google.png', height: 18),
            label: Text('Continuar com Google', style: buttonTextStyle),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: buttonStyle,
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login com Apple (mock)!'))),
            icon: const Icon(Icons.apple),
            label: Text('Continuar com Apple', style: buttonTextStyle),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: Divider(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6))),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text("OU", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)))),
            Expanded(child: Divider(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.6))),
          ],
        ),
        const SizedBox(height: 12),
        Center(
          child: TextButton(
            onPressed: onSelectEmail,
            child: Text(
              'Prefiro usar o meu email',
              style: GoogleFonts.quicksand(
                color: Theme.of(context).colorScheme.onPrimary,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}