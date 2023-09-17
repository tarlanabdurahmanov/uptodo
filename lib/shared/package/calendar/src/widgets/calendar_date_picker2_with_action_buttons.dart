import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/core/widgets/app_snackbar.dart';
import 'package:todolistapp/features/presentation/widgets/button.dart';
import 'package:todolistapp/shared/package/calendar/calendar_date_picker2.dart';
import 'package:todolistapp/shared/utils/size.dart';
import 'package:todolistapp/shared/utils/styles_manager.dart';

class CalendarDatePicker2WithActionButtons extends StatefulWidget {
  const CalendarDatePicker2WithActionButtons({
    required this.value,
    required this.config,
    this.onValueChanged,
    this.onDisplayedMonthChanged,
    this.onCancelTapped,
    this.onOkTapped,
    Key? key,
  }) : super(key: key);

  final List<DateTime?> value;

  /// Called when the user taps 'OK' button
  final ValueChanged<List<DateTime?>>? onValueChanged;

  /// Called when the user navigates to a new month/year in the picker.
  final ValueChanged<DateTime>? onDisplayedMonthChanged;

  /// The calendar configurations including action buttons
  final CalendarDatePicker2WithActionButtonsConfig config;

  /// The callback when cancel button is tapped
  final Function? onCancelTapped;

  /// The callback when ok button is tapped
  final Function? onOkTapped;

  @override
  State<CalendarDatePicker2WithActionButtons> createState() =>
      _CalendarDatePicker2WithActionButtonsState();
}

class _CalendarDatePicker2WithActionButtonsState
    extends State<CalendarDatePicker2WithActionButtons> {
  List<DateTime?> _values = [];
  List<DateTime?> _editCache = [];

  @override
  void initState() {
    _values = widget.value;
    _editCache = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(
      covariant CalendarDatePicker2WithActionButtons oldWidget) {
    var isValueSame = oldWidget.value.length == widget.value.length;

    if (isValueSame) {
      for (var i = 0; i < oldWidget.value.length; i++) {
        var isSame = (oldWidget.value[i] == null && widget.value[i] == null) ||
            DateUtils.isSameDay(oldWidget.value[i], widget.value[i]);
        if (!isSame) {
          isValueSame = false;
          break;
        }
      }
    }

    if (!isValueSame) {
      _values = widget.value;
      _editCache = widget.value;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 10, left: 10, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarDatePicker2(
            value: [..._editCache],
            config: widget.config,
            onValueChanged: (values) => _editCache = values,
            onDisplayedMonthChanged: widget.onDisplayedMonthChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCancelButton(Theme.of(context).colorScheme, localizations),
              if ((widget.config.gapBetweenCalendarAndButtons ?? 0) > 0)
                SizedBox(width: widget.config.gapBetweenCalendarAndButtons),
              _buildOkButton(Theme.of(context).colorScheme, localizations),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton(
      ColorScheme colorScheme, MaterialLocalizations localizations) {
    return Flexible(
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.fromHeight(AppSize.buttonHeight),
        ),
        onPressed: () {
          setState(() {
            _editCache = _values;
            widget.onCancelTapped?.call();
            if ((widget.config.openedFromDialog ?? false) &&
                (widget.config.closeDialogOnCancelTapped ?? true)) {
              Navigator.pop(context);
            }
          });
        },
        child: defaultText(
          "Cancel",
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _buildOkButton(
      ColorScheme colorScheme, MaterialLocalizations localizations) {
    return Flexible(
      child: PrimaryButton(
        text: "Choose Time",
        maxWidth: true,
        onPressed: () {
          setState(() {
            _values = _editCache;
            if (_values.isNotEmpty) {
              widget.onValueChanged?.call(_values);
              widget.onOkTapped?.call();
              if ((widget.config.openedFromDialog ?? false) &&
                  (widget.config.closeDialogOnOkTapped ?? true)) {
                Navigator.pop(context, _values);
              }
            } else {
              appSnackBar(context,
                  text: "Choose a day", type: AnimatedSnackBarType.error);
            }
          });
        },
      ),
    );
    // return InkWell(
    //   borderRadius: BorderRadius.circular(5),
    //   onTap: () => setState(() {
    //     _values = _editCache;
    //     widget.onValueChanged?.call(_values);
    //     widget.onOkTapped?.call();
    //     if ((widget.config.openedFromDialog ?? false) &&
    //         (widget.config.closeDialogOnOkTapped ?? true)) {
    //       Navigator.pop(context, _values);
    //     }
    //   }),
    //   child: Container(
    //     child: widget.config.okButton ??
    //         Text(
    //           localizations.okButtonLabel.toUpperCase(),
    //           style: widget.config.okButtonTextStyle ??
    //               TextStyle(
    //                 color: widget.config.selectedDayHighlightColor ??
    //                     colorScheme.primary,
    //                 fontWeight: FontWeight.w700,
    //                 fontSize: 14,
    //               ),
    //         ),
    //   ),
    // );
  }


}
