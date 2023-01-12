// ignore_for_file: unnecessary_import

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:workout_log/presentation/screens/exercises/exercises_screen.dart';
import 'package:workout_log/presentation/screens/exercises/search_exercise_screen.dart';
import 'package:workout_log/presentation/screens/workouts/workouts_screen.dart';

import '../data/exercise.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  List<Widget> screens =[
   const ExercisesScreen(),
    const WorkoutsScreen(),
    const SearchExerciseScreen()
  ];
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  var currentIndex =0 ;
  String searchTerm="";
  List<String> screenTitles=[
    'Exercises','Workouts'
  ];
  List exercisesResults =[];
  List musclesResults =[];
  List<Exercise> exercises = [];
  List<Muscles> muscles =[];
  List<Exercise> searchResults =[];
  Map<Muscles,List<Exercise>> musclesExercise ={};
  Map<Muscles,List<Exercise>> secondaryMusclesExercise ={};
  Future<List<Exercise>> readJson() async{
    emit(AppLoadingState());
    final String exercisesJson =await rootBundle.loadString('assets/exercises.json');
    final String musclesJson =await rootBundle.loadString('assets/muscles.json');
    final exercisesData = await jsonDecode(exercisesJson);
    final musclesData =await jsonDecode(musclesJson);
    exercisesResults = exercisesData['results'];
    musclesResults = musclesData['results'];
    exercises =exercisesResults.map((e) => Exercise.fromJson(e)).toList();
    exercises =exercises.where((element) => (element.language?.id ==2 && element.description != '')).toList();
    exercises.sort((a, b) => b.images.length.compareTo(a.images.length),);
    muscles =musclesResults.map((e) => Muscles.fromJson(e)).toList();
    muscles.sort((a, b) => a.id.compareTo(b.id),);
    return exercises;
  }
  Future<void> exercisesToMap() async{
    musclesExercise ={};
    emit(AppLoadingState());
    for(Muscles muscle in muscles){
      musclesExercise[muscle] = exercises.where((element) {
        return ((element.muscles.isNotEmpty && (element.muscles.first.id == muscle.id))
            || ( element.muscles.length >= 2 && element.muscles.elementAt(1).id == muscle.id) ||
            (element.muscles.length >=3 && element.muscles.elementAt(2).id == muscle.id))  ;
      }).toList();
      secondaryMusclesExercise[muscle] = exercises.where((element) {
        return ((element.musclesSecondary.isNotEmpty && element.musclesSecondary.first.id ==muscle.id) ||
            (element.musclesSecondary.length >= 2 && element.musclesSecondary.elementAt(1).id == muscle.id) ||
            (element.musclesSecondary.length >= 3 && element.musclesSecondary.elementAt(2).id == muscle.id))  ;
      }).toList();
    }
    emit(AssetsLoadedState());
  }
  void changeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }
  void searchExercises(){
    emit(SearchingExerciseState());
    if(searchTerm.isEmpty){
      emit(SearchTermCleared());
    }else{
      searchResults =exercises.where((element) => element.name.toLowerCase().contains(searchTerm.toLowerCase())).toList();
      if(searchResults.isEmpty){
        emit(NoResultsFound());
      }else{
        emit(SearchResultsLoaded());
      }

    }

  }
}
