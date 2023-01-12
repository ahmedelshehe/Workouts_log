// ignore_for_file: unnecessary_import, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:workout_log/data/hive/workout.dart';
import '../../data/hive/exercise_set.dart';
import '../../data/hive/workout_exercise.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(WorkoutInitial());
  static WorkoutCubit get(context) => BlocProvider.of<WorkoutCubit>(context);
  List<WorkoutExercise> workoutExercises =[];
  List<Workout> workouts =[];
  var box=Hive.box('workouts');
  addExercise({required WorkoutExercise workoutExercise}){
    emit(WorkoutLoadingState());
    workoutExercises.add(workoutExercise);
    emit(ExerciseAddedState());
  }
  removeExercise({required WorkoutExercise workoutExercise}){
    emit(WorkoutLoadingState());
    workoutExercises.remove(workoutExercise);
    emit(ExerciseRemovedState());
  }
  addSetToExercise({required WorkoutExercise exercise,required ExerciseSet exerciseSet}){
    emit(WorkoutLoadingState());
    exercise.sets.add(exerciseSet);
    emit(ExerciseSetAdded());
  }
  addExerciseIntoCubit(List<WorkoutExercise> exercises){
    emit(WorkoutLoadingState());
    workoutExercises=exercises;
    emit(WorkoutDetailsScreenLoaded());
  }
  getWorkouts(){
    List data =box.get('workouts');
    workouts= data.map((e) => e as Workout).toList();
    workouts.sort((b, a) => a.id.compareTo(b.id),);
  }
  addWorkout(Workout workout){
    emit(WorkoutLoadingState());
    List dbWorkouts= box.get('workouts');
    dbWorkouts.add(workout);
    box.put('workouts', dbWorkouts);
    getWorkouts();
    emit(WorkoutAdded());
  }
  removeWorkout(Workout workout){
    emit(WorkoutLoadingState());
    List dbWorkouts= box.get('workouts');
    dbWorkouts.remove(workout);
    box.put('workouts', dbWorkouts);
    getWorkouts();
    emit(WorkoutRemoved());
  }
  clear(){
    workoutExercises =[];
  }

}
