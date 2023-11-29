import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/features/presentation/calendar/bloc/calendar_bloc.dart';
import 'package:todolistapp/features/presentation/home/home_screen.dart';
import 'package:todolistapp/features/presentation/widgets/button.dart';
import 'package:todolistapp/routes/app_route.dart';
import 'package:todolistapp/shared/utils/app_assets.dart';
import 'package:todolistapp/shared/utils/font_manager.dart';
import 'package:todolistapp/shared/utils/size.dart';
import 'package:todolistapp/shared/utils/styles_manager.dart';
import '../../../shared/package/event_calendar/flutter_event_calendar.dart';
import '../../../shared/theme/app_colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarEventModel calendarEventModel = CalendarEventModel(
    calendarLanguage: "en",
    calendarType: CalendarType.GREGORIAN,
    headerOptions: HeaderOptions(monthStringType: MonthStringTypes.FULL),
    calendarOptions: CalendarOptions(toggleViewType: false),
    dayOptions: DayOptions(),
    specialDays: [
      CalendarDateTime(
        year: 2023,
        month: 9,
        day: 20,
        calendarType: CalendarType.JALALI,
        color: Colors.indigo,
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: defaultText(
          "Calendar",
          color: Theme.of(context).colorScheme.secondary,
          fontSize: FontSize.subTitle,
        ),
      ),
      body: BlocConsumer<CalendarBloc, CalendarState>(
        listener: (context, state) {},
        builder: (context, state) {
          return EventCalendar(
            specialDays: calendarEventModel.specialDays,
            showLoadingForEvent: true,
            calendarType: calendarEventModel.calendarType,
            eventOptions: EventOptions(emptyText: "as"),
            // middleWidget: (CalendarDateTime calendarDateTime) {
            //   return Container(
            //     margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(4),
            //       color: const Color(0xFF4C4C4C),
            //     ),
            //     child: Row(
            //       children: [
            //         Flexible(
            //           child: PrimaryButton(
            //             maxWidth: true,
            //             text: "Today",
            //             onPressed: () {},
            //           ),
            //         ),
            //         32.width,
            //         Flexible(
            //           child: OutlineButton(
            //             text: "Completed",
            //             maxWidth: true,
            //             onPressed: () {},
            //             color: Theme.of(context).colorScheme.onSecondary,
            //           ),
            //         ),
            //       ],
            //     ),
            //   );
            // },
            calendarOptions: CalendarOptions(
              viewType: ViewType.DAILY,
              headerMonthShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              headerMonthBackColor: Theme.of(context).colorScheme.onBackground,
              headerMonthShadowColor: Colors.transparent,
            ),
            dayOptions: DayOptions(
              selectedBackgroundColor: Theme.of(context).colorScheme.primary,
              selectedTextColor: Theme.of(context).colorScheme.secondary,
              weekDaySelectedColor: Theme.of(context).colorScheme.secondary,
              weekDayUnselectedColor: Theme.of(context).colorScheme.secondary,
              eventCounterColor: Theme.of(context).colorScheme.secondary,
              unselectedTextColor: Theme.of(context).colorScheme.secondary,
              compactMode: true,
              disableFadeEffect: true,
              eventCounterViewType: DayEventCounterViewType.DOT,
            ),
            headerOptions: HeaderOptions(
              headerTextColor: Colors.white,
              navigationColor: Colors.white,
              monthStringType: calendarEventModel.headerOptions.monthStringType,
              weekDayStringType: WeekDayStringTypes.SHORT,
            ),
            events: [
              if (state is CalendarStateSuccess)
                for (int i = 0; i < state.todos!.length; i++)
                  fetchEvents(screenWidth, state.todos![i]),
            ],
          );
        },
      ),
    );
  }

  Event fetchEvents(double screenWidth, Todo todo) {
    return Event(
      child: GestureDetector(
        onTap: () {
          // AutoRouter.of(context).push( TaskRoute(todo: Todo(userId: "userId", id: 1, title: "title", description: "description", isCompleted: isCompleted, createdDate: createdDate, taskTime: taskTime)));
        },
        child: TodoItem(todo: todo),
      ),
      dateTime: todo.taskTime != ''
          ? CalendarDateTime(
              year: DateTime.parse(todo.taskTime!).year,
              month: DateTime.parse(todo.taskTime!).month,
              day: DateTime.parse(todo.taskTime!).day,
              calendarType: CalendarType.JALALI,
            )
          : CalendarDateTime(
              year: todo.createdDate.year,
              month: todo.createdDate.month,
              day: todo.createdDate.day,
              calendarType: CalendarType.JALALI,
            ),
    );
  }
}

// ignore: must_be_immutable
class CalendarEventModel extends Equatable {
  String calendarLanguage;
  CalendarType calendarType;
  CalendarOptions calendarOptions;
  HeaderOptions headerOptions;
  DayOptions dayOptions;
  List<CalendarDateTime> specialDays;
  CalendarEventModel({
    required this.calendarLanguage,
    required this.calendarType,
    required this.calendarOptions,
    required this.headerOptions,
    required this.dayOptions,
    required this.specialDays,
  });

  @override
  List<Object> get props => [specialDays];
}

class ExpandedItemModel {
  const ExpandedItemModel(
      {required this.title,
      required this.body,
      required this.icon,
      required this.definition});
  final String title;
  final String icon;
  final Widget body;
  final String definition;
}

class CalendarColorModel {
  String title;
  Color color;
  Widget body;
  CalendarColorModel(
      {required this.title, required this.color, required this.body});
}
