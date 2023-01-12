
import 'package:hive/hive.dart';
part 'exercise_set.g.dart';
@HiveType(typeId: 0)
class ExerciseSet{
  @HiveField(0)
  int id;
  @HiveField(1)
  int reps;
  @HiveField(2)
  double weight;
  ExerciseSet({required this.id,this.reps = 0,required this.weight});
}