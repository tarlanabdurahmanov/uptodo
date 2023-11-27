import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/size.dart';
import '../../../shared/utils/styles_manager.dart';

import '../../../../routes/app_route.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppRouter appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    // final user = ref.read(userProvider);

    // Future.delayed(const Duration(seconds: 1), () async {
    //   final route =
    //       user != null ? const MainRoute() : LoginRoute() as PageRouteInfo;
    //   // ignore: use_build_context_synchronously
    //   AutoRouter.of(context).pushAndPopUntil(
    //     route,
    //     predicate: (_) => false,
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.logo,
            width: 113,
            height: 113,
          ),
          19.height,
          Center(
            child: defaultText(
              "UpTodo",
              fontSize: 40,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
