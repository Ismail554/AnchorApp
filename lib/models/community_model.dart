import 'package:wynante/core/assets_manager.dart';

class CommunityPost {
  final String id;
  final String authorName;
  final String authorImage;
  final String timeAgo;
  final String category; // "Social", "Romantic", "Professional", "Spiritual"
  final String title;
  final String content;
  final String? imageAsset;
  final int likeCount;
  final int commentCount;
  bool isLiked;

  CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorImage,
    required this.timeAgo,
    required this.category,
    required this.title,
    required this.content,
    this.imageAsset,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isLiked = false,
  });

  static List<CommunityPost> dummyPosts = [
    CommunityPost(
      id: '1',
      authorName: 'Sarah Johnson',
      authorImage: 'assets/images/user1.png', // Placeholder
      timeAgo: '2 hours ago',
      category: 'Spiritual',
      title: '5 Morning Meditation Practices That Changed My Life',
      content:
          'Starting my day with these simple meditation techniques has completely transformed my mindset and energy...',
      imageAsset: ImageAssets.discoverImg1,
      likeCount: 45,
      commentCount: 12,
      isLiked: true,
    ),
    CommunityPost(
      id: '2',
      authorName: 'Michael Chen',
      authorImage: 'assets/images/user2.png', // Placeholder
      timeAgo: '4 hours ago',
      category: 'Career',
      title: 'How I Landed My Dream Job Through Networking',
      content:
          'Networking isn\'t just about collecting contacts - it\'s about building genuine relationships. Here is what worked for me...',
      likeCount: 128,
      commentCount: 34,
    ),
    CommunityPost(
      id: '3',
      authorName: 'Emma Davis',
      authorImage: 'assets/images/user3.png', // Placeholder
      timeAgo: '1 day ago',
      category: 'Romantic',
      title: 'The Importance of Communication in Relationships',
      content:
          'After 5 years together, I\'ve learned that the key to a healthy relationship is honest, open communication...',
      likeCount: 89,
      commentCount: 20,
    ),
  ];
}

class Comment {
  final String id;
  final String authorName;
  final String authorImage;
  final String timeAgo;
  final String content;
  final int likeCount;
  final int replyCount;

  Comment({
    required this.id,
    required this.authorName,
    required this.authorImage,
    required this.timeAgo,
    required this.content,
    this.likeCount = 0,
    this.replyCount = 0,
  });

  static List<Comment> dummyComments = [
    Comment(
      id: '1',
      authorName: 'Jane Doe',
      authorImage: 'assets/images/user4.png',
      timeAgo: '1 hour ago',
      content: 'This is amazing! Thanks for sharing.',
      likeCount: 5,
      replyCount: 1,
    ),
    Comment(
      id: '2',
      authorName: 'John Smith',
      authorImage: 'assets/images/user5.png',
      timeAgo: '30 mins ago',
      content: 'I completely agree with your points.',
      likeCount: 2,
    ),
  ];
}
