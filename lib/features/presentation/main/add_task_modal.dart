// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/features/domain/service/hive_service.dart';
import 'package:todolistapp/features/presentation/home/bloc/home_bloc.dart';
import 'package:todolistapp/features/presentation/main/widgets/category_dialog.dart';
import 'package:todolistapp/features/presentation/main/widgets/priority_dialog.dart';
import 'package:todolistapp/features/presentation/widgets/custom_text_form_field.dart';
import 'package:todolistapp/shared/package/calendar/calendar_date_picker2.dart';
import 'package:todolistapp/shared/package/time_spinner/flutter_time_picker_spinner.dart';
import 'package:todolistapp/shared/theme/app_colors.dart';
import 'package:todolistapp/shared/utils/app_assets.dart';
import 'package:todolistapp/shared/utils/font_manager.dart';
import 'package:todolistapp/shared/utils/size.dart';
import 'package:todolistapp/shared/utils/styles_manager.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  int selectedPriority = 0;
  int selectedCategory = 0;

  String calendarTime = "";

  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _descriptionEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  changePriority(int index) {
    setState(() {
      selectedPriority = index;
    });
    Navigator.pop(context);
  }

  changeCategory(CategoryModel categoryModel) {
    setState(() {
      selectedCategory = categoryModel.id;
    });
    // print("categoryModel -> ${categoryModel.id}");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultText(
            "Add Task",
            fontSize: FontSize.subTitle,
            color: Theme.of(context).colorScheme.secondary,
          ),
          14.height,
          CustomTextFormField(
            controller: _titleEditingController,
            hintText: "Add Task...",
          ),
          14.height,
          CustomTextFormField(
            controller: _descriptionEditingController,
            hintText: "Description",
            isBorderNone: true,
          ),
          35.height,
          Row(
            children: [
              _calendarDialogButton(),
              16.width,
              _categoryDialogButton(),
              16.width,
              _priorityDialogButton(),
              const Spacer(),
              GestureDetector(
                onTap: addToTask,
                child: SvgPicture.asset(AppAssets.send),
              ),
            ],
          )
        ],
      ),
    );
  }

  _calendarDialogButton() {
    final dayTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontWeight: FontWeight.w700,
      fontSize: FontSize.thin,
    );

    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.single,
      selectedDayHighlightColor: AppColors.primary,
      firstDayOfWeek: 0,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
      weekdayLabels: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"],
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),

      gapBetweenCalendarAndButtons: 0,
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      // dayTextStylePredicate: ({required date}) {
      //   TextStyle? textStyle;
      //   if (date.weekday == DateTime.saturday ||
      //       date.weekday == DateTime.sunday) {
      //     textStyle = weekendTextStyle;
      //   }
      //   if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
      //     textStyle = anniversaryTextStyle;
      //   }
      //   return textStyle;
      // },
    );
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () async {
          final values = await showCalendarDatePicker2Dialog(
            context: context,
            config: config,
            dialogSize: const Size.fromHeight(480),
            borderRadius: BorderRadius.circular(4),
            dialogBackgroundColor: Theme.of(context).colorScheme.onBackground,
          );
          if (values != null) {
            // print(_getValueText(
            //   config.calendarType,
            //   values,
            // ));

            showTimePickerDialog(
              context,
              onPressedCancelButton: () {},
              onPressedOkButton: (DateTime time) {
                calendarTime += "${_getValueText(
                  config.calendarType,
                  values,
                )} ${time.toString().split(" ")[1]}";
                Navigator.pop(context);
              },
            );
          }
        },
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(AppAssets.timer),
        ),
      ),
    );
  }

  _priorityDialogButton() {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          showPriorityDialog(
            context: context,
            dialogSize: const Size.fromHeight(480),
            onChangePriority: (index) => changePriority(index),
          );
        },
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(AppAssets.flag),
        ),
      ),
    );
  }

  _categoryDialogButton() {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          showCategoryDialog(
            context: context,
            dialogSize: const Size.fromHeight(480),
            onChangeCategory: (CategoryModel categoryModel) =>
                changeCategory(categoryModel),
          );
        },
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(AppAssets.tag),
        ),
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  void addToTask() async {
    var todoModel = TodoHiveModel(
      userId: "1",
      id: 1,
      title: _titleEditingController.text,
      description: _descriptionEditingController.text,
      isCompleted: false,
      createdDate: DateTime.now(),
      taskTime: DateTime.now(),
    );
    final response = await HiveService.getHive().addBoxes(todoModel, "todos");
    BlocProvider.of<HomeBloc>(context).emit(HomeInitial());
    BlocProvider.of<HomeBloc>(context).add(HomeFetchEvent());
  }
}
