part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class AppChangeBottomNavBarState extends AppState {}
class AppLoadingState extends AppState {}
class AssetsLoadedState extends AppState {}
