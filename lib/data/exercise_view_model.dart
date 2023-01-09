import 'package:workout_log/data/exercise.dart';

class ExerciseViewModel{
  final Muscles muscle;
  final List<Exercise> mainExercises;
  final List<Exercise> secondaryExercises;

  ExerciseViewModel(this.muscle, this.mainExercises, this.secondaryExercises);
}