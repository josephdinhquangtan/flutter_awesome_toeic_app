import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toeic_quiz2/core/constants/app_strings.dart';
import 'package:flutter_toeic_quiz2/core/themes/app_dark_theme.dart';
import 'package:flutter_toeic_quiz2/core/themes/app_light_theme.dart';
import 'package:flutter_toeic_quiz2/presentation/router/app_router.dart';
import 'package:flutter_toeic_quiz2/presentation/screens/execute_screen/part_three_screen/part_three_screen.dart';
import 'package:flutter_toeic_quiz2/presentation/screens/part_screen/part_screen.dart';
import 'package:flutter_toeic_quiz2/presentation/screens/test_screen/test_screen.dart';
import 'package:flutter_toeic_quiz2/utils/misc.dart';
import 'package:flutter_toeic_quiz2/view_model/home_screen_cubit/home_screen_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'data/data_source/hive_objects/book_hive_object/book_hive_object.dart';
import 'data/data_source/hive_objects/test_hive_object/test_hive_object.dart';
import 'presentation/screens/execute_screen/part_six_screen/part_six_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  if(kIsWeb) {
    await globalInitializerForWeb();
  } else {
    await globalInitializerForMobile();
  }
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeScreenCubit>(
      create: (context) =>
      HomeScreenCubit()
        ..changeTheme(ThemeMode.light),// need change follow data base
      child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          return MaterialApp(
              title: AppStrings.appTitle,
              theme: AppLightTheme.themeData,
              darkTheme: AppDarkTheme.themeData,
              debugShowCheckedModeBanner: false,
              themeMode: state is HomeScreenThemeModeChange ? state.themeMode : ThemeMode.light,
              initialRoute: AppRouter.home,
              onGenerateRoute: _appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}

Future<void> globalInitializerForWeb() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> globalInitializerForMobile() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  setApplicationDirectory(dir.path);
  Hive.init(dir.path);
  Hive.registerAdapter(BookHiveObjectAdapter());
  Hive.registerAdapter(TestHiveObjectAdapter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}