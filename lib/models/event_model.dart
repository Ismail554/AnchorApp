import 'package:flutter/material.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String location;
  final int currentAttendees;
  final int maxAttendees;
  final String hostName;
  final bool isNew;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.currentAttendees,
    required this.maxAttendees,
    required this.hostName,
    this.isNew = false,
  });
}
