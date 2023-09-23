import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_list_tile.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/font_manager.dart';
import '../../../shared/utils/size.dart';
import '../../../shared/utils/styles_manager.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  static const routeName = '/settingsScreen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: defaultText(
          "Settings",
          fontSize: FontSize.subTitle,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          19.height,
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
            title: "Change app color",
            icon: AppAssets.brush,
            onTap: () {},
          ),
          CustomListTile(
            title: "Change app typography",
            icon: AppAssets.text,
            onTap: () {},
          ),
          CustomListTile(
            title: "Change app language",
            icon: AppAssets.languageSquare,
            onTap: () {},
          ),
          16.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: defaultText(
              "Import",
              fontSize: FontSize.light,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          8.height,
          CustomListTile(
            title: "Import from Google calendar",
            icon: AppAssets.import,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
