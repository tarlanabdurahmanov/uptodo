import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/styles_manager.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String icon;
  final Function() onTap;
  final bool isTrailing;
  final Color? color;

  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isTrailing = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      onTap: onTap,
      leading: SvgPicture.asset(
        icon,
        // ignore: deprecated_member_use
        color: color ?? Theme.of(context).colorScheme.secondary,
      ),
      trailing: isTrailing
          ? SvgPicture.asset(
              AppAssets.arrowLeft,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.secondary,
            )
          : null,
      title: defaultText(
        title,
        color: color ?? Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
