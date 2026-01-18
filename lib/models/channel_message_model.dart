enum ChannelMessageType { text, post }

class ChannelMessage {
  final String id;
  final String senderName;
  final String senderImage;
  final String time;
  final String? title;
  final String content;
  final String? image;
  int likeCount;
  bool isLiked;
  final ChannelMessageType type;

  ChannelMessage({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.time,
    this.title,
    required this.content,
    this.image,
    this.likeCount = 0,
    this.isLiked = false,
    this.type = ChannelMessageType.text,
  });
}
