import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../data/models/onboard_model.dart';
import '../widgets/button.dart';
import '../../../routes/app_route.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/font_manager.dart';
import '../../../shared/utils/size.dart';
import '../../../shared/utils/styles_manager.dart';

@RoutePage()
class OnBoardingScreen extends StatefulWidget {
  static const routeName = '/onBoardingScreen';
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController imageController = PageController();
  PageController textController = PageController();
  var currentPageValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: 5,
        title: TextButton(
          onPressed: () => AutoRouter.of(context).push(const StartRoute()),
          child: defaultText(
            "SKIP",
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.44),
            fontSize: FontSize.details,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                itemCount: onboardList.length,
                onPageChanged: (page) {
                  setState(() {
                    currentPageValue = page;
                    textController.jumpToPage(page);
                  });
                },
                controller: imageController,
                itemBuilder: (context, index) {
                  return Image.asset(onboardList[index].image);
                },
              ),
            ),
            64.height,
            SmoothPageIndicator(
              controller: imageController,
              count: onboardList.length,
              effect: WormEffect(
                type: WormType.underground,
                radius: 56,
                spacing: 10,
                dotHeight: 4,
                dotWidth: 27,
                dotColor: AppColors.dotColor,
                activeDotColor: AppColors.white.withOpacity(0.87),
              ),
            ),
            50.height,
            Expanded(
              flex: 2,
              child: PageView.builder(
                controller: textController,
                itemCount: onboardList.length,
                onPageChanged: (page) {
                  setState(() {
                    currentPageValue = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      defaultText(
                        onboardList[index].title,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: FontSize.largeTitle,
                      ),
                      42.height,
                      defaultText(
                        onboardList[index].description,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: FontSize.details,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      imageController.animateToPage(
                        --currentPageValue,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: defaultText(
                      "BACK",
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.44),
                      fontSize: FontSize.details,
                    ),
                  ),
                  PrimaryButton(
                    text: currentPageValue != 2 ? "NEXT" : "GET STARTED",
                    onPressed: () {
                      if (currentPageValue != 2) {
                        imageController.animateToPage(
                          ++currentPageValue,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        AutoRouter.of(context).push(const StartRoute());
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
