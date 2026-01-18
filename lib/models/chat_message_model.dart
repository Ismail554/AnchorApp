class ChatMessage {
  final bool isMe;
  final String? message;
  final String time;
  final String type; // 'text' or 'image'
  final String? path;

  ChatMessage({
    required this.isMe,
    this.message,
    required this.time,
    this.type = 'text',
    this.path,
  });

  // Factory to create from Map (for backward compatibility during refactor if needed, or just cleaner init)
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      isMe: map['isMe'] as bool,
      message: map['message'] as String?,
      time: map['time'] as String,
      type: map['type'] as String? ?? 'text',
      path: map['path'] as String?,
    );
  }
}
