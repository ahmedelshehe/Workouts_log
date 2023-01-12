import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_log/business_logic/workout/workout_cubit.dart';
import '../../views/empty_list_widget.dart';
import '../../views/workout_tile.dart';
class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  late WorkoutCubit workoutCubit;
  @override
  void initState() {
    workoutCubit =WorkoutCubit.get(context);
    workoutCubit.getWorkouts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<WorkoutCubit,WorkoutState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Visibility(
            visible: workoutCubit.workouts.isNotEmpty,
            replacement: const EmptyListWidget(),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder:
                  (context, index) {
                    return WorkoutTile(workout: workoutCubit.workouts.elementAt(index));
                  },
                  itemCount: workoutCubit.workouts.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




