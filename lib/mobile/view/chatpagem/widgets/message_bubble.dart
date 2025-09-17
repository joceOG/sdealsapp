import 'package:flutter/material.dart';
import '../../../data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;
  final bool isSameUser;
  final Function(MessageModel) onTap;
  final Color primaryColor;
  
  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    this.isSameUser = false,
    required this.onTap,
    this.primaryColor = const Color(0xFF1CBF3F),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20);
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(isMe ? 20 : 0),
      topRight: Radius.circular(isMe ? 0 : 20),
      bottomLeft: radius.bottomLeft,
      bottomRight: radius.bottomRight,
    );

    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!isSameUser) const SizedBox(height: 10),
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe) _buildStatusIndicator(),
            Container(
              margin: EdgeInsets.only(
                top: 2,
                bottom: 2,
                left: isMe ? 70 : 10,
                right: isMe ? 10 : 70,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: isMe 
                    ? primaryColor 
                    : Colors.grey.shade200,
                borderRadius: borderRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onTap(message),
                  borderRadius: borderRadius,
                  splashColor: Colors.white.withOpacity(0.1),
                  child: message.type == MessageType.text
                      ? _buildTextMessage()
                      : _buildImageMessage(),
                ),
              ),
            ),
            if (isMe) _buildStatusIndicator(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: isMe ? 0 : 16,
            right: isMe ? 16 : 0,
            top: 2,
            bottom: 5,
          ),
          child: Text(
            message.formattedTime,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    if (!isMe) return const SizedBox(width: 4);
    
    IconData icon;
    Color color;
    
    switch (message.status) {
      case MessageStatus.sending:
        icon = Icons.access_time;
        color = Colors.grey;
        break;
      case MessageStatus.sent:
        icon = Icons.check;
        color = Colors.grey;
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all;
        color = Colors.grey;
        break;
      case MessageStatus.seen:
        icon = Icons.done_all;
        color = primaryColor;
        break;
      case MessageStatus.failed:
        icon = Icons.error_outline;
        color = Colors.red;
        break;
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 2, right: 2),
      child: Icon(
        icon,
        size: 16,
        color: color,
      ),
    );
  }

  Widget _buildTextMessage() {
    return Text(
      message.content,
      style: TextStyle(
        color: isMe ? Colors.white : Colors.black87,
        fontSize: 16,
      ),
    );
  }

  Widget _buildImageMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            message.content,
            height: 150,
            width: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 150,
                width: 200,
                color: Colors.grey.shade300,
                child: const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
