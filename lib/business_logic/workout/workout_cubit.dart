import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/exercise_set.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(WorkoutInitial());
  static WorkoutCubit get(context) => BlocProvider.of<WorkoutCubit>(context);
  List<WorkoutExercise> workoutExercises =[];
  Map<WorkoutExercise,List<ExerciseSet>> workoutExercisesSets ={};
  bool canAdd=false;
  addExercise({required WorkoutExercise workoutExercise}){
    emit(WorkoutLoadingState());
    workoutExercises.add(workoutExercise);
    workoutExercisesSets[workoutExercise]=[];
    emit(ExerciseAddedState());
  }
  addSetToExercise({required WorkoutExercise exercise,required ExerciseSet exerciseSet}){
    emit(WorkoutLoadingState());
    workoutExercisesSets[exercise]?.add(exerciseSet);
    emit(ExerciseSetAdded());
  }
}
