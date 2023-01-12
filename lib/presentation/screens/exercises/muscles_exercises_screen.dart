import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:workout_log/constants/screens.dart';
import 'package:workout_log/data/exercise.dart';
import 'package:workout_log/data/exercise_view_model.dart';
import 'package:workout_log/presentation/styles/colors.dart';

import '../../widgets/default_text.dart';

class MusclesExercisesScreen extends StatelessWidget {
  const MusclesExercisesScreen({
    Key? key,
    required this.model,
  }) : super(key: key);
  final ExerciseViewModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(model.muscle.nameEn),
        backgroundColor: darkSkyBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultText(
                text: 'Exercises works ${model.muscle.nameEn} (mainly)',
                color: darkSkyBlue,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  ExerciseTile(exercise: model.mainExercises.elementAt(index)),
              itemCount: model.mainExercises.length,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultText(
                text: 'Exercises works ${model.muscle.nameEn} (secondary)',
                color: darkSkyBlue,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  ExerciseTile(exercise: model.secondaryExercises.elementAt(index)),
              itemCount: model.secondaryExercises.length,
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context)
            .pushNamed(exerciseDetailsScreen, arguments: exercise);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
        child: DefaultText(
          text: exercise.name,
          fontSize: 14.sp,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
