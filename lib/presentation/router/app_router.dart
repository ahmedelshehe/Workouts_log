import 'package:flutter/material.dart';
import 'package:workout_log/data/exercise.dart';
import 'package:workout_log/data/exercise_view_model.dart';
import 'package:workout_log/data/hive/workout.dart';
import 'package:workout_log/presentation/screens/exercises/exercise_details_screen.dart';
import 'package:workout_log/presentation/screens/exercises/muscles_exercises_screen.dart';
import 'package:workout_log/presentation/screens/workouts/add_workout.dart';
import 'package:workout_log/presentation/screens/workouts/workout_details.dart';

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
      case screens.addWorkoutScreen:
        return MaterialPageRoute(builder: (_)=> const AddWorkoutScreen());
      case screens.workoutDetailsScreen:
        return MaterialPageRoute(builder: (_)=>WorkoutDetailsScreen(workout: settings.arguments as Workout));
    }
    return null;
  }

}
