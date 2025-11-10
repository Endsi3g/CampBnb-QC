import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class ChatConversationScreen extends StatefulWidget {
  final String userId;

  const ChatConversationScreen({super.key, required this.userId});

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.textDark : AppColors.textLight,
          ),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuC3wlK1PZMpvn8G2EOWRU1qvcE72MBKFT-mcs5oj6ajPsPKNORGD-p4SGPbb-pSGgAUiOdlT8PeeXmPSV32lRsClH_W50qvsov29ziUxf74BQ3iI6pUgcCJNekb0bPS-kX3-XkeodhrY7u9dtU_N34AXIxK03YvgawNf2k2DuwLud_1OOArS0enEq8Td4zkpZpy2d_QDrTOaO-p_fE1v_UazOyVlMvRLiHyQI6aXj33t9InWE7AWtxe2sDjBuqKFE8pe_0sg2LUoqzQ',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jean-Pierre',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textDark : AppColors.textLight,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  Text(
                    'Host',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? AppColors.textDark : AppColors.textLight,
            ),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Booking Info Banner
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: AppColors.secondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Booking for Lac-Beauport, Jul 15-18',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppColors.textDark : AppColors.textLight,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 20),
                  onPressed: () {},
                  color: isDark ? AppColors.textDark : AppColors.textLight,
                ),
              ],
            ),
          ),
          // Messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Text(
                    'July 12, 2024',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade400,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildMessage(
                  isMe: false,
                  message: 'Bonjour! Just confirming your booking. Do you have any questions about the campsite?',
                  time: '10:45 AM',
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _buildMessage(
                  isMe: true,
                  message: 'Hi Jean-Pierre, thanks for reaching out! We are all set. We were just wondering if the site has a fire pit?',
                  time: '10:47 AM',
                  isRead: true,
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _buildMessage(
                  isMe: false,
                  message: 'Yes, it does! Firewood is available for purchase at the camp office.',
                  time: '10:48 AM',
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _buildMessage(
                  isMe: true,
                  message: 'Perfect, thank you!',
                  time: '10:48 AM',
                  isRead: false,
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                _buildImageMessage(
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuAccZv4Gt4e_ommjYo2lDdZR35E9IxCVZb_kmvz6-NwYy8FngMPMkD8QISi2X9vBVYsMiDAvvPXTc4yNwC0cfraFxZcheksAgdPmNsFtOTOuXs4RnQytyqD6pRvxV5yQAMrnQOirQZhDyCECGtIwIukDwWzgqTArHMYq6Cp_dUJiRW4BElO5mjpmqKPT6wxhzZHGIN40dtz3k3gnjKNDIjIpAzF44fSCqoIOTVF4wu8VV5kMSaKND1rBadl1N7bXzaU-6ZGlTMgNAwL',
                  time: '10:52 AM',
                  isRead: false,
                  isDark: isDark,
                ),
              ],
            ),
          ),
          // Input Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (isDark ? AppColors.backgroundDark : AppColors.backgroundLight).withOpacity(0.8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.photo_camera,
                    color: isDark ? AppColors.textDark : AppColors.textLight,
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'PlusJakartaSans',
                      ),
                      filled: true,
                      fillColor: isDark ? Colors.grey.shade800 : AppColors.neutral.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9999),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9999),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9999),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    style: TextStyle(
                      color: isDark ? AppColors.textDark : AppColors.textLight,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // TODO: Send message
                      _messageController.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage({
    required bool isMe,
    required String message,
    required String time,
    required bool isDark,
    bool isRead = false,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCDRT3XJDgroNHh91a7UU_ZNr1met7foOoPM6xC8bIte1SZyhYlWIeUCiVsEnmOcO0T52dbTFvZee2SsLf9V1jEclLlVEJhhwJbQtKWwGytKwKXFQwAzlPKsiDBcgs9DUsyQmaN76RqfRwweN51GjzrDf0z7k6sTJurgWcaLdu8a7d_yqGHLjXgtmSeJSRHAVy8-ti9mVNPvZH0NlrgEqodbysFxgav35JfqZgC0Tck23oTAb5rT_toRM72UfItXqlTULKqzN5Nd_4I',
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isMe
                        ? AppColors.primary
                        : (isDark ? Colors.grey.shade800 : AppColors.neutral),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: Radius.circular(isMe ? 12 : 0),
                      bottomRight: Radius.circular(isMe ? 0 : 12),
                    ),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      color: isMe ? Colors.white : (isDark ? AppColors.textDark : AppColors.textLight),
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      Icon(
                        isRead ? Icons.done_all : Icons.done,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageMessage({
    required String imageUrl,
    required String time,
    required bool isDark,
    bool isRead = false,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                isRead ? Icons.done_all : Icons.done,
                size: 16,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

