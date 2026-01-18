class ChannelMember {
  final String id;
  final String name;
  final String role; // e.g., "Ui/Ux Designer", "Assistant manager"
  final String image;

  ChannelMember({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
  });
}
