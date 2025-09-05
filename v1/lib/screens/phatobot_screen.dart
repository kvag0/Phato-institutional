import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:phato_prototype/widgets/chat_bubble.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';

class ChatMessage {
  final Widget content;
  final MessageSender sender;

  ChatMessage({required this.content, required this.sender});
}

class PhatoBotScreen extends StatefulWidget {
  const PhatoBotScreen({super.key});

  @override
  State<PhatoBotScreen> createState() => _PhatoBotScreenState();
}

class _PhatoBotScreenState extends State<PhatoBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [];
  bool _isPhatobotTyping = false;

  @override
  void initState() {
    super.initState();
    if (_messages.isEmpty) {
      _addBotMessage(
          'Olá! Sou o PhatoBot. Como posso ajudar a desvendar as notícias para você hoje?',
          delay: 500);
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
        color: AppTheme.phatoLightGray,
      ),
    );

    setState(() {
      _messages.add(
          ChatMessage(content: userMessageContent, sender: MessageSender.user));
    });
    _scrollToBottom();

    setState(() {
      _isPhatobotTyping = true;
    });
    _scrollToBottom();

    // Simulação de resposta do bot
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isPhatobotTyping = false;
        _addBotMessage(
            'Esta é uma resposta padrão do protótipo. A funcionalidade completa do chat será implementada na versão final.',
            delay: 0);
      });
    });
  }

  void _addBotMessage(String text, {int delay = 1200}) {
    Future.delayed(Duration(milliseconds: delay), () {
      if (!mounted) return;
      setState(() {
        final animatedText = AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              text,
              textStyle: GoogleFonts.quicksand(
                fontSize: 15,
                color: AppTheme.phatoBlack,
              ),
              speed: const Duration(milliseconds: 35),
            ),
          ],
          isRepeatingAnimation: false,
          totalRepeatCount: 1,
        );
        _messages
            .add(ChatMessage(content: animatedText, sender: MessageSender.bot));
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
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.phatoBlack,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('PhatoBot'),
      ),
      child: SafeArea(
        child: Column(
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
          if (!isUser)
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text('🤖', style: TextStyle(fontSize: 24)),
            ),
          Flexible(
            child: ChatBubble(
              sender: message.sender,
              child: message.content,
            ),
          ),
          if (isUser)
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(CupertinoIcons.person_alt_circle_fill,
                  size: 28, color: AppTheme.phatoGray),
            )
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
          const Text('🤖', style: TextStyle(fontSize: 24)),
          ChatBubble(
            sender: MessageSender.bot,
            child: Lottie.asset(
              'assets/animations/typing.json',
              width: 50,
              height: 25,
              errorBuilder: (ctx, err, st) =>
                  const SizedBox(width: 50, height: 25),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: AppTheme.phatoBlack,
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: _messageController,
              placeholder: 'Pergunte algo...',
              style: AppTheme.bodyTextStyle,
              onSubmitted: (_) => _handleSendMessage(),
              decoration: BoxDecoration(
                color: AppTheme.phatoCardGray,
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _handleSendMessage,
            child: const Icon(CupertinoIcons.arrow_up_circle_fill, size: 32),
          ),
        ],
      ),
    );
  }
}
