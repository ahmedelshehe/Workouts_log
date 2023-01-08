import 'package:flutter/material.dart';
import 'package:workout_log/data/exercise.dart';
import 'package:workout_log/presentation/screens/exercises/muscles_exercises_screen.dart';

import '../../constants/screens.dart' as screens;
import '../screens/home_layout.dart';
class AppRouter{
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings){
    startScreen = const HomeLayout();

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => startScreen);
      case screens.homeLayout:
        return MaterialPageRoute(builder: (_) => const HomeLayout());
      case screens.musclesExercisesScreen:
        return MaterialPageRoute(builder: (_) => MusclesExercisesScreen(musclesExercises: settings.arguments as Map<Muscles,List<Exercise>> ));
    }
    return null;
  }

}
