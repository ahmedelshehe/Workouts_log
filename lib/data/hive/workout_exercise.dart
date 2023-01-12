import 'package:hive/hive.dart';
import 'package:workout_log/data/hive/exercise_set.dart';
part 'workout_exercise.g.dart';
@HiveType(typeId: 1)
class WorkoutExercise{
  @HiveField(0)
  int id;
  @HiveField(1)
  int exerciseId;
  @HiveField(2)
  String exerciseName;
  @HiveField(3)
  String timeStamp;
  @HiveField(4)
  List<ExerciseSet> sets;
  WorkoutExercise({required this.id,required this.exerciseName,required this.exerciseId,required this.timeStamp,required this.sets});
}
