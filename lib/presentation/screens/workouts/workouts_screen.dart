import 'package:flutter/material.dart';
import 'package:workout_log/constants/screens.dart';
class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Center(child: InkWell(
      onTap: (){
        Navigator.of(context)
            .pushNamed(addWorkoutScreen);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.add),
          Text('Add A Workout')
        ],
      ),
    ),);
  }
}
