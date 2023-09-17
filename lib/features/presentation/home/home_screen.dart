import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolistapp/features/presentation/home/home_app_bar.dart';
import 'package:todolistapp/features/presentation/widgets/custom_text_form_field.dart';
import 'package:todolistapp/shared/theme/app_colors.dart';
import 'package:todolistapp/shared/utils/app_assets.dart';
import 'package:todolistapp/shared/utils/font_manager.dart';
import 'package:todolistapp/shared/utils/size.dart';
import 'package:todolistapp/shared/utils/styles_manager.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  static const String routeName = '/homeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: homeAppBar(context, onPressed: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              controller: TextEditingController(),
              hintText: "Search for your task...",
              prefixIcon: SvgPicture.asset(AppAssets.search),
            ),
            20.height,
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 4,
                bottom: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  defaultText(
                    "Today",
                    fontSize: FontSize.thin,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  10.width,
                  SvgPicture.asset(AppAssets.arrowDown),
                ],
              ),
            ),
            16.height,
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 12,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.round),
                  12.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth / 1.5,
                        child: defaultText(
                          "Do Math Homework",
                          fontSize: FontSize.details,
                          color: Theme.of(context).colorScheme.secondary,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      6.height,
                      SizedBox(
                        width: screenWidth / 1.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            defaultText("Today At 16:45",
                                fontSize: FontSize.light,
                                color: Theme.of(context).colorScheme.onPrimary),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.mortarboard,
                                        width: 18,
                                        height: 18,
                                      ),
                                      5.width,
                                      defaultText(
                                        "University",
                                        fontSize: FontSize.thin,
                                        color: AppColors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                12.width,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssets.flag,
                                        width: 18,
                                        height: 18,
                                      ),
                                      5.width,
                                      defaultText(
                                        "1",
                                        fontSize: FontSize.thin,
                                        color: AppColors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            16.height,
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 4,
                bottom: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  defaultText(
                    "Completed",
                    fontSize: FontSize.thin,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  10.width,
                  SvgPicture.asset(AppAssets.arrowDown),
                ],
              ),
            ),
            16.height,
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 12,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.round),
                  12.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth / 1.5,
                        child: defaultText(
                          "Buy Grocery",
                          fontSize: FontSize.details,
                          color: Theme.of(context).colorScheme.secondary,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      6.height,
                      SizedBox(
                        width: screenWidth / 1.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            defaultText("Today At 16:45",
                                fontSize: FontSize.light,
                                color: Theme.of(context).colorScheme.onPrimary),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Column _noData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssets.checklist),
        10.height,
        defaultText(
          "What do you want to do today?",
          fontSize: FontSize.subTitle,
          color: Theme.of(context).colorScheme.secondary,
        ),
        Center(
          child: defaultText(
            "Tap + to add your tasks",
            fontSize: FontSize.details,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
