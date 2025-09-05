// CÓDIGO ATUALIZADO para: lib/screens/phatobot_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:phato_mvp/widgets/chat_bubble.dart';
import 'package:phato_mvp/services/auth_service.dart';

class ChatMessage {
  final Widget content;
  final MessageSender sender;

  ChatMessage({required this.content, required this.sender});
}

class PhatoBotScreen extends ConsumerStatefulWidget {
  const PhatoBotScreen({super.key});

  @override
  ConsumerState<PhatoBotScreen> createState() => _PhatoBotScreenState();
}

class _PhatoBotScreenState extends ConsumerState<PhatoBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 1;

  final List<ChatMessage> _messages = [];
  bool _isPhatobotTyping = false;

  @override
  void initState() {
    super.initState();
    if (_messages.isEmpty) {
      _addBotMessage('Olá! Sou o PhatoBot. Como posso ajudar a desvendar as notícias para você hoje?', delay: 500);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  void _handleSendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();

    final userMessageContent = Text(
      text,
      style: GoogleFonts.quicksand(
        fontSize: 15,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );

    setState(() {
      _messages.add(ChatMessage(content: userMessageContent, sender: MessageSender.user));
    });
    _scrollToBottom();

    setState(() {
      _isPhatobotTyping = true;
    });
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 2), () {
      if(!mounted) return;
      setState(() {
        _isPhatobotTyping = false;
        _addBotMessage('Entendi sua pergunta: "$text". Buscando as informações para você...', delay: 0);
      });
    });
  }

  void _addBotMessage(String text, {int delay = 1200}) {
     Future.delayed(Duration(milliseconds: delay), () {
      if(!mounted) return;
      setState(() {
        final animatedText = AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              text,
              textStyle: GoogleFonts.quicksand(
                fontSize: 15,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              // MUDANÇA AQUI: Velocidade ajustada para 35ms
              speed: const Duration(milliseconds: 35),
            ),
          ],
          isRepeatingAnimation: false,
          totalRepeatCount: 1,
        );
        _messages.add(ChatMessage(content: animatedText, sender: MessageSender.bot));
      });
      _scrollToBottom();
    });
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length + (_isPhatobotTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isPhatobotTyping && index == _messages.length) {
                  return _buildTypingIndicator();
                }
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
          ChatBubble(
            sender: message.sender,
            child: message.content,
          ),
          if (isUser) avatar,
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).cardTheme.color,
            child: const Text('🦆', style: TextStyle(fontSize: 24)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_p8bfn5to.json',
              width: 50,
              height: 35,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: 'Me pergunte sobre alguma coisa...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: Theme.of(context).cardTheme.color,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onSubmitted: (_) => _handleSendMessage(),
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton(
              icon: Icon(Icons.send, color: Theme.of(context).colorScheme.primary),
              onPressed: _handleSendMessage,
            ),
          ],
        ),
      ),
    );
  }
}