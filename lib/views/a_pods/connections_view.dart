import 'package:flutter/material.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/app_spacing.dart';
import 'package:wynante/custom_widget/home_widget/widget_conn_tile.dart';
import 'package:wynante/models/your_connection_model.dart';

class ConnectionsView extends StatelessWidget {
  const ConnectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data based on WidgetConnTile expectations
    final connections = [
      YourConnectionModel(
        name: "Jane Doe",
        date: "Connected 2 days ago",
        pic: "", // Empty for default asset
        status: "online",
        connectionType: "high",
        activity: "Professional",
      ),
      YourConnectionModel(
        name: "John Smith",
        date: "Connected 5 days ago",
        pic: "",
        status: "offline",
        connectionType: "medium",
        activity: "Social",
      ),
    ];

    return ListView.separated(
      padding: AppPadding.all16,
      itemCount: connections.length,
      separatorBuilder: (context, index) => AppSpacing.h16,
      itemBuilder: (context, index) {
        return WidgetConnTile(connection: connections[index]);
      },
    );
  }
}
