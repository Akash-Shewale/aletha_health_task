import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latest_check/repository/api_repository.dart';
import 'package:latest_check/utils/url_config.dart';

import 'bloc/exercise_details_bloc.dart';
import 'bloc/exercise_list_bloc.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});
  final ApiRepository _apiRepository = ApiRepository(url:'${UrlConfig.baseUrl}dev/workouts');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExerciseBloc>(
          create: (context) => ExerciseBloc(_apiRepository),
        ),
        BlocProvider<ExerciseDetailsBloc>(
          create: (context) => ExerciseDetailsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Aletha Health',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white), // Back arrow color
              titleTextStyle: TextStyle(
                color: Colors.white, // Text color
                fontSize: 20, // Customize as needed
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.blue, // AppBar background color
              elevation: 0, // Remove shadow if needed
            ),
            brightness: Brightness.light,
            primaryColor: Colors.blue,
            fontFamily: 'Roboto',
            colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.blue)),
        home: const MyHomePage(),
      ),
    );
  }
}
