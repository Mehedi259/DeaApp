import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_dea/core/gen/assets.gen.dart';
import 'package:mobile_app_dea/themes/text_styles.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "I'd love to add more info to my profile but can't find the option. Where do I go to edit my bio and add interests?",
      timestamp: "Yesterday, 10:15 AM",
      isFromUser: true,
    ),
    ChatMessage(
      text:
          "I'd love to add more info to my profile but can't find the option. Where do I go to edit my bio and add interests?",
      timestamp: "Yesterday, 10:16 AM",
      isFromUser: false,
    ),
    ChatMessage(
      text:
          "I'd love to add more info to my profile but can't find the option. Where do I go to edit my bio and add interests?",
      timestamp: "Yesterday, 10:15 AM",
      isFromUser: true,
    ),
    ChatMessage(
      text:
          "I'd love to add more info to my profile but can't find the option. Where do I go to edit my bio and add interests?",
      timestamp: "Yesterday, 10:15 AM",
      isFromUser: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B4FFF),
      body: Column(
        children: [
          const SizedBox(height: 50),
          _buildHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final showSenderName =
                            index == 0 ||
                            _messages[index - 1].isFromUser !=
                                message.isFromUser;

                        return _buildMessageBubble(message, showSenderName);
                      },
                    ),
                  ),
                  _buildMessageInput(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(
              Assets.svgIcons.settingsBackIcon.path,
              width: 32,
              height: 32,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          Text('SUPPORT CHAT', style: AppsTextStyles.kSettingsTitleStyle),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool showSenderName) {
    return Column(
      crossAxisAlignment: message.isFromUser
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        if (showSenderName)
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 8,
              left: 4,
              right: 4,
            ),
            child: Text(
              'Alex from Nowlli',
              style: GoogleFonts.workSans(
                color: const Color(0xFF4C586E),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.40,
                letterSpacing: -0.50,
              ),
            ),
          )
        else
          const SizedBox(height: 8),
        Row(
          mainAxisAlignment: message.isFromUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: message.isFromUser
                      ? const Color(0xFFB8D4FF)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  message.text,
                  style: GoogleFonts.workSans(
                    color: const Color(0xFF011F54),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
          child: Text(
            message.timestamp,
            style: GoogleFonts.workSans(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 43.74,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.88, color: const Color(0xFFC3DBFF)),
                  borderRadius: BorderRadius.circular(20971500),
                ),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: GoogleFonts.workSans(
                    color: const Color(0xFFADB2BC),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    letterSpacing: -0.5,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              if (_messageController.text.isNotEmpty) {
                setState(() {
                  _messages.add(
                    ChatMessage(
                      text: _messageController.text,
                      timestamp: "Just now",
                      isFromUser: true,
                    ),
                  );
                  _messageController.clear();
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                Assets.svgIcons.chatbot.path,
                width: 40,
                height: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final String timestamp;
  final bool isFromUser;

  ChatMessage({
    required this.text,
    required this.timestamp,
    required this.isFromUser,
  });
}
