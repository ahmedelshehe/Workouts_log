
import 'package:hive/hive.dart';
import 'package:workout_log/data/hive/workout_exercise.dart';
part 'workout.g.dart';
@HiveType(typeId: 2)
class Workout{
  @HiveField(0)
  int id;
  @HiveField(1)
  String timeStamp;
  @HiveField(2)
  String name;
  @HiveField(3)
  List<WorkoutExercise> exercises;
  Workout({required this.id,required this.timeStamp ,required this.name,required,required this.exercises});
}