import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:workout_log/business_logic/app_cubit.dart';
import 'package:workout_log/data/hive/workout.dart';
import 'package:workout_log/presentation/styles/colors.dart';
import 'package:workout_log/presentation/widgets/default_material_button.dart';
import '../../../business_logic/modal_sheet/modal_cubit.dart';
import '../../../business_logic/workout/workout_cubit.dart';
import '../../../constants/screens.dart';
import '../../../data/exercise.dart';
import '../../../data/hive/workout_exercise.dart';
import '../../views/add_exercise_modal_sheet.dart';
import '../../views/exercise_tile.dart';
import '../../widgets/default_text.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  late AppCubit cubit;
  late WorkoutCubit workoutCubit;
  late List<Muscles> muscles;
  late List<WorkoutExercise> workoutExercises;
  late int id;
  late int listLength;
  late bool isSaving;
  @override
  void initState() {
    cubit = AppCubit.get(context);
    muscles = cubit.muscles;
    id = DateTime.now().millisecondsSinceEpoch;
    workoutCubit = WorkoutCubit.get(context);
    workoutExercises = workoutCubit.workoutExercises;
    listLength = workoutCubit.workoutExercises.length;
    isSaving = false;
    super.initState();
  }

  @override
  void dispose() {
    if (listLength != workoutCubit.workoutExercises.length && !isSaving) {
      String workoutName = DateFormat.yMMMEd().format(DateTime.now());
      Workout workout = Workout(
          id: id,
          timeStamp: id.toString(),
          name: workoutName,
          exercises: workoutCubit.workoutExercises);
      workoutCubit.addWorkout(workout);
      workoutCubit.clear();
      Fluttertoast.showToast(
          msg: "Changes Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      super.dispose();
    } else {
      workoutCubit.clear();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    workoutCubit.getWorkouts();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkSkyBlue,
        title: const Text('Add Workout'),
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutLoadingState) {
            return SizedBox(
              width: 100.w,
              height: 85.h,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: darkSkyBlue,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Visibility(
              visible: workoutCubit.workoutExercises.isNotEmpty,
              replacement: Center(
                child: InkWell(
                  onTap: () {
                    buildShowModalBottomSheet(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        color: darkSkyBlue,
                        size: 50.sp,
                      ),
                      DefaultText(
                        text: 'Add Exercise',
                        fontSize: 20.sp,
                        color: darkSkyBlue,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ExerciseTile(
                          exercise:
                              workoutCubit.workoutExercises.elementAt(index),
                          index: index),
                      itemCount: workoutCubit.workoutExercises.length,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                      child: DefaultMaterialButton(
                        backgroundColor: darkSkyBlue,
                        width: 50.w,
                        onPressed: () {
                          String workoutName =
                              DateFormat.yMMMEd().format(DateTime.now());
                          Workout workout = Workout(
                              id: id,
                              timeStamp: id.toString(),
                              name: workoutName,
                              exercises: workoutCubit.workoutExercises);
                          workoutCubit.addWorkout(workout);
                          workoutCubit.clear();
                          isSaving = true;
                          Navigator.pop(context);
                        },
                        child: const DefaultText(
                          text: 'Save Workout',
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          buildShowModalBottomSheet(context);
        },
        backgroundColor: darkSkyBlue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    ModalCubit modalCubit = ModalCubit.get(context);

    List<DropdownMenuItem<Object>> getMuscles() {
      List<DropdownMenuItem<Object>> widgets = [];
      for (Muscles muscle in muscles) {
        widgets.add(DropdownMenuItem(
            onTap: () {
              modalCubit.selectMuscle(muscle, cubit.musclesExercise[muscle]!);
            },
            value: muscle.id,
            child: DefaultText(
              text: muscle.nameEn,
              fontSize: 16.sp,
            )));
      }
      return widgets;
    }

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddExerciseModalSheet(
          muscles: getMuscles(),
        );
      },
    );
  }
}

