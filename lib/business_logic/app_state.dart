part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class AppChangeBottomNavBarState extends AppState {}
class AppLoadingState extends AppState {}
class AssetsLoadedState extends AppState {}
class SearchingExerciseState extends AppState {}
class SearchResultsLoaded extends AppState {}
class SearchTermCleared extends AppState {}
class NoResultsFound extends AppState {}
