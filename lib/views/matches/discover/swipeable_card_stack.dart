import 'package:flutter/material.dart';

import 'package:wynante/models/your_connection_model.dart';

import 'package:wynante/views/matches/discover/my_saved_screen.dart';
import 'package:wynante/views/matches/discover/discover_card.dart';
import 'package:wynante/views/matches/dislike_dialog.dart';
import 'package:wynante/core/font_manager.dart';

class SwipeableCardStack extends StatefulWidget {
  final List<YourConnectionModel> candidates;

  const SwipeableCardStack({super.key, required this.candidates});

  @override
  State<SwipeableCardStack> createState() => _SwipeableCardStackState();
}

class _SwipeableCardStackState extends State<SwipeableCardStack>
    with TickerProviderStateMixin {
  late List<YourConnectionModel> _cards;
  Offset _dragOffset = Offset.zero;
  int _currentIndex = 0;
  AnimationController? _slideOutAnimation;
  SlideTransition? _slideTransition;
  bool _isCardExpanded = false; // Track expansion state of top card

  @override
  void initState() {
    super.initState();
    _cards = List.from(widget.candidates);
  }

  @override
  void dispose() {
    _slideOutAnimation?.dispose();
    super.dispose();
  }

  void _removeCard(bool liked) {
    if (liked) {
      print("Liked ${_cards[_currentIndex].name}");
      _animateSlideOut(offset: const Offset(0, -1.5)); // Slide UP
    } else {
      print("Disliked ${_cards[_currentIndex].name}");
      _showDislikeDialog();
      // Don't auto slide out here, let dialog handle it via feedback UI
    }
  }

  void _animateSlideOut({required Offset offset}) {
    _slideOutAnimation = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Animation controller drives the slide out
    final _ = Tween<Offset>(begin: Offset.zero, end: offset).animate(
      CurvedAnimation(parent: _slideOutAnimation!, curve: Curves.easeOut),
    );

    _slideOutAnimation!.forward().then((_) {
      setState(() {
        if (_cards.isNotEmpty) {
          _cards.removeAt(0); // Remove visual card
        }
        _dragOffset = Offset.zero;
        _slideOutAnimation = null;
      });
    });
  }

  void _showDislikeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DislikeDialog(
        connection: _cards[_currentIndex],
        onSkip: () {
          Navigator.pop(context);
          _animateSlideOut(
            offset: const Offset(0, 1.5),
          ); // Slide Down after popup
        },
        onSubmit: (reason) {
          print("Disliked with reason: $reason");
          Navigator.pop(context);
          _animateSlideOut(
            offset: const Offset(0, 1.5),
          ); // Slide Down after popup
        },
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_dragOffset.dy < -100) {
      // Swiped Up (Like)
      _removeCard(true);
    } else if (_dragOffset.dy > 100) {
      // Swiped Down (Dislike)
      _removeCard(false);
    } else {
      // Reset
      setState(() {
        _dragOffset = Offset.zero;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cards.isEmpty) {
      // Per user request, show Saved Matches Screen when no more profiles
      return const MySavedScreen();
    }

    return Stack(
      alignment: Alignment.center,
      children: _cards
          .asMap()
          .entries
          .map((entry) {
            final index = entry.key;
            final card = entry.value;

            // Only render top 2 cards for performance
            if (index > 1) return const SizedBox.shrink();

            final isTopCard = index == 0;

            // Scale and Offset for depth effect
            final scale = isTopCard ? 1.0 : 0.95;
            final offset = isTopCard ? _dragOffset : const Offset(0, 20);

            Widget cardWidget = Transform.translate(
              offset: isTopCard && _slideOutAnimation != null
                  ? Offset(0, _slideOutAnimation!.value * 1000) // Animating out
                  : offset,
              child: Transform.scale(
                scale: scale,
                child: DiscoverCard(
                  connection: card,
                  // Only listen to expansion on the top card
                  isTopCard: isTopCard,
                  onExpandChange: isTopCard
                      ? () {
                          setState(() {
                            _isCardExpanded = !_isCardExpanded;
                          });
                        }
                      : null,
                ),
              ),
            );

            if (isTopCard) {
              // Always wrap top card to preserve state, but disable gestures when expanded or animating
              final bool canSwipe =
                  _slideOutAnimation == null && !_isCardExpanded;
              return GestureDetector(
                onPanUpdate: canSwipe ? _onPanUpdate : null,
                onPanEnd: canSwipe ? _onPanEnd : null,
                child: cardWidget,
              );
            }

            return cardWidget;
          })
          .toList()
          .reversed
          .toList(), // Reverse to put first item on top
    );
  }
}
