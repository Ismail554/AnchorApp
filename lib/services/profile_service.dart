import 'package:wynante/core/assets_manager.dart';
import 'package:wynante/models/user_profile_model.dart';

class ProfileService {
  Future<UserProfile> getUserProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return UserProfile(
      name: "John Doe",
      jobTitle: "UI/UX Designer",
      location: "San Francisco, CA",
      avatarUrl:
          ImageAssets.men1, // Assuming men1 is a good placeholder for avatar
      age: 28,
      completionPercentage: 75,
      connections: 24,
      aFoos: 45,
      checkIns: 156,
      rating: 4.9,
      galleryImages: [
        ImageAssets.frame1,
        ImageAssets.frame2,
        ImageAssets.frame3,
        ImageAssets.frame4,
      ],
      connectionTypes: ["Social", "Romantic", "Spiritual", "Professional"],
      aboutMe:
          "Passionate about personal growth, meaningful connections, and living life to the fullest. I believe in the power of authentic relationships and continuous learning.",
      interests: [
        "Meditation",
        "Yoga",
        "Reading",
        "Travel",
        "Photography",
        "Cooking",
        "Hiking",
      ],
      languages: ["English", "Spanish", "French"],
      gender: "Male",
      height: "5'10\"",
      education: "Bachelor's Degree",
      occupation: "Product Designer",
      lookingFor:
          "Seeking meaningful connections with people who value personal growth, authentic communication, and shared experiences.",
      userType: "Provider",
    );
  }
}
