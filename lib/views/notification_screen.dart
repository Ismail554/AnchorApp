import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/font_manager.dart';

enum NotificationType { like, comment, connection, invite, pod, message }

class NotificationModel {
  final String id;
  final String userName;
  final String content;
  final String timeAgo;
  final NotificationType type;
  final bool isUnread;

  NotificationModel({
    required this.id,
    required this.userName,
    required this.content,
    required this.timeAgo,
    required this.type,
    this.isUnread = false,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      userName: 'Sarah Johnson',
      content: 'liked your post',
      timeAgo: '5m ago',
      type: NotificationType.like,
      isUnread: true,
    ),
    NotificationModel(
      id: '2',
      userName: 'Michael Chen',
      content: 'commented: "This is amazing! Would love to connect."',
      timeAgo: '15m ago',
      type: NotificationType.comment,
      isUnread: true,
    ),
    NotificationModel(
      id: '3',
      userName: 'Emily Rodriguez',
      content: 'accepted your connection request',
      timeAgo: '1h ago',
      type: NotificationType.connection,
      isUnread: true,
    ),
    NotificationModel(
      id: '4',
      userName: 'David Kim',
      content: 'invited you to "Mindfulness & Meditation Meetup"',
      timeAgo: '2h ago',
      type: NotificationType.invite,
      isUnread: false,
    ),
    NotificationModel(
      id: '5',
      userName: 'Jessica Martinez',
      content: 'started a new A-Pod "Tech Innovators Weekly"',
      timeAgo: '3h ago',
      type: NotificationType.pod,
      isUnread: false,
    ),
    NotificationModel(
      id: '6',
      userName: 'Alex Thompson',
      content: 'sent you a message',
      timeAgo: '5h ago',
      type: NotificationType.message,
      isUnread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Count unread notifications
    final int unreadCount = _notifications.where((n) => n.isUnread).length;

    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      appBar: AppBar(
        backgroundColor: AppColors.bgSecondary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notifications", style: FontManager.heading3()),
            if (unreadCount > 0)
              Text(
                "$unreadCount unread",
                style: FontManager.bodySmall(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              setState(() {
                for (var i = 0; i < _notifications.length; i++) {
                  _notifications[i] = NotificationModel(
                    id: _notifications[i].id,
                    userName: _notifications[i].userName,
                    content: _notifications[i].content,
                    timeAgo: _notifications[i].timeAgo,
                    type: _notifications[i].type,
                    isUnread: false,
                  );
                }
              });
            },
            icon: const Icon(
              Icons.check,
              size: 18,
              color: AppColors.primaryColor,
            ),
            label: Text(
              "Mark all read",
              style: FontManager.bodySmall(
                color: AppColors.primaryColor,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: ListView.separated(
        itemCount: _notifications.length,
        separatorBuilder: (context, index) =>
            const Divider(height: 1, color: AppColors.divider),
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _buildNotificationItem(notification);
        },
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return Container(
      color: notification.isUnread
          ? AppColors.primaryColor.withOpacity(0.1) // Light blue for unread
          : Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          _buildNotificationIcon(notification.type),
          SizedBox(width: 12.w),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: FontManager.bodyMedium(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: "${notification.userName} ",
                        style: FontManager.bodyMedium(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: notification.content),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  notification.timeAgo,
                  style: FontManager.bodySmall(
                    color: AppColors.textHint,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Actions Menu
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textHint),
            onSelected: (value) {
              if (value == 'read') {
                setState(() {
                  // Toggle read status for this example
                  final index = _notifications.indexWhere(
                    (n) => n.id == notification.id,
                  );
                  if (index != -1) {
                    _notifications[index] = NotificationModel(
                      id: notification.id,
                      userName: notification.userName,
                      content: notification.content,
                      timeAgo: notification.timeAgo,
                      type: notification.type,
                      isUnread: false,
                    );
                  }
                });
              } else if (value == 'delete') {
                setState(() {
                  _notifications.removeWhere((n) => n.id == notification.id);
                });
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'read',
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: 8.w),
                      const Text('Mark as read'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: AppColors.error,
                      ),
                      SizedBox(width: 8.w),
                      Text('Delete', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
              ];
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon(NotificationType type) {
    IconData iconData;
    Color iconColor;
    Color bgColor;

    switch (type) {
      case NotificationType.like:
        iconData = Icons.favorite_border;
        iconColor = AppColors.error;
        bgColor = AppColors.error.withOpacity(0.1);
        break;
      case NotificationType.comment:
        iconData = Icons.chat_bubble_outline;
        iconColor = AppColors.primaryColor;
        bgColor = AppColors.primaryColor.withOpacity(0.1);
        break;
      case NotificationType.connection:
        iconData = Icons.person_add_outlined;
        iconColor = AppColors.success;
        bgColor = AppColors.success.withOpacity(0.1);
        break;
      case NotificationType.invite:
        iconData = Icons.calendar_today_outlined;
        iconColor = Colors.purple;
        bgColor = Colors.purple.withOpacity(0.1);
        break;
      case NotificationType.pod:
        iconData = Icons.group_outlined; // Or similar pod icon
        iconColor = AppColors.warning;
        bgColor = AppColors.warning.withOpacity(0.1);
        break;
      case NotificationType.message:
        iconData = Icons.mail_outline;
        iconColor = AppColors.primaryColor;
        bgColor = AppColors.primaryColor.withOpacity(0.1);
        break;
    }

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        // If the design has colored backgrounds for icons significantly:
        // color: bgColor,
        // But the screenshot shows white circles with colored icons inside.
      ),
      child: Center(
        child: Container(
          // The screenshot actually shows the icon inside the circle might be just colored,
          // or the circle itself has a very faint tint.
          // Let's use the bgColor for the Icon itself if needed, or wrap the icon.
          // Looking closely at the image:
          // Heart is red in a white circle with maybe faint red border?
          // No, it looks like: White Circle with Shadow/Border, and the Icon is colored.
          // BUT, some might have colored bg.
          // Let's stick to White Circle + Colored Icon for now as per design "glance".
          // Actually, looking closer at the "Love" icon, it has a light red circle bg?
          // No, wait.
          // Row 1 (Heart): Red heart, white circle, maybe faint border.
          // Row 2 (Chat): Blue bubble, white circle.
          // Row 3 (Person): Green person, white circle.
          // All have a consistent style: White circle, gray border, colored icon.
          child: Icon(iconData, color: iconColor, size: 20.sp),
        ),
      ),
    );
  }
}
