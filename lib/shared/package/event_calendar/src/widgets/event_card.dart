import 'package:flutter/material.dart';

import '../models/event.dart';

// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  Event fullCalendarEvent;

  EventCard({super.key, required this.fullCalendarEvent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        fullCalendarEvent.onTap?.call(fullCalendarEvent.listIndex);
      }),
      onLongPress: (() {
        fullCalendarEvent.onLongPress?.call(fullCalendarEvent.listIndex);
      }),
      child: fullCalendarEvent.child,
    );
  }
}
