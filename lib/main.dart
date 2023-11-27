import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/features/presentation/home/bloc/home_bloc.dart';
import 'package:todolistapp/firebase_options.dart';
import 'routes/app_route.dart';
import 'shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoHiveModelAdapter());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()..add(const HomeFetchEvent()),
        ),
      ],
      child: MaterialApp.router(
        title: 'UpTodo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        routeInformationParser: appRouter.defaultRouteParser(),
        routerDelegate: appRouter.delegate(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
