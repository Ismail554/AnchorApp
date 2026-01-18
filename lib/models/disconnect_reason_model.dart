class DisconnectCategory {
  final String title;
  final List<String> options;

  DisconnectCategory({required this.title, required this.options});
}

class DisconnectData {
  static List<DisconnectCategory> get categories => [
    DisconnectCategory(
      title: 'Mismatched connection',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    DisconnectCategory(
      title: 'Unresponsiveness of the user Negative behavior',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    DisconnectCategory(
      title: 'Negative behavior',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    DisconnectCategory(
      title: 'Offensive content',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    DisconnectCategory(
      title: 'Privacy concerns',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    DisconnectCategory(
      title: 'Not relevant anymore',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    DisconnectCategory(
      title: 'Personal conflict',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    DisconnectCategory(
      title: 'Setting boundaries',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    DisconnectCategory(
      title: 'Unrealistic expectations',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
    DisconnectCategory(
      title: 'Negative emotional triggers',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
    ),
  ];
}
