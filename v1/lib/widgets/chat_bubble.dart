import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';

enum MessageSender { user, bot }

class ChatBubble extends StatefulWidget {
  final Widget child;
  final MessageSender sender;

  const ChatBubble({
    super.key,
    required this.child,
    required this.sender,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isUser = widget.sender == MessageSender.user;
    final Color bubbleColor =
        isUser ? AppTheme.phatoGray : AppTheme.phatoYellow;

    final Alignment alignment =
        isUser ? Alignment.centerRight : Alignment.centerLeft;

    final BorderRadius borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(16.0),
      topRight: const Radius.circular(16.0),
      bottomLeft: isUser ? const Radius.circular(16.0) : Radius.zero,
      bottomRight: isUser ? Radius.zero : const Radius.circular(16.0),
    );

    return FadeTransition(
      opacity: _animation,
      child: Align(
        alignment: alignment,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: borderRadius,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
