import '../../../shared/utils/app_assets.dart';

class OnBoard {
  final String image;
  final String title;
  final String description;

  const OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final onboardList = [
  const OnBoard(
    image: AppAssets.onboarding1,
    title: "Manage your tasks",
    description:
        "You can easily manage all of your daily\ntasks in DoMe for free",
  ),
  const OnBoard(
    image: AppAssets.onboarding2,
    title: "Create daily routine",
    description:
        "In Uptodo  you can create your\npersonalized routine to stay productive",
  ),
  const OnBoard(
    image: AppAssets.onboarding3,
    title: "Orgonaize your tasks",
    description:
        "You can organize your daily tasks by\nadding your tasks into separate categories",
  ),
];
