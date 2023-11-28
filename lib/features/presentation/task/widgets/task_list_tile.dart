import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../shared/utils/size.dart';
import '../../../../shared/utils/styles_manager.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.icon,
    required this.title,
    this.traling,
    this.onTap,
    this.color,
  });

  final String icon;
  final String title;
  final Widget? traling;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(icon, color: color),
      title: defaultText(
        title,
        color: color ?? Theme.of(context).colorScheme.secondary,
      ),
      onTap: onTap,
      horizontalTitleGap: 8,
      trailing: traling != null
          ? GestureDetector(
              onTap: onTap,
              child: Material(
                type: MaterialType.button,
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius),
                child: InkWell(
                  onTap: onTap,
                  borderRadius:
                      BorderRadius.circular(AppSize.buttonBorderRadius),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: traling,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
