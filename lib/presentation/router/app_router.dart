import 'package:flutter/material.dart';
import 'package:workout_log/data/exercise.dart';
import 'package:workout_log/data/exercise_view_model.dart';
import 'package:workout_log/presentation/screens/exercises/exercise_details_screen.dart';
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
        return MaterialPageRoute(builder: (_) => MusclesExercisesScreen(model: settings.arguments as ExerciseViewModel ));
      case screens.exerciseDetailsScreen:
        return MaterialPageRoute(builder: (_) => ExerciseDetailsScreen(exercise: settings.arguments as Exercise ));
    }
    return null;
  }

}
