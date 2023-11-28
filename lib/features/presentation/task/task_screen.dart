// ignore_for_file: must_be_immutable

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/core/enums/app_enums.dart';
import 'package:todolistapp/core/widgets/app_snackbar.dart';
import 'package:todolistapp/core/widgets/build_toast.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/features/domain/service/hive_service.dart';
import 'package:todolistapp/features/presentation/home/bloc/home_bloc.dart';
import 'package:todolistapp/features/presentation/main/widgets/category_dialog.dart';
import 'package:todolistapp/shared/theme/app_colors.dart';
import 'widgets/task_list_tile.dart';
import '../widgets/button.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/font_manager.dart';
import '../../../shared/utils/size.dart';
import '../../../shared/utils/styles_manager.dart';

@RoutePage()
class TaskScreen extends StatelessWidget {
  static const routeName = '/taskScreen';
  final Todo todo;

  TaskScreen({super.key, required this.todo});

  DateFormat dateFormat = DateFormat("MMMM d, HH:mm");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: Center(
          child: Material(
            type: MaterialType.button,
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () => AutoRouter.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SvgPicture.asset(AppAssets.x),
              ),
            ),
          ),
        ),
        actions: [
          Material(
            type: MaterialType.button,
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SvgPicture.asset(AppAssets.repeat),
              ),
            ),
          ),
          24.width,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(AppAssets.round),
                21.width,
                defaultText(
                  todo.title,
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: FontSize.subTitle,
                ),
                const Spacer(),
                SvgPicture.asset(AppAssets.edit),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: (61 - 24), top: 16, bottom: 38),
              child: defaultText(
                todo.description,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            TaskListTile(
              icon: AppAssets.timer,
              title: 'Created Time:',
              traling: defaultText(
                "Today at ${dateFormat.format(todo.createdDate)}",
                color: Theme.of(context).colorScheme.secondary,
                fontSize: FontSize.thin,
              ),
            ),
            if (todo.taskTime != '')
              TaskListTile(
                icon: AppAssets.timer,
                title: 'Task Time:',
                traling: defaultText(
                  "${dateFormat.format(DateTime.parse(todo.taskTime!))}",
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: FontSize.thin,
                ),
              ),
            if (todo.categoryId != null)
              TaskListTile(
                icon: AppAssets.tag,
                title: 'Task Category :',
                traling: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      categories
                          .where((element) => element.id == todo.categoryId)
                          .first
                          .icon,
                      width: 24,
                      height: 24,
                    ),
                    10.width,
                    defaultText(
                      categories
                          .where((element) => element.id == todo.categoryId)
                          .first
                          .title
                          .toString(),
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: FontSize.thin,
                    ),
                  ],
                ),
              ),
            TaskListTile(
              icon: AppAssets.flag,
              title: 'Task Priority :',
              traling: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.flag,
                    width: 18,
                    height: 18,
                  ),
                  5.width,
                  defaultText(
                    todo.priority.toString(),
                    fontSize: FontSize.thin,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            TaskListTile(
              icon: AppAssets.hierarchy,
              title: 'Sub - Task',
              traling: defaultText(
                "Add Sub - Task",
                color: Theme.of(context).colorScheme.secondary,
                fontSize: FontSize.thin,
              ),
              onTap: () {},
            ),
            TaskListTile(
              icon: AppAssets.trash,
              title: 'Delete Task',
              color: Theme.of(context).colorScheme.error,
              onTap: () {
                HiveService.getHive().deleteTodo(todo.id);
                BlocProvider.of<HomeBloc>(context).emit(HomeInitial());
                BlocProvider.of<HomeBloc>(context).add(HomeFetchEvent());
                Navigator.pop(context);
                appSnackBar(
                  context,
                  text: "Todo is deleted",
                  type: AnimatedSnackBarType.success,
                );
              },
            ),
            const Spacer(),
            PrimaryButton(
              text: "Edit Task",
              maxWidth: true,
              onPressed: () {},
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}
