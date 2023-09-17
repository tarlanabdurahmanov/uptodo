import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolistapp/features/presentation/widgets/button.dart';
import 'package:todolistapp/shared/theme/app_colors.dart';
import 'package:todolistapp/shared/utils/app_assets.dart';
import 'package:todolistapp/shared/utils/size.dart';
import 'package:todolistapp/shared/utils/styles_manager.dart';

showPriorityDialog({
  required BuildContext context,
  required Size dialogSize,
  required Function(int index) onChangePriority,
  BorderRadius? borderRadius,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  Color? barrierColor = Colors.black54,
  bool useSafeArea = true,
  Color? dialogBackgroundColor,
  RouteSettings? routeSettings,
  String? barrierLabel,
  TransitionBuilder? builder,
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
    child: SizedBox(
      width: dialogSize.width,
      child: PriorityDialog(
        onChangePriority: onChangePriority,
      ),
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

class PriorityDialog extends StatefulWidget {
  const PriorityDialog({
    super.key,
    required this.onChangePriority,
  });
  final Function(int index) onChangePriority;

  @override
  State<PriorityDialog> createState() => _PriorityDialogState();
}

class _PriorityDialogState extends State<PriorityDialog> {
  int isSelectedIndex = 0;

  changeSelectedIndex(int index) {
    setState(() {
      isSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            "Task Priority",
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Divider(color: AppColors.lightGrey),
          ),
          22.height,
          Wrap(
            runSpacing: 16,
            spacing: 16,
            children: [
              ...List.generate(
                10,
                (index) {
                  return _item(
                    context,
                    isSelected: index == isSelectedIndex,
                    title: (index + 1).toString(),
                    index: index,
                  );
                },
              ),
            ],
          ),
          30.height,
          Row(
            children: [
              _buildCancelButton(context),
              5.width,
              _buildSaveButton(context),
            ],
          )
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    bool isSelected = false,
    required String title,
    required int index,
  }) {
    return Material(
      type: MaterialType.button,
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : AppColors.thinBlack,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        borderRadius: BorderRadius.circular(10),
        onTap: () => changeSelectedIndex(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppAssets.flag),
              5.height,
              defaultText(
                title,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(context) {
    return Flexible(
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.fromHeight(AppSize.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: () {},
        child: defaultText(
          "Cancel",
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _buildSaveButton(context) {
    return Flexible(
      child: PrimaryButton(
        text: "Save",
        maxWidth: true,
        onPressed: () => widget.onChangePriority(isSelectedIndex),
      ),
    );
  }
}
