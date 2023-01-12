import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_log/presentation/screens/exercises/muscles_exercises_screen.dart';
import 'package:workout_log/presentation/styles/colors.dart';

import '../../../business_logic/app_cubit.dart';

class SearchExerciseScreen extends StatefulWidget {
  const SearchExerciseScreen({Key? key}) : super(key: key);

  @override
  State<SearchExerciseScreen> createState() => _SearchExerciseScreenState();
}

class _SearchExerciseScreenState extends State<SearchExerciseScreen> {
  late AppCubit cubit;
  late bool isSearchTermEmpty;

  @override
  void initState() {
    cubit = AppCubit.get(context);
    isSearchTermEmpty = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if(state is SearchingExerciseState){
          return Center(child: CircularProgressIndicator(color: darkSkyBlue,),);
        }else if(state is SearchResultsLoaded){
          return ListView.builder(itemBuilder: (context, index) =>
              ExerciseTile(
                exercise: cubit.searchResults[index],
              ),
            itemCount: cubit.searchResults.length,
          );
        }else if(state is SearchTermCleared) {
          return Center(child: Text('Search Exercises'),);
        }else if(state is NoResultsFound){
          return Center(child: Text('No Results found'),);
        }else {
          return Center(child: Text('Search Exercises'),);
        }
      },
    );
  }
}
