
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/modal_sheet/modal_cubit.dart';
import '../../business_logic/workout/workout_cubit.dart';
import '../../constants/screens.dart';
import '../../data/exercise.dart';
import '../../data/hive/workout_exercise.dart';
import '../styles/colors.dart';
import '../widgets/default_text.dart';

class AddExerciseModalSheet extends StatefulWidget {
  AddExerciseModalSheet({
    Key? key,
    required this.muscles,
  }) : super(key: key);
  final List<DropdownMenuItem<Object>> muscles;
  @override
  State<AddExerciseModalSheet> createState() => _AddExerciseModalSheet();
}

class _AddExerciseModalSheet extends State<AddExerciseModalSheet> {
  late WorkoutCubit workoutCubit;
  late ModalCubit modalCubit;
  @override
  void initState() {
    modalCubit=ModalCubit.get(context);
    workoutCubit =WorkoutCubit.get(context);
    super.initState();
  }

  @override
  void dispose() {
    modalCubit.muscleSelected=false;
    super.dispose();
  }

  List<DropdownMenuItem<Object>> getExercises(List<Exercise> exercises) {
    late WorkoutExercise workoutExercise;
    List<DropdownMenuItem<Object>> widgets = [];
    for (Exercise exercise in exercises) {
      widgets.add(DropdownMenuItem(
        onTap: () {
          workoutExercise = WorkoutExercise(
              id: DateTime.now().millisecondsSinceEpoch,
              exerciseName: exercise.name,
              exerciseId: exercise.id as int,
              timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
              sets: []);
          workoutCubit.addExercise(workoutExercise: workoutExercise);
          modalCubit.muscleSelected = false;
          Navigator.pop(context);
          setState(() {});
        },
        value: exercise.id,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 70.w,
              child: DefaultText(
                text: exercise.name,
                fontSize: 14.sp,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: () => {
                Navigator.of(context)
                    .pushNamed(exerciseDetailsScreen, arguments: exercise)
              },
              icon: Icon(
                (Icons.info_outline),
              ),
            )
          ],
        ),
      ));
    }
    return widgets;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModalCubit, ModalState>(
      builder: (context, state) {
        return SizedBox(
          height: 25.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: DropdownButtonFormField(
                  menuMaxHeight: 50.h,
                  dropdownColor: Colors.white,
                  hint:  DefaultText(
                    text: 'Select Muscle',
                    color: darkSkyBlue,
                    fontSize: 16.sp,
                  ),
                  style: const TextStyle(color: Colors.black),
                  items: widget.muscles,
                  onChanged: (Object? value) {},
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Visibility(
                visible: modalCubit.muscleSelected,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: DropdownButtonFormField(
                    menuMaxHeight: 50.h,
                    dropdownColor: Colors.white,
                    hint:  DefaultText(
                      text: 'Select Exercise',
                      color: darkSkyBlue,
                      fontSize: 16.sp,
                    ),
                    style: const TextStyle(color: Colors.black),
                    items: getExercises(modalCubit.muscleExercises),
                    onChanged: (Object? value) {},
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                    onTap: () {
                      modalCubit.muscleSelected = false;
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: DefaultText(
                        text: 'Cancel',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}