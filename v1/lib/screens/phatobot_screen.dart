import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/models/article.dart';
import 'package:phato_prototype/widgets/chat_bubble.dart';

class ChatMessage {
  final Widget content;
  final MessageSender sender;

  ChatMessage({required this.content, required this.sender});
}

class PhatoBotScreen extends StatefulWidget {
  final Article? article;

  const PhatoBotScreen(
      {super.key,
      this.article,
      Article? articleContext,
      required comesFromArticle});

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
    if (widget.article != null) {
      _addInitialArticleMessage();
    } else if (_messages.isEmpty) {
      _addBotMessage(
          'Olá! Sou o PhatoBot. Como posso ajudar a desvendar as notícias para si hoje?',
          delay: 500);
    }
  }

  void _addInitialArticleMessage() {
    final article = widget.article!;
    final initialMessage = ChatMessage(
      sender: MessageSender.user, // Representa o contexto do utilizador
      content: _ArticleQuestionCard(article: article),
    );
    setState(() {
      _messages.add(initialMessage);
    });
    _addBotMessage(
        'Vejo que está a ler sobre "${article.title}". O que gostaria de saber especificamente?',
        delay: 500);
  }

  void _handleSendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();

    final userMessageContent = Text(
      text,
      style: AppTheme.bodyTextStyle.copyWith(color: AppTheme.phatoTextGray),
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

    // Simula a resposta do bot
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isPhatobotTyping = false;
        _addBotMessage(
            'Esta é uma resposta padrão para a sua pergunta sobre "$text". Num protótipo funcional, eu analisaria o artigo e dar-lhe-ia uma resposta detalhada.',
            delay: 0);
      });
    });
  }

  void _addBotMessage(String text, {int delay = 1200}) {
    Future.delayed(Duration(milliseconds: delay), () {
      if (!mounted) return;
      setState(() {
        final content = Text(text, style: AppTheme.bodyTextStyle);
        _messages.add(ChatMessage(content: content, sender: MessageSender.bot));
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

  Widget _buildTypingIndicator() {
    return _buildMessageRow(
      ChatMessage(
        sender: MessageSender.bot,
        content: const CupertinoActivityIndicator(),
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
              placeholder: 'Pergunte-me alguma coisa...',
              style: AppTheme.bodyTextStyle,
              onSubmitted: (_) => _handleSendMessage(),
              decoration: BoxDecoration(
                color: AppTheme.phatoCardGray,
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          const SizedBox(width: 8.0),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _handleSendMessage,
            child: const Icon(CupertinoIcons.arrow_up_circle_fill,
                size: 32, color: AppTheme.phatoYellow),
          ),
        ],
      ),
    );
  }
}

// Widget para exibir o contexto do artigo no chat
class _ArticleQuestionCard extends StatelessWidget {
  final Article article;
  const _ArticleQuestionCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppTheme.phatoGray.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (article.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                article.imageUrl!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A perguntar sobre:',
                  style: AppTheme.secondaryTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  article.title,
                  style: AppTheme.bodyTextStyle
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
