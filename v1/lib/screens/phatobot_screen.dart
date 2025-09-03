import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import '../models/chat_message.dart';
import '../widgets/chat_bubble.dart';

// --- INSTRUÇÕES ---
// 1. Substitua o conteúdo do seu `lib/screens/phatobot_screen.dart` por este código.
// 2. A dependência `lottie` já deve estar no seu `pubspec.yaml`.

class PhatoBotScreen extends StatefulWidget {
  const PhatoBotScreen({super.key});

  @override
  State<PhatoBotScreen> createState() => _PhatoBotScreenState();
}

class _PhatoBotScreenState extends State<PhatoBotScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  int _conversationStep = 0;

  @override
  void initState() {
    super.initState();
    // Inicia a conversa
    _triggerConversation();
  }

  // Simula a conversa estática
  void _triggerConversation() {
    const conversation = [
      {
        'sender': MessageSender.bot,
        'message':
            'Olá! Sou o PhatoBot. Como posso ajudar a desvendar as notícias para você hoje?',
        'delay': 500,
      },
      {
        'sender': MessageSender.user,
        'message': 'Me fale sobre a nova era da IA.',
        'delay': 2000,
      },
      {
        'sender': MessageSender.bot,
        'message':
            'Claro! A "Nova Era da Inteligência Artificial" refere-se aos avanços recentes em modelos de linguagem, que estão se tornando mais poderosos e acessíveis.',
        'delay': 3500,
      },
      {
        'sender': MessageSender.bot,
        'message':
            'Posso resumir o artigo principal sobre isso para você, se quiser.',
        'delay': 2000,
      },
    ];

    if (_conversationStep < conversation.length) {
      final step = conversation[_conversationStep];
      Future.delayed(Duration(milliseconds: step['delay'] as int), () {
        _addMessage(step['message'] as String, step['sender'] as MessageSender);
        _conversationStep++;
        if (_conversationStep < conversation.length) {
          _triggerConversation(); // Chama o próximo passo
        }
      });
    }
  }

  void _addMessage(String text, MessageSender sender) {
    setState(() {
      _isTyping = sender == MessageSender.user;
      _messages.add(
        ChatMessage(
          content: Text(
            text,
            style: TextStyle(
              color: sender == MessageSender.bot ? Colors.black : Colors.white,
            ),
          ),
          sender: sender,
        ),
      );
    });

    if (sender == MessageSender.user) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() => _isTyping = true);
        _scrollToBottom();
      });
    } else {
      setState(() => _isTyping = false);
    }
    _scrollToBottom();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PhatoBot'), elevation: 1),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  return ChatBubble(
                    sender: MessageSender.bot,
                    child: Lottie.network(
                      'https://assets9.lottiefiles.com/packages/lf20_p8bfn5to.json',
                      width: 50,
                      height: 25,
                    ),
                  );
                }
                final message = _messages[index];
                return ChatBubble(
                  sender: message.sender,
                  child: message.content,
                );
              },
            ),
          ),
          _buildMessageInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                enabled: false, // Desabilitado para o protótipo
                decoration: InputDecoration(
                  hintText: 'Digite sua mensagem...',
                  filled: true,
                  fillColor: Theme.of(context).cardTheme.color,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton(
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: null, // Desabilitado
            ),
          ],
        ),
      ),
    );
  }
}
