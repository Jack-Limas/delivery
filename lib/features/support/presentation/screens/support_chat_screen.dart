import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = <_ChatMessage>[
    const _ChatMessage(text: 'Hi, how can I help you?', isUser: false),
    const _ChatMessage(
      text:
          'Hello, I ordered two fried chicken burgers, can I know how much time it will get to arrive?',
      isUser: true,
    ),
    const _ChatMessage(text: 'Ok, please let me check!', isUser: false),
    const _ChatMessage(text: 'Sure...', isUser: true),
    const _ChatMessage(
      text: "It'll get 25 minutes to arrive to your address",
      isUser: false,
      showTimestamp: true,
    ),
    const _ChatMessage(
      text: 'Ok, thanks you for your support',
      isUser: true,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _messages.add(
        const _ChatMessage(
          text: 'Support received your message and will answer shortly.',
          isUser: false,
        ),
      );
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
          child: Column(
            children: [
              Row(
                children: [
                  _TopIconButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  const _TopIconButton(
                    icon: Icons.segment,
                    onTap: _noop,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.separated(
                  itemCount: _messages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _MessageBubble(message: message);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(18, 10, 10, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 22,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Type here...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 52,
                      height: 52,
                      child: FilledButton(
                        onPressed: _sendMessage,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Icon(Icons.send_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.text,
    required this.isUser,
    this.showTimestamp = false,
  });

  final String text;
  final bool isUser;
  final bool showTimestamp;
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final bubbleColor =
        message.isUser ? AppColors.primary : const Color(0xFFF3F3F8);
    final textColor = message.isUser ? Colors.white : const Color(0xFF40312E);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!message.isUser) ...[
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF453533),
                child: Icon(Icons.person_outline, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                constraints: const BoxConstraints(maxWidth: 220),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: message.isUser
                      ? const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 14,
                            offset: Offset(0, 8),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (message.isUser) ...[
              const SizedBox(width: 10),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile_avatar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (message.showTimestamp)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              '26 minutes ago',
              style: TextStyle(
                color: Color(0xFFD0C7C4),
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

class _TopIconButton extends StatelessWidget {
  const _TopIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(icon, color: const Color(0xFF3D2E2A), size: 28),
      ),
    );
  }
}

void _noop() {}
