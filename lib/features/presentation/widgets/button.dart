import 'package:flutter/material.dart';
import 'package:todolistapp/shared/theme/app_colors.dart';
import 'package:todolistapp/shared/utils/font_manager.dart';
import 'package:todolistapp/shared/utils/size.dart';
import 'package:todolistapp/shared/utils/styles_manager.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool maxWidth;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.maxWidth = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius),
        ),
        minimumSize: maxWidth ? Size.fromHeight(AppSize.buttonHeight) : null,
      ),
      child: !isLoading
          ? defaultText(
              text,
              fontSize: FontSize.details,
              color: AppColors.white,
            )
          : const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2,
                strokeCap: StrokeCap.round,
              ),
            ),
    );
  }
}

class OutlineButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool maxWidth;
  final bool hasIcon;
  final Widget? icon;

  const OutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.maxWidth = false,
    this.hasIcon = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius),
        ),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        minimumSize: maxWidth ? Size.fromHeight(AppSize.buttonHeight) : null,
      ),
      child: !hasIcon
          ? defaultText(
              text,
              fontSize: FontSize.details,
              color: AppColors.white,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon!,
                10.width,
                defaultText(
                  text,
                  fontSize: FontSize.details,
                  color: AppColors.white,
                )
              ],
            ),
    );
  }
}
