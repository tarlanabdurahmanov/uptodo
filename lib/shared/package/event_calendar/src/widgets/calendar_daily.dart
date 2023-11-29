// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../flutter_event_calendar.dart';
import '../handlers/calendar_utils.dart';

import '../handlers/event_selector.dart';

import '../utils/style_provider.dart';
import 'day.dart';

// ignore: must_be_immutable
class CalendarDaily extends StatelessWidget {
  Function? onCalendarChanged;
  var dayIndex;
  late ScrollController animatedTo;
  EventSelector selector = EventSelector();
  List<CalendarDateTime> specialDays;

  CalendarDaily({
    super.key,
    this.onCalendarChanged,
    required this.specialDays,
  }) {
    dayIndex = CalendarUtils.getPartByInt(format: PartFormat.DAY);
  }

  @override
  Widget build(BuildContext context) {
    animatedTo = ScrollController(
        initialScrollOffset: (DayOptions.of(context).compactMode
                ? 40.0
                : (HeaderOptions.of(context).weekDayStringType ==
                        WeekDayStringTypes.FULL
                    ? 80.0
                    : 60.0)) *
            (dayIndex - 1));

    executeAsync(context);
    // Yearly , Monthly , Weekly and Daily calendar
    return SizedBox(
      height: DayOptions.of(context).showWeekDay
          ? DayOptions.of(context).compactMode
              ? 80
              : 100
          : 70,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        reverse: EventCalendar.calendarProvider.isRTL(),
        controller: animatedTo,
        scrollDirection: Axis.horizontal,
        children: daysMaker(context),
      ),
    );
  }

  List<Widget> daysMaker(BuildContext context) {
    int currentMonth = CalendarUtils.getPartByInt(format: PartFormat.MONTH);
    int currentYear = CalendarUtils.getPartByInt(format: PartFormat.YEAR);

    final headersStyle = HeaderOptions.of(context);

    List<Widget> days = [
      SizedBox(
          width: DayOptions.of(context).compactMode
              ? 40
              : headersStyle.weekDayStringType == WeekDayStringTypes.FULL
                  ? 80
                  : 60)
    ];

    int day = dayIndex;
    CalendarUtils.getDays(headersStyle.weekDayStringType, currentMonth)
        .forEach((index, weekDay) {
      final CalendarDateTime? specialDay = CalendarUtils.getFromSpecialDay(
          specialDays, currentYear, currentMonth, index);

      BoxDecoration? decoration = StyleProvider.getSpecialDayDecoration(
          specialDay, currentYear, currentMonth, index);

      var selected = index == day;

      bool isBeforeToday =
          CalendarUtils.isBeforeThanToday(currentYear, currentMonth, index);

      days.add(Day(
        day: index,
        dayEvents: selector.getEventsByDayMonthYear(
          CalendarDateTime(
            year: currentYear,
            month: currentMonth,
            day: index,
            calendarType: CalendarUtils.getCalendarType(),
          ),
        ),
        dayStyle: DayStyle(
          compactMode: DayOptions.of(context).compactMode,
          decoration: decoration,
          enabled: (specialDay?.isEnableDay ?? true),
          selected: selected,
          useUnselectedEffect: false,
          useDisabledEffect: DayOptions.of(context).disableDaysBeforeNow
              ? isBeforeToday
              : false,
        ),
        weekDay: weekDay,
        onCalendarChanged: () {
          CalendarUtils.goToDay(index);
          onCalendarChanged?.call();
        },
      ));
    });

    days.add(
      SizedBox(
        width: DayOptions.of(context).compactMode
            ? 40
            : headersStyle.weekDayStringType == WeekDayStringTypes.FULL
                ? 80
                : 60,
      ),
    );

    return days;
  }

  void executeAsync(context) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (animatedTo.hasClients) {
        final animateOffset = 50.0 * (dayIndex - 1);
        animatedTo.animateTo(animateOffset,
            duration: const Duration(milliseconds: 700),
            curve: Curves.decelerate);
      }
    });
  }
}
