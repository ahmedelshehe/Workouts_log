import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:workout_log/presentation/screens/exercises/exercises_screen.dart';
import 'package:workout_log/presentation/screens/workouts/workouts_screen.dart';

import '../data/exercise.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  List<Widget> screens =[
   const ExercisesScreen(),
    const WorkoutsScreen()
  ];
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  var currentIndex =0 ;
  List<String> screenTitles=[
    'Exercises','Workouts'
  ];
  List exercisesResults =[];
  List musclesResults =[];
  List<Exercise> exercises = [];
  List<Muscles> muscles =[];
  Map<Muscles,List<Exercise>> musclesExercise ={};
  Future<List<Exercise>> readJson() async{
    emit(AppLoadingState());
    final String exercisesJson =await rootBundle.loadString('assets/exercises.json');
    final String musclesJson =await rootBundle.loadString('assets/muscles.json');
    final exercisesData = await jsonDecode(exercisesJson);
    final musclesData =await jsonDecode(musclesJson);
    exercisesResults = exercisesData['results'];
    musclesResults = musclesData['results'];
    exercises =exercisesResults.map((e) => Exercise.fromJson(e)).toList();
    exercises =exercises.where((element) => element.language?.id ==2).toList();
    muscles =musclesResults.map((e) => Muscles.fromJson(e)).toList();
    muscles.sort((a, b) => a.id.compareTo(b.id),);
    return exercises;
  }
  Future<void> exercisesToMap() async{
    musclesExercise ={};
    emit(AppLoadingState());
    for(Muscles muscle in muscles){
      musclesExercise[muscle] = exercises.where((element) {
        return element.muscles.isNotEmpty && element.muscles.first.name == muscle.name;
      }).toList();
    }
    emit(AssetsLoadedState());
  }
  void changeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }
}
