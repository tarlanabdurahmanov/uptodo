import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolistapp/core/widgets/app_snackbar.dart';
import 'package:todolistapp/features/providers/authentication/authentication_provider.dart';
import '../widgets/button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/or_divider.dart';
import '../../../routes/app_route.dart';
import '../../../shared/utils/app_assets.dart';
import '../../../shared/utils/font_manager.dart';
import '../../../shared/utils/size.dart';
import '../../../shared/utils/styles_manager.dart';

@RoutePage()
class RegisterScreen extends ConsumerWidget {
  static const routeName = '/registerScreen';

  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController usernameController =
      TextEditingController(text: 'kminchelle');
  final TextEditingController passwordController =
      TextEditingController(text: '0lelplR');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {
          appSnackBar(
            context,
            text: 'User Authenticated',
            type: AnimatedSnackBarType.success,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Authenticated'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        unauthenticated: (message) {
          appSnackBar(
            context,
            text: message.message.toString(),
            type: AnimatedSnackBarType.error,
          );
        },
      );
    });
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              defaultText(
                "Register",
                color: Theme.of(context).colorScheme.secondary,
                fontSize: FontSize.largeTitle,
                fontWeight: FontWeight.w700,
              ),
              23.height,
              defaultText(
                "Username",
                color: Theme.of(context).colorScheme.secondary,
              ),
              8.height,
              CustomTextFormField(
                controller: usernameController,
                hintText: "Enter your Username",
              ),
              25.height,
              defaultText(
                "Password",
                color: Theme.of(context).colorScheme.secondary,
              ),
              8.height,
              CustomTextFormField(
                obscureText: true,
                controller: passwordController,
                hintText: "••••••••••••",
              ),
              25.height,
              defaultText(
                "Confirm Password",
                color: Theme.of(context).colorScheme.secondary,
              ),
              8.height,
              CustomTextFormField(
                obscureText: true,
                controller: passwordController,
                hintText: "••••••••••••",
              ),
              40.height,
              PrimaryButton(
                text: "Register",
                isLoading: ref.watch(authNotifierProvider).maybeWhen(
                      orElse: () => false,
                      loading: () => true,
                    ),
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).signup(
                        email: usernameController.text,
                        password: passwordController.text,
                      );
                  // ref.read(authStateNotifierProvider.notifier).loginUser(
                  //       usernameController.text,
                  //       passwordController.text,
                  //     );
                },
                maxWidth: true,
              ),
              30.height,
              const OrDivider(),
              30.height,
              OutlineButton(
                hasIcon: true,
                text: "Login with Google",
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).continueWithGoogle();
                },
                maxWidth: true,
                icon: SvgPicture.asset(AppAssets.google),
              ),
              20.height,
              OutlineButton(
                hasIcon: true,
                text: "Login with Apple",
                onPressed: () {},
                maxWidth: true,
                icon: Image.asset(AppAssets.apple),
              ),
              const Spacer(),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontSize: FontSize.thin,
                        ),
                      ),
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: FontSize.thin,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AutoRouter.of(context).pushAndPopUntil(
                              LoginRoute(),
                              predicate: (_) => false,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              // AuthField(
              //   hintText: 'Username',
              //   controller: usernameController,
              // ),
              // AuthField(
              //   hintText: 'Password',
              //   obscureText: true,
              //   controller: passwordController,
              // ),
              // state.maybeMap(
              //   loading: (_) => const Center(child: CircularProgressIndicator()),
              //   orElse: () => loginButton(ref),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton(WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        // validate email and password
      },
      child: const Text('Login'),
    );
  }
}
