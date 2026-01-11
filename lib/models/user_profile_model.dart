class UserProfile {
  final String name;
  final String jobTitle;
  final String location;
  final String avatarUrl;
  final int age;
  final int completionPercentage;

  // Stats
  final int connections;
  final int aFoos;
  final int checkIns;
  final double rating;

  // Gallery
  final List<String> galleryImages;

  // Sections
  final List<String> connectionTypes;
  final String aboutMe;
  final List<String> interests;
  final List<String> languages;

  // Basic Info
  final String gender;
  final String height;
  final String education;
  final String occupation;

  final String lookingFor;
  final String userType; // "Provider" or "Seeker"

  UserProfile({
    required this.name,
    required this.jobTitle,
    required this.location,
    required this.avatarUrl,
    required this.age,
    required this.completionPercentage,
    required this.connections,
    required this.aFoos,
    required this.checkIns,
    required this.rating,
    required this.galleryImages,
    required this.connectionTypes,
    required this.aboutMe,
    required this.interests,
    required this.languages,
    required this.gender,
    required this.height,
    required this.education,
    required this.occupation,
    required this.lookingFor,
    required this.userType,
  });
}
