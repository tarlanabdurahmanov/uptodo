import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolistapp/features/presentation/main/add_task_modal.dart';
import 'package:todolistapp/features/presentation/main/bottom_app_bar.dart';
import 'package:todolistapp/shared/theme/app_colors.dart';
import 'package:todolistapp/shared/utils/app_assets.dart';
import '../home/home_screen.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  static const String routeName = '/mainScreen';
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FilledButton(
        style: FilledButton.styleFrom(
          fixedSize: const Size.fromHeight(64),
          shape: const CircleBorder(),
        ),
        child: SvgPicture.asset(AppAssets.add),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return const AddTaskModal();
            },
          );
        },
      ),
      body: const [
        HomeScreen(),
        Placeholder(),
        HomeScreen(),
        HomeScreen(),
      ][selectedPageIndex],
      bottomNavigationBar: CustomBottomAppBar(
        items: [
          BottomAppBarItem(
            icon: SvgPicture.asset(AppAssets.home),
            activeIcon: SvgPicture.asset(AppAssets.homeFill),
            text: "Index",
          ),
          BottomAppBarItem(
            icon: SvgPicture.asset(AppAssets.calendar),
            activeIcon: SvgPicture.asset(AppAssets.calendarFill),
            text: "Calendar",
          ),
          BottomAppBarItem(
            icon: SvgPicture.asset(AppAssets.clock),
            activeIcon: SvgPicture.asset(AppAssets.clockFill),
            text: "Focus",
          ),
          BottomAppBarItem(
            icon: SvgPicture.asset(AppAssets.user),
            activeIcon: SvgPicture.asset(AppAssets.user),
            text: "Profile",
          ),
        ],
        centerItemText: "",
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        color: AppColors.white,
        selectedColor: AppColors.white,
        notchedShape: const AutomaticNotchedShape(
          LinearBorder(),
        ),
        onTabSelected: (int index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
      ),
    );
  }
}
