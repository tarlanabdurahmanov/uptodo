import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/button.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/font_manager.dart';
import '../../../../shared/utils/size.dart';
import '../../../../shared/utils/styles_manager.dart';

showCategoryDialog({
  required BuildContext context,
  required Size dialogSize,
  required Function(CategoryModel categoryModel) onChangeCategory,
  BorderRadius? borderRadius,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  Color? barrierColor = Colors.black54,
  bool useSafeArea = true,
  Color? dialogBackgroundColor,
  RouteSettings? routeSettings,
  String? barrierLabel,
  TransitionBuilder? builder,
}) {
  var dialog = Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    backgroundColor: dialogBackgroundColor ?? Theme.of(context).canvasColor,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(4),
    ),
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    clipBehavior: Clip.antiAlias,
    child: SizedBox(
      width: dialogSize.width,
      child: CategoryDialog(onChangeCategory: onChangeCategory),
    ),
  );

  return showDialog(
    context: context,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
  );
}

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({
    super.key,
    required this.onChangeCategory,
  });
  final Function(CategoryModel categoryModel) onChangeCategory;

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 6, top: 10, left: 8, right: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(AppSize.buttonBorderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          defaultText(
            "Choose Category",
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Divider(color: AppColors.lightGrey),
          ),
          22.height,
          Flexible(
            child: GridView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: categories.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index != 10) {
                  return _item(context, category: categories[index]);
                } else {
                  return _item(
                    context,
                    category: CategoryModel(
                      id: 11,
                      title: "Create New",
                      icon: AppAssets.addCateroy,
                      color: AppColors.categoryAdd,
                    ),
                  );
                }
              },
            ),
          ),
          _buildAddButton()
        ],
      ),
    );
  }

  Widget _item(BuildContext context, {required CategoryModel category}) {
    return Column(
      children: [
        Material(
          type: MaterialType.button,
          color: category.color,
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
              widget.onChangeCategory(category);
            },
            child: Container(
              height: 64,
              width: 64,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: SvgPicture.asset(category.icon),
            ),
          ),
        ),
        5.height,
        defaultText(
          category.title,
          color: Theme.of(context).colorScheme.secondary,
          fontSize: FontSize.light,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19, bottom: 11),
      child: PrimaryButton(
        text: "Add Category",
        maxWidth: true,
        onPressed: () {},
      ),
    );
  }
}

class CategoryModel {
  final int id;
  final String title;
  final String icon;
  final Color color;

  CategoryModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
  });
}

final categories = [
  CategoryModel(
    id: 1,
    title: "Grocery",
    icon: AppAssets.bread,
    color: AppColors.categoryColor1,
  ),
  CategoryModel(
    id: 2,
    title: "Work",
    icon: AppAssets.briefcase,
    color: AppColors.categoryColor2,
  ),
  CategoryModel(
    id: 3,
    title: "Sport",
    icon: AppAssets.sport,
    color: AppColors.categoryColor3,
  ),
  CategoryModel(
    id: 4,
    title: "Design",
    icon: AppAssets.design,
    color: AppColors.categoryColor4,
  ),
  CategoryModel(
    id: 5,
    title: "University",
    icon: AppAssets.mortarboard,
    color: AppColors.categoryColor5,
  ),
  CategoryModel(
    id: 6,
    title: "Social",
    icon: AppAssets.megaphone,
    color: AppColors.categoryColor6,
  ),
  CategoryModel(
    id: 7,
    title: "Music",
    icon: AppAssets.music,
    color: AppColors.categoryColor7,
  ),
  CategoryModel(
    id: 8,
    title: "Health",
    icon: AppAssets.heartbeat,
    color: AppColors.categoryColor8,
  ),
  CategoryModel(
    id: 9,
    title: "Movie",
    icon: AppAssets.videoCamera,
    color: AppColors.categoryColor9,
  ),
  CategoryModel(
    id: 10,
    title: "Home",
    icon: AppAssets.homeCateroy,
    color: AppColors.categoryColor10,
  ),
];
