import 'package:wynante/core/assets_manager.dart';

class YourConnectionModel {
  final String name;
  final String pic;
  final String date;
  final String status;
  final String connectionType;
  final String activity;
  final int age;
  final String role;
  final String about;
  final List<String> galleryImages;
  final String gender;
  final String smoking;
  final String drinking;
  final String education;
  final String religion;
  final String familyType;
  final String origin;
  final List<String> interests;
  final List<String> languages;
  final List<PostModel> posts;
  final int? subscriberCount;

  YourConnectionModel({
    required this.name,
    required this.pic,
    required this.date,
    required this.status,
    required this.connectionType,
    required this.activity,
    this.age = 0,
    this.role = '',
    this.about = '',
    this.galleryImages = const [],
    this.gender = '',
    this.smoking = '',
    this.drinking = '',
    this.education = '',
    this.religion = '',
    this.familyType = '',
    this.origin = '',
    this.interests = const [],
    this.languages = const [],
    this.posts = const [],
    this.subscriberCount,
  });

  static List<YourConnectionModel> dummyData = [
    YourConnectionModel(
      name: "Ismail",
      pic: ImageAssets.men1,
      date: "Since 12 Jan 2025",
      status: "online",
      connectionType: "high",
      activity: "Professional",
      age: 42,
      role: "Flutter Expert",
      about:
          "Amazon Alexa Shopping is seeking a talented, experienced, and self-directed UX Designer to define and drive the future of shopping at Amazon. The ideal candidate is an end-to-end UX Designer with strong visual design skills. They are passionate and have experience designing for new and ambiguous technologies. They have proven ability to motivate through vision and a desire to inspire",
      galleryImages: [
        "assets/images/onboarding1.png",
        "assets/images/onboarding2.png",
        "assets/images/onboarding3.png",
        "assets/images/onboarding1.png",
      ],
      gender: "Man",
      smoking: "No",
      drinking: "No",
      education: "Undergraduate Degree",
      religion: "Muslim",
      familyType: "Family Nuclear",
      origin: "BD and IND",
      interests: ["Basket ball", "Gym", "Swimming", "Nutrition"],
      languages: ["English", "Bangla", "Hindi", "Urdu", "Arabic"],
      posts: [
        PostModel(
          authorName: "Ismail",
          authorPic: ImageAssets.men1,
          title: "My Career building process",
          content:
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
          likeCount: 100,
          commentCount: 44,
        ),
        PostModel(
          authorName: "Ismail",
          authorPic: ImageAssets.men1,
          title: "Flutter World",
          content:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
          likeCount: 250,
          commentCount: 12,
        ),
      ],
    ),
    YourConnectionModel(
      name: "Miles Esther",
      pic: ImageAssets.men2,
      date: "Since 15 Feb 2025",
      status: "online",
      connectionType: "medium",
      activity: "Romantic",
      age: 28,
      role: "Product Designer",
      about: "Passionate about creating intuitive user experiences.",
      gender: "Woman",
      interests: ["Art", "Travel", "Photography"],
      languages: ["English", "Spanish"],
      posts: [],
    ),
    YourConnectionModel(
      name: "Alex Johnson",
      pic: ImageAssets.men3,
      date: "Since 20 Mar 2025",
      status: "offline",
      connectionType: "low",
      activity: "Social",
      age: 30,
      role: "Software Engineer",
      about: "Tech enthusiast and coffee lover.",
      gender: "Man",
      interests: ["Coding", "Gaming", "Hiking"],
      languages: ["English", "French"],
      posts: [],
    ),
  ];
}

class PostModel {
  final String authorName;
  final String authorPic;
  final String title;
  final String content;
  int likeCount;
  final int commentCount;
  bool isLiked;

  PostModel({
    required this.authorName,
    required this.authorPic,
    required this.title,
    required this.content,
    required this.likeCount,
    required this.commentCount,
    this.isLiked = false,
  });
}
