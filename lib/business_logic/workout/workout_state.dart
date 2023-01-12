part of 'workout_cubit.dart';

@immutable
abstract class WorkoutState {}

class WorkoutInitial extends WorkoutState {}
class WorkoutLoadingState extends WorkoutState {}
class ExerciseAddedState extends WorkoutState {}
class ExerciseSetAdded extends WorkoutState {}
class WorkoutAdded extends WorkoutState {}
class WorkoutDetailsScreenLoaded extends WorkoutState {}
class WorkoutRemoved extends WorkoutState {}
class ExerciseRemovedState extends WorkoutState {}
