import 'package:flutter/material.dart';
import '../../flutter_event_calendar.dart';

class Event {
  late int listIndex;
  late Widget child;
  late CalendarDateTime dateTime;
  late Function? onTap;
  late Function? onLongPress;

  Event({
    required this.child,
    required this.dateTime,
    Function(int listIndex)? this.onTap,
    onLongPress,
  }) {
    this.onLongPress = onLongPress ??
        (int listIndex) {
          // ignore: avoid_print, prefer_interpolation_to_compose_strings
          print('LongPress ' + listIndex.toString());
        };
  }
}
