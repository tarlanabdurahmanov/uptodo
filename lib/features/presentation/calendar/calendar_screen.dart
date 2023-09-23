import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
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
  StreamController<CalendarEventModel> streamController =
      StreamController.broadcast();
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
    streamController.stream.listen((event) {
      calendarEventModel = event;
    });
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
      body: EventCalendar(
        specialDays: calendarEventModel.specialDays,
        showLoadingForEvent: true,
        calendarType: calendarEventModel.calendarType,
        eventOptions: EventOptions(emptyText: "as"),
        middleWidget: (CalendarDateTime calendarDateTime) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xFF4C4C4C),
            ),
            child: Row(
              children: [
                Flexible(
                  child: PrimaryButton(
                    maxWidth: true,
                    text: "Today",
                    onPressed: () {},
                  ),
                ),
                32.width,
                Flexible(
                  child: OutlineButton(
                    text: "Completed",
                    maxWidth: true,
                    onPressed: () {},
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          );
        },
        calendarOptions: CalendarOptions(
          viewType: ViewType.DAILY,
          headerMonthShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
          Event(
            child: GestureDetector(
              onTap: () {
                // AutoRouter.of(context).push( TaskRoute(todo: Todo(userId: "userId", id: 1, title: "title", description: "description", isCompleted: isCompleted, createdDate: createdDate, taskTime: taskTime)));
              },
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 12,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.round),
                    12.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth / 1.5,
                          child: defaultText(
                            "Do Math Homework",
                            fontSize: FontSize.details,
                            color: Theme.of(context).colorScheme.secondary,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        6.height,
                        SizedBox(
                          width: screenWidth / 1.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              defaultText("Today At 16:45",
                                  fontSize: FontSize.light,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.mortarboard,
                                          width: 18,
                                          height: 18,
                                        ),
                                        5.width,
                                        defaultText(
                                          "University",
                                          fontSize: FontSize.thin,
                                          color: AppColors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  12.width,
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.flag,
                                          width: 18,
                                          height: 18,
                                        ),
                                        5.width,
                                        defaultText(
                                          "1",
                                          fontSize: FontSize.thin,
                                          color: AppColors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            dateTime: CalendarDateTime(
              year: 2023,
              month: 9,
              day: 15,
              calendarType: CalendarType.JALALI,
            ),
          ),
        ],
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
