import 'package:flutter/material.dart';
import 'package:todolistapp/shared/theme/app_colors.dart';
import 'package:todolistapp/shared/utils/size.dart';
import 'package:todolistapp/shared/utils/styles_manager.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            decoration: const BoxDecoration(color: AppColors.lightGrey),
            height: 1,
          ),
        ),
        2.width,
        Center(
          child: SizedBox(
            height: 28,
            child: defaultText(
              "or",
              color: AppColors.lightGrey,
            ),
          ),
        ),
        2.width,
        Flexible(
          child: Container(
            decoration: const BoxDecoration(color: AppColors.lightGrey),
            height: 1,
          ),
        ),
      ],
    );
  }
}
