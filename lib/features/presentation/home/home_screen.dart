import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/features/data/datasources/todo/todo_data_source.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/features/providers/todo/todo_provider.dart';
import 'home_app_bar.dart';
import '../widgets/custom_text_form_field.dart';
import '../../../routes/app_route.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/font_manager.dart';
import '../../../shared/utils/size.dart';
import '../../../shared/utils/styles_manager.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    final todoDataSource = ref.read(todoDataSourceProvider);
    todoDataSource.allTodos();
    super.initState();
    // Future.delayed(const Duration(seconds: 2)).then(
    //   (value) {
    //     final user = ref.read(userProvider);
    //     todoDataSource.insertTodo(
    //       todo: Todo(
    //           id: 1,
    //           userId: user!.uid,
    //           title: "hello world",
    //           description: " Fist description",
    //           isCompleted: true,
    //           createdDate: DateTime.now(),
    //           taskTime: DateTime.now()),
    //     );
    //   },
    // );
  }

  DateFormat dateFormat = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final todoNotifier = ref.watch(todoNotifierProvider);

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
            todoNotifier.when(
              allTodo: (data) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _item(context, screenWidth, data[index]);
                    },
                  ),
                );
              },
              error: (e) {
                return defaultText(e.message.toString(), color: Colors.red);
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              initial: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _item(BuildContext context, double screenWidth, Todo todo) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(TaskRoute(todo: todo));
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 12,
          bottom: 4,
        ),
        margin: const EdgeInsets.only(bottom: 10),
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
                    todo.title,
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
                      defaultText(
                        "Today at ${dateFormat.format(todo.createdDate)}",
                        fontSize: FontSize.light,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).colorScheme.primary,
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
                                color: Theme.of(context).colorScheme.primary,
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
