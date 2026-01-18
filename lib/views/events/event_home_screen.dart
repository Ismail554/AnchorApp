import 'package:flutter/material.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/font_manager.dart';
import 'package:wynante/models/event_model.dart';
import 'package:wynante/views/events/widgets/event_card.dart';
import 'package:wynante/views/events/create_event_screen.dart';

class EventHomeScreen extends StatefulWidget {
  const EventHomeScreen({super.key});

  @override
  State<EventHomeScreen> createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> {
  // Dummy Data
  final List<EventModel> _allEvents = [
    EventModel(
      id: '1',
      title: 'Morning Meditation & Mindfulness',
      description:
          'Start your day with a guided meditation session focused on mindfulness and inner peace.',
      imageUrl:
          'https://images.unsplash.com/photo-1544367563-12123d8959bd?q=80&w=2070&auto=format&fit=crop',
      category: 'Spiritual',
      date: DateTime(2024, 12, 10),
      startTime: const TimeOfDay(hour: 7, minute: 0),
      endTime: const TimeOfDay(hour: 8, minute: 0),
      location: 'Online',
      currentAttendees: 24,
      maxAttendees: 30,
      hostName: 'Sarah Johnson',
      isNew: true,
    ),
    EventModel(
      id: '2',
      title: 'Career Networking Mixer',
      description:
          'Connect with like-minded professionals and expand your network in a relaxed atmosphere.',
      imageUrl:
          'https://images.unsplash.com/photo-1511632765486-a319816ec914?q=80&w=2070&auto=format&fit=crop',
      category: 'Professional',
      date: DateTime(2024, 12, 12),
      startTime: const TimeOfDay(hour: 18, minute: 0),
      endTime: const TimeOfDay(hour: 20, minute: 0),
      location: 'San Francisco, CA',
      currentAttendees: 45,
      maxAttendees: 50,
      hostName: 'Michael Chen',
    ),
    EventModel(
      id: '3',
      title: 'Singles Meetup: Coffee & Conversations',
      description:
          'Casual meetup for singles looking to make meaningful romantic connections over coffee.',
      imageUrl:
          'https://images.unsplash.com/photo-1511923218551-71a745ad9464?q=80&w=2070&auto=format&fit=crop',
      category: 'Romantic',
      date: DateTime(2024, 12, 14),
      startTime: const TimeOfDay(hour: 16, minute: 0),
      endTime: const TimeOfDay(hour: 18, minute: 0),
      location: 'Blue Bottle Coffee, SF',
      currentAttendees: 18,
      maxAttendees: 25,
      hostName: 'Emma Davis',
      isNew: true,
    ),
  ];

  late List<EventModel> _upcomingEvents;
  late List<EventModel> _newEvents;

  @override
  void initState() {
    super.initState();
    _upcomingEvents = _allEvents
        .where((e) => e.date.isAfter(DateTime.now()))
        .toList();
    // For demo purposes, if upcoming is empty (because dates are in past), just show all
    if (_upcomingEvents.isEmpty) {
      _upcomingEvents = List.from(_allEvents);
    }
    _newEvents = _allEvents.where((e) => e.isNew).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.textPrimary,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Events',
            style: FontManager.heading2(color: AppColors.textPrimary),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: AppColors.primaryColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateEventScreen(),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primaryColor,
            labelStyle: FontManager.labelLarge(),
            tabs: const [
              Tab(text: 'All Events'),
              Tab(text: 'Upcoming'),
              Tab(text: 'New'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildEventList(_allEvents),
            _buildEventList(_upcomingEvents),
            _buildEventList(_newEvents),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList(List<EventModel> events) {
    if (events.isEmpty) {
      return Center(
        child: Text(
          "No events found",
          style: FontManager.bodyMedium(color: AppColors.textSecondary),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(AppPadding.p16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventCard(event: events[index]);
      },
    );
  }
}
