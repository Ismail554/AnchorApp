import 'package:flutter/material.dart';
import 'package:wynante/core/font_manager.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Change Password", style: FontManager.heading3()),
        centerTitle: true,
      ),
    );
  }
}
