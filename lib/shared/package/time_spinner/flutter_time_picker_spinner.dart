library time_picker_spinner;

import 'package:flutter/material.dart';
import 'package:todolistapp/features/presentation/widgets/button.dart';
import 'package:todolistapp/shared/theme/app_colors.dart';
import 'package:todolistapp/shared/utils/font_manager.dart';
import 'package:todolistapp/shared/utils/size.dart';
import 'dart:math';

import 'package:todolistapp/shared/utils/styles_manager.dart';

showTimePickerDialog(
  BuildContext context, {
  BorderRadius? borderRadius,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  Color? barrierColor = Colors.black54,
  bool useSafeArea = true,
  Color? dialogBackgroundColor,
  RouteSettings? routeSettings,
  String? barrierLabel,
  TransitionBuilder? builder,
  required Function() onPressedCancelButton,
  required Function(DateTime) onPressedOkButton,
}) {
  var dialog = Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    backgroundColor: dialogBackgroundColor ?? Theme.of(context).canvasColor,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(4),
    ),
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    clipBehavior: Clip.antiAlias,
    child: TimePickerSpinner(
      is24HourMode: true,
      normalTextStyle: TextStyle(
        fontSize: 18,
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.10),
      ),
      highlightedTextStyle: TextStyle(
        fontSize: 24,
        color: Theme.of(context).colorScheme.secondary,
      ),
      isForce2Digits: true,
      alignment: Alignment.center,
      onTimeChange: (time) {},
      onPressedCancelButton: onPressedCancelButton,
      onPressedOkButton: onPressedOkButton,
    ),
  );

  return showDialog(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
  );
}

class ItemScrollPhysics extends ScrollPhysics {
  /// Creates physics for snapping to item.
  /// Based on PageScrollPhysics
  final double? itemHeight;
  final double targetPixelsLimit;

  const ItemScrollPhysics({
    ScrollPhysics? parent,
    this.itemHeight,
    this.targetPixelsLimit = 3.0,
  })  : assert(itemHeight != null && itemHeight > 0),
        super(parent: parent);

  @override
  ItemScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ItemScrollPhysics(
        parent: buildParent(ancestor), itemHeight: itemHeight);
  }

  double _getItem(ScrollPosition position) {
    double maxScrollItem =
        (position.maxScrollExtent / itemHeight!).floorToDouble();
    return min(max(0, position.pixels / itemHeight!), maxScrollItem);
  }

  double _getPixels(ScrollPosition position, double item) {
    return item * itemHeight!;
  }

  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double item = _getItem(position);
    if (velocity < -tolerance.velocity) {
      item -= targetPixelsLimit;
    } else if (velocity > tolerance.velocity) {
      item += targetPixelsLimit;
    }
    return _getPixels(position, item.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a item boundary.
//    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
//        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
//      return super.createBallisticSimulation(position, velocity);
    // ignore: deprecated_member_use
    Tolerance tolerance = this.tolerance;
    final double target =
        _getTargetPixels(position as ScrollPosition, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

typedef SelectedIndexCallback = void Function(int);
typedef TimePickerCallback = void Function(DateTime);

class TimePickerSpinner extends StatefulWidget {
  final DateTime? time;
  final int minutesInterval;
  final int secondsInterval;
  final bool is24HourMode;
  final bool isShowSeconds;
  final TextStyle? highlightedTextStyle;
  final TextStyle? normalTextStyle;
  final double? itemHeight;
  final double? itemWidth;
  final AlignmentGeometry? alignment;
  final double? spacing;
  final bool isForce2Digits;
  final TimePickerCallback? onTimeChange;
  final Function() onPressedCancelButton;
  final Function(DateTime) onPressedOkButton;

  const TimePickerSpinner(
      {Key? key,
      this.time,
      this.minutesInterval = 1,
      this.secondsInterval = 1,
      this.is24HourMode = true,
      this.isShowSeconds = false,
      this.highlightedTextStyle,
      this.normalTextStyle,
      this.itemHeight,
      this.itemWidth,
      this.alignment,
      this.spacing,
      this.isForce2Digits = false,
      this.onTimeChange,
      required this.onPressedCancelButton,
      required this.onPressedOkButton})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TimePickerSpinnerState createState() => _TimePickerSpinnerState();
}

class _TimePickerSpinnerState extends State<TimePickerSpinner> {
  ScrollController hourController = ScrollController();
  ScrollController minuteController = ScrollController();
  ScrollController secondController = ScrollController();
  ScrollController apController = ScrollController();
  int currentSelectedHourIndex = -1;
  int currentSelectedMinuteIndex = -1;
  int currentSelectedSecondIndex = -1;
  int currentSelectedAPIndex = -1;
  DateTime? currentTime;
  bool isHourScrolling = false;
  bool isMinuteScrolling = false;
  bool isSecondsScrolling = false;
  bool isAPScrolling = false;

  /// default settings
  TextStyle defaultHighlightTextStyle = const TextStyle(
    fontSize: 32,
    color: Colors.black,
  );
  TextStyle defaultNormalTextStyle = const TextStyle(
    fontSize: 32,
    color: Colors.black54,
  );
  // double defaultItemHeight = 10;
  // double defaultItemWidth = 30;
  // double defaultSpacing = 20;
  double defaultItemHeight = 30;
  double defaultItemWidth = 40;
  double defaultSpacing = 20;
  AlignmentGeometry defaultAlignment = Alignment.centerRight;

  /// getter

  TextStyle? _getHighlightedTextStyle() {
    return widget.highlightedTextStyle ?? defaultHighlightTextStyle;
  }

  TextStyle? _getNormalTextStyle() {
    return widget.normalTextStyle ?? defaultNormalTextStyle;
  }

  int _getHourCount() {
    return widget.is24HourMode ? 24 : 12;
  }

  int _getMinuteCount() {
    return (60 / widget.minutesInterval).floor();
  }

  int _getSecondCount() {
    return (60 / widget.secondsInterval).floor();
  }

  double? _getItemHeight() {
    return widget.itemHeight ?? defaultItemHeight;
  }

  double? _getItemWidth() {
    return widget.itemWidth ?? defaultItemWidth;
  }

  double? _getSpacing() {
    return widget.spacing ?? defaultSpacing;
  }

  bool isLoop(int value) {
    return value > 10;
  }

  DateTime getDateTime() {
    int hour = currentSelectedHourIndex - _getHourCount();
    if (!widget.is24HourMode && currentSelectedAPIndex == 2) hour += 12;
    int minute = (currentSelectedMinuteIndex -
            (isLoop(_getMinuteCount()) ? _getMinuteCount() : 1)) *
        widget.minutesInterval;
    int second = (currentSelectedSecondIndex -
            (isLoop(_getSecondCount()) ? _getSecondCount() : 1)) *
        widget.secondsInterval;
    return DateTime(currentTime!.year, currentTime!.month, currentTime!.day + 1,
        hour + 1, minute, second);
  }

  @override
  void initState() {
    currentTime = widget.time ?? DateTime.now();

    currentSelectedHourIndex =
        (currentTime!.hour % (widget.is24HourMode ? 24 : 12)) + _getHourCount();
    hourController =
        ScrollController(initialScrollOffset: (currentSelectedHourIndex - 2));

    currentSelectedMinuteIndex =
        (currentTime!.minute / widget.minutesInterval).floor() +
            (isLoop(_getMinuteCount()) ? _getMinuteCount() : 1);
    minuteController =
        ScrollController(initialScrollOffset: (currentSelectedMinuteIndex - 2));
    //print(currentSelectedMinuteIndex);
    //print((currentSelectedMinuteIndex - 1) * _getItemHeight()!);

    currentSelectedSecondIndex =
        (currentTime!.second / widget.secondsInterval).floor() +
            (isLoop(_getSecondCount()) ? _getSecondCount() : 1);
    secondController = ScrollController(
        initialScrollOffset:
            (currentSelectedSecondIndex - 1) * _getItemHeight()!);

    currentSelectedAPIndex = currentTime!.hour >= 12 ? 2 : 1;
    apController = ScrollController(
        initialScrollOffset: (currentSelectedAPIndex - 1) * _getItemHeight()!);

    super.initState();

    if (widget.onTimeChange != null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => widget.onTimeChange!(getDateTime()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(minuteController.offset);
    List<Widget> contents = [
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF272727),
          borderRadius: BorderRadius.circular(4),
        ),
        width: _getItemWidth()! * 2,
        height: _getItemHeight()! * 3,
        child: spinner(
          hourController,
          _getHourCount(),
          currentSelectedHourIndex,
          isHourScrolling,
          1,
          (index) {
            currentSelectedHourIndex = index;
            isHourScrolling = true;
          },
          () => isHourScrolling = false,
        ),
      ),
      spacer(isTimeCenter: true),
      Container(
        decoration: const BoxDecoration(
          color: Color(0xFF272727),
        ),
        width: _getItemWidth()! * 2,
        height: _getItemHeight()! * 3,
        child: spinner(
            minuteController,
            _getMinuteCount(),
            currentSelectedMinuteIndex,
            isMinuteScrolling,
            widget.minutesInterval, (index) {
          currentSelectedMinuteIndex = index;
          isMinuteScrolling = true;
        }, () => isMinuteScrolling = false, isMinute: true),
      ),
    ];

    if (widget.isShowSeconds) {
      contents.add(spacer());
      contents.add(SizedBox(
        width: _getItemWidth(),
        height: _getItemHeight()! * 3,
        child: spinner(
          secondController,
          _getSecondCount(),
          currentSelectedSecondIndex,
          isSecondsScrolling,
          widget.secondsInterval,
          (index) {
            currentSelectedSecondIndex = index;
            isSecondsScrolling = true;
          },
          () => isSecondsScrolling = false,
        ),
      ));
    }

    if (!widget.is24HourMode) {
      contents.add(spacer());
      contents.add(Container(
        decoration: BoxDecoration(
          color: const Color(0xFF272727),
          borderRadius: BorderRadius.circular(4),
        ),
        width: _getItemWidth()! * 2,
        height: _getItemHeight()! * 3,
        child: apSpinner(),
      ));
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 10, left: 8, right: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          defaultText(
            "Choose Time",
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(color: AppColors.lightGrey),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: contents,
          ),
          21.height,
          Row(
            children: [
              _buildCancelButton(),
              5.width,
              _buildOkButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget spacer({bool isTimeCenter = false}) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 4),
      width: _getSpacing(),
      height: _getItemHeight()! * 3,
      child: isTimeCenter
          ? defaultText(
              ":",
              fontSize: FontSize.subTitle,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600,
            )
          : null,
    );
  }

  Widget spinner(
    ScrollController controller,
    int max,
    int selectedIndex,
    bool isScrolling,
    int interval,
    SelectedIndexCallback onUpdateSelectedIndex,
    VoidCallback onScrollEnd, {
    bool isMinute = false,
  }) {
    /// wrapping the spinner with stack and add container above it when it's scrolling
    /// this thing is to prevent an error causing by some weird stuff like this
    /// flutter: Another exception was thrown: 'package:flutter/src/widgets/scrollable.dart': Failed assertion: line 469 pos 12: '_hold == null || _drag == null': is not true.
    /// maybe later we can find out why this error is happening

    Widget spinner = NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is UserScrollNotification) {
          if (scrollNotification.direction.toString() ==
              "ScrollDirection.idle") {
            if (isLoop(max)) {
              int segment = (selectedIndex / max).floor();
              if (segment == 0) {
                onUpdateSelectedIndex(selectedIndex + max);
                controller.jumpTo(controller.offset + (_getItemHeight()! - 20));
              } else if (segment == 2) {
                onUpdateSelectedIndex(selectedIndex - max);
                controller.jumpTo(controller.offset - (_getItemHeight()! - 20));
              }
            }
            setState(() {
              onScrollEnd();
              if (widget.onTimeChange != null) {
                widget.onTimeChange!(getDateTime());
              }
            });
          }
        } else if (scrollNotification is ScrollUpdateNotification) {
          setState(() {
            onUpdateSelectedIndex(
                (controller.offset / _getItemHeight()!).round() + 1);
          });
        }
        return true;
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          String text = '';
          if (isLoop(max)) {
            text = ((index % max) * interval).toString();
          } else if (index != 0 && index != max + 1) {
            text = (((index - 1) % max) * interval).toString();
          }
          if (!widget.is24HourMode &&
              controller == hourController &&
              text == '0') {
            text = '12';
          }
          if (widget.isForce2Digits && text != '') {
            text = text.padLeft(2, '0');
          }
          return Container(
            alignment: Alignment.center,
            height: !isMinute ? 29.2 : 29.7,
            child: Text(
              text,
              style: selectedIndex == index
                  ? _getHighlightedTextStyle()
                  : _getNormalTextStyle(),
            ),
          );
        },
        controller: controller,
        itemCount: isLoop(max) ? max * 3 : max + 2,
        physics: ItemScrollPhysics(itemHeight: _getItemHeight()),
        padding: EdgeInsets.zero,
      ),
    );

    return spinner;
  }

  Widget apSpinner() {
    Widget spinner = NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is UserScrollNotification) {
          if (scrollNotification.direction.toString() ==
              "ScrollDirection.idle") {
            isAPScrolling = false;
            if (widget.onTimeChange != null) {
              widget.onTimeChange!(getDateTime());
            }
          }
        } else if (scrollNotification is ScrollUpdateNotification) {
          setState(() {
            currentSelectedAPIndex =
                (apController.offset / _getItemHeight()!).round() + 1;
            isAPScrolling = true;
          });
        }
        return true;
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          String text = index == 1 ? 'AM' : (index == 2 ? 'PM' : '');
          return Container(
            height: _getItemHeight(),
            alignment: Alignment.center,
            child: Text(
              text,
              style: currentSelectedAPIndex == index
                  ? _getHighlightedTextStyle()
                  : _getNormalTextStyle(),
            ),
          );
        },
        controller: apController,
        itemCount: 4,
        physics: ItemScrollPhysics(
          itemHeight: _getItemHeight(),
          targetPixelsLimit: 1,
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        Positioned.fill(child: spinner),
        isAPScrolling ? Positioned.fill(child: Container()) : Container()
      ],
    );
  }

  Widget _buildCancelButton() {
    return Flexible(
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.fromHeight(AppSize.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: widget.onPressedCancelButton,
        child: defaultText(
          "Cancel",
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _buildOkButton() {
    return Flexible(
      child: PrimaryButton(
        text: "Choose Time",
        maxWidth: true,
        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => widget.onPressedOkButton(getDateTime()));
        },
      ),
    );
  }


}
