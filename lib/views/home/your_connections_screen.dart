import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/custom_widget/mini_widget/widget_textfield.dart';
import 'package:wynante/models/your_connection_model.dart';
import 'package:wynante/custom_widget/home_widget/widget_conn_tile.dart';

class YourConnectionsScreen extends StatefulWidget {
  const YourConnectionsScreen({super.key});

  @override
  State<YourConnectionsScreen> createState() => _YourConnectionsScreenState();
}

class _YourConnectionsScreenState extends State<YourConnectionsScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<YourConnectionModel> _filteredConnections = [];

  @override
  void initState() {
    super.initState();
    _filteredConnections = YourConnectionModel.dummyData;
    _searchController.addListener(_filterConnections);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterConnections() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredConnections = YourConnectionModel.dummyData;
      } else {
        _filteredConnections = YourConnectionModel.dummyData.where((conn) {
          final name = conn.name.toLowerCase();
          return name.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Light grey background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FD),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Your Connections",
          style: FontManager.heading3(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppPadding.h24,

              child: WidgetTextfield(
                hintText: "Search name",
                controller: _searchController,
                prefixIcon: Icons.search,
                suffixIcon: Icons.tune, // Filter icon
                elevation: 0,
              ),
            ),
            AppSpacing.h16,
            Padding(
              padding: AppPadding.h24,
              child: Text(
                "List of Connections (${_filteredConnections.length})",
                style: FontManager.bodyMedium(color: AppColors.textPrimary),
              ),
            ),
            AppSpacing.h16,
            Expanded(
              child: ListView.separated(
                padding: AppPadding.h24,
                itemCount: _filteredConnections.length,
                separatorBuilder: (context, index) => AppSpacing.h10,
                itemBuilder: (context, index) {
                  final item = _filteredConnections[index];
                  return WidgetConnTile(connection: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
