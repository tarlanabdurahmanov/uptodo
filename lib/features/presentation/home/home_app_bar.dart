import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolistapp/shared/utils/app_assets.dart';
import 'package:todolistapp/shared/utils/font_manager.dart';
import 'package:todolistapp/shared/utils/styles_manager.dart';

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
