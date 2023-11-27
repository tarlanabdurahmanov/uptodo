import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'test_styles.dart';
import 'text_theme.dart';

// final appThemeProvider = StateNotifierProvider<AppThemeModeNotifier, ThemeMode>(
//   (ref) {
//     final storage = ref.watch(storageServiceProvider);
//     return AppThemeModeNotifier(storage);
//   },
// );

// class AppThemeModeNotifier extends StateNotifier<ThemeMode> {
//   final StroageService stroageService;

//   ThemeMode currentTheme = ThemeMode.dark;

//   AppThemeModeNotifier(this.stroageService) : super(ThemeMode.dark) {
//     getCurrentTheme();
//   }

//   void toggleTheme() {
//     // state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
//     // stroageService.set(APP_THEME_STORAGE_KEY, state.name);
//   }

//   void getCurrentTheme() async {
//     // final theme = await stroageService.get(APP_THEME_STORAGE_KEY);
//     // ignore: unnecessary_string_interpolations
//     // final value = ThemeMode.values.byName('${'dark'}');
//     // final value = ThemeMode.values.byName('${'light' ?? 'light'}');
//     // state = value;
//   }
// }

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.secondaryGrey,
        onBackground: AppColors.secondaryBlack,
        onSecondary: AppColors.lightGrey,
        onSurface: AppColors.lightBlack,
        secondary: AppColors.white,
        error: AppColors.error,
        background: AppColors.black,
        onSecondaryContainer: AppColors.grey,
        onInverseSurface: Color(0xFF272727),
      ),
      // backgroundColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.black,
        titleTextStyle: AppTextStyles.h2,
        iconTheme: IconThemeData(
          color: AppColors.white,
        ),
      ),
    );
  }

  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.black,
        error: AppColors.error,
        onPrimary: AppColors.secondaryGrey,
        onBackground: AppColors.extraLightGrey,
        onSecondary: AppColors.lightGrey,
        onSurface: AppColors.lightBlack,
        onSecondaryContainer: AppColors.grey,
        onInverseSurface: Color(0xFF272727),
        background: AppColors.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.white,
        // iconTheme: IconThemeData(
        //   color: AppColors.black,
        // ),
      ),
    );
  }
}
