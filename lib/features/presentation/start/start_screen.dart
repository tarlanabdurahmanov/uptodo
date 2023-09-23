import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../../../shared/utils/font_manager.dart';
import '../../../shared/utils/size.dart';
import '../../../shared/utils/styles_manager.dart';

@RoutePage()
class StartScreen extends StatelessWidget {
  static const routeName = '/startScreen';
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              58.height,
              defaultText(
                "Welcome to UpTodo",
                fontSize: FontSize.largeTitle,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.secondary,
              ),
              defaultText(
                "Please login to your account or create\nnew account to continue",
                fontSize: FontSize.details,
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.67),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              PrimaryButton(
                maxWidth: true,
                text: "LOGIN",
                onPressed: () {},
              ),
              28.height,
              OutlineButton(
                maxWidth: true,
                text: "CREAT ACCOUNT",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
