import 'package:flutter/material.dart';
import 'package:workout_log/data/exercise.dart';
class MusclesExercisesScreen extends StatelessWidget {
  const MusclesExercisesScreen({Key? key, required this.musclesExercises}) : super(key: key);
  final Map<Muscles,List<Exercise>> musclesExercises;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(musclesExercises.keys.elementAt(0).nameEn),
      ),
      body: Center(
        child: Text(musclesExercises.keys.elementAt(0).nameEn),
      ),
    );
  }
}
