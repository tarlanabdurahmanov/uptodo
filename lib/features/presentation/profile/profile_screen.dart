import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_list_tile.dart';
import '../../../routes/app_route.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/font_manager.dart';
import '../../../shared/utils/size.dart';
import '../../../shared/utils/styles_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final firebaseProv = ref.watch(firebaseAuthProvider);
    // final userLocalRepositoryProviderProfile =
    //     ref.watch(userLocalRepositoryProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: defaultText(
          "Profile",
          fontSize: FontSize.subTitle,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(AppAssets.userPng),
                radius: 45,
              ),
            ),
            10.height,
            Center(
              child: defaultText(
                "Martha Hays",
                fontSize: FontSize.subTitle,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            20.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppSize.buttonBorderRadius),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      child: Center(
                        child: defaultText(
                          "10 Task left",
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  20.width,
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppSize.buttonBorderRadius),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      child: Center(
                        child: defaultText(
                          "5 Task done",
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            32.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: defaultText(
                "Settings",
                fontSize: FontSize.light,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            8.height,
            CustomListTile(
              title: "App Settings",
              icon: AppAssets.setting,
              onTap: () => AutoRouter.of(context).push(const SettingsRoute()),
            ),
            28.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: defaultText(
                "Account",
                fontSize: FontSize.light,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            8.height,
            CustomListTile(
              title: "Change account name",
              icon: AppAssets.user,
              onTap: () {},
            ),
            CustomListTile(
              title: "Change account password",
              icon: AppAssets.key,
              onTap: () {},
            ),
            CustomListTile(
              title: "Change account Image",
              icon: AppAssets.camera,
              onTap: () {},
            ),
            28.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: defaultText(
                "Uptodo",
                fontSize: FontSize.light,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            8.height,
            CustomListTile(
              title: "About US",
              icon: AppAssets.menu,
              onTap: () {},
            ),
            CustomListTile(
              title: "FAQ",
              icon: AppAssets.infoCircle,
              onTap: () {},
            ),
            CustomListTile(
              title: "Help & Feedback",
              icon: AppAssets.flash,
              onTap: () {},
            ),
            CustomListTile(
              title: "Support US",
              icon: AppAssets.like,
              onTap: () {},
            ),
            CustomListTile(
              title: "Log out",
              icon: AppAssets.logout,
              onTap: () async {
                // final logout =
                //     await userLocalRepositoryProviderProfile.deleteUser();

                // await firebaseProv.signOut();
                // if (logout) {
                // ignore: use_build_context_synchronously
                AutoRouter.of(context).pushAndPopUntil(
                  LoginRoute(),
                  predicate: (_) => false,
                );
                // }
              },
              isTrailing: false,
              color: Theme.of(context).colorScheme.error,
            ),
            50.height,
          ],
        ),
      ),
    );
  }
}
