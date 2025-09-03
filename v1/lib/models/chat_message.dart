import 'package:flutter/material.dart';

// --- INSTRUÇÕES ---
// 1. Crie um novo arquivo chamado `chat_message.dart` dentro da sua pasta `lib/models/`.
// 2. Cole este código no novo arquivo.

enum MessageSender { user, bot }

class ChatMessage {
  final Widget content;
  final MessageSender sender;

  ChatMessage({required this.content, required this.sender});
}
