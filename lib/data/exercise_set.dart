class ExerciseSet{
    int id;
    int reps;
    double weight;
   ExerciseSet({required this.id,this.reps = 0,required this.weight});
}
class WorkoutExercise{
   int id;
   int exerciseId;
   String exerciseName;
   String timeStamp;
   WorkoutExercise({required this.id,required this.exerciseName,required this.exerciseId,required this.timeStamp});
}
class ExerciseSets{
   int id;
   int setId;
   int exerciseId;
   ExerciseSets({required this.id,required this.setId,required this.exerciseId});
}
class Workout{
   int id;
   String timeStamp;
   String name;
   Workout({required this.id,required this.timeStamp ,required this.name});
}
class WorkoutExercises{
   int id;
   int workoutId;
   int exerciseId;
   WorkoutExercises({required this.id,required this.workoutId,required this.exerciseId});
}