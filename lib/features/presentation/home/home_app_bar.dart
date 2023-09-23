import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/font_manager.dart';
import '../../../shared/utils/styles_manager.dart';

AppBar homeAppBar(
  BuildContext context, {
  required Function() onPressed,
}) {
  return AppBar(
    leading: IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(AppAssets.sort),
    ),
    title: defaultText(
      "Index",
      fontSize: FontSize.subTitle,
      color: Theme.of(context).colorScheme.secondary,
    ),
  );
}
