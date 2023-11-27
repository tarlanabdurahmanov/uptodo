import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../calendar/calendar_screen.dart';
import 'add_task_modal.dart';
import 'bottom_app_bar.dart';
import '../profile/profile_screen.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/widgets/app_error.dart';
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
      body:  [
        HomeScreen(),
        CalendarScreen(),
        AppError(),
        ProfileScreen(),
      ][selectedPageIndex],
      bottomNavigationBar: CustomBottomAppBar(
        items: [
          BottomAppBarItem(
            icon: SvgPicture.asset(
              AppAssets.home,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.homeFill,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.secondary,
            ),
            text: "Index",
          ),
          BottomAppBarItem(
            icon: SvgPicture.asset(
              AppAssets.calendar,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.calendarFill,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.secondary,
            ),
            text: "Calendar",
          ),
          BottomAppBarItem(
            icon: SvgPicture.asset(
              AppAssets.clock,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.clockFill,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.secondary,
            ),
            text: "Focus",
          ),
          BottomAppBarItem(
            icon: SvgPicture.asset(
              AppAssets.user,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.user,
              // ignore: deprecated_member_use
              color: Theme.of(context).colorScheme.secondary,
            ),
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
