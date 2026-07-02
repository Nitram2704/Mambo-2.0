import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}

class ChatWindowOverlay extends StatefulWidget {
  final VoidCallback onClose;

  const ChatWindowOverlay({
    super.key,
    required this.onClose,
  });

  @override
  State<ChatWindowOverlay> createState() => _ChatWindowOverlayState();
}

class _ChatWindowOverlayState extends State<ChatWindowOverlay> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Welcome message
    _messages.add(
      ChatMessage(
        text: "¡Hola! Soy tu asistente Mambo AI. ¿En qué te puedo ayudar hoy con tu entrenamiento, alimentación o sueño?",
        isMe: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
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

  void _handleSendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isMe: true,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });
    _scrollToBottom();

    // Simulate AI response
    Timer(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(
          ChatMessage(
            text: _getMockAIResponse(text),
            isMe: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      _scrollToBottom();
    });
  }

  String _getMockAIResponse(String userMessage) {
    final msg = userMessage.toLowerCase();
    if (msg.contains("entren") || msg.contains("ejercic") || msg.contains("rutin")) {
      return "¡Excelente! Para optimizar tu entrenamiento hoy, te sugiero enfocar los primeros 10 minutos en calentamiento articular. ¿Qué grupo muscular quieres trabajar?";
    } else if (msg.contains("comida") || msg.contains("dieta") || msg.contains("nutric") || msg.contains("alimen")) {
      return "Recuerda mantener una hidratación de al menos 2.5 litros hoy y priorizar fuentes limpias de proteína. ¿Buscas ideas para el almuerzo o cena?";
    } else if (msg.contains("sueñ") || msg.contains("dorm") || msg.contains("cansad")) {
      return "El descanso es crucial para recuperar. Evita pantallas azules 1 hora antes de dormir y mantén tu habitación a una temperatura fresca.";
    }
    return "Entendido. Sigo aprendiendo de tus hábitos en Mambo. ¿Hay algo específico sobre tus rutinas de bienestar de lo que quieras hablar?";
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 145,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 320,
          height: 420,
          decoration: BoxDecoration(
            color: const Color(0xFA141414), // Solid dark base matching premium theme
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              _buildHeader(),
              // Message List
              Expanded(child: _buildMessageList()),
              // Typing indicator
              if (_isTyping) _buildTypingIndicator(),
              // Divider
              Container(height: 1, color: AppColors.border),
              // Input Field
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            "Mambo AI",
            style: TextStyle(
              color: AppColors.text,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
            onPressed: widget.onClose,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 240),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.accent.withOpacity(0.15) : const Color(0xFF222222),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(message.isMe ? 12 : 2),
            bottomRight: Radius.circular(message.isMe ? 2 : 12),
          ),
          border: Border.all(
            color: message.isMe ? AppColors.accent.withOpacity(0.3) : const Color(0xFF333333),
            width: 1,
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isMe ? AppColors.accent : AppColors.text,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16, bottom: 8),
        child: Text(
          "Mambo AI está escribiendo...",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: (_) => _handleSendMessage(),
              style: const TextStyle(color: AppColors.text, fontSize: 13),
              decoration: InputDecoration(
                hintText: "Escribe un mensaje...",
                hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppColors.accent),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _handleSendMessage,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
