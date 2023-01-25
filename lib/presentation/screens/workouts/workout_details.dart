import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:workout_log/business_logic/workout/workout_cubit.dart';

import '../../../business_logic/app_cubit.dart';
import '../../../business_logic/modal_sheet/modal_cubit.dart';
import '../../../data/exercise.dart';
import '../../../data/hive/workout.dart';
import '../../../data/hive/workout_exercise.dart';
import '../../styles/colors.dart';
import '../../views/add_exercise_modal_sheet.dart';
import '../../views/exercise_tile.dart';
import '../../widgets/default_material_button.dart';
import '../../widgets/default_text.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  const WorkoutDetailsScreen({Key? key, required this.workout}) : super(key: key);
  final Workout workout;
  @override
  State<WorkoutDetailsScreen> createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  late AppCubit cubit;
  late WorkoutCubit workoutCubit;
  late List<Exercise> exercises;
  late List<Muscles> muscles;
  late int id;
  late int listLength;
  late bool isSaving;

  @override
  void initState() {
    id = DateTime.now().millisecondsSinceEpoch;
    cubit = AppCubit.get(context);
    exercises = cubit.exercises;
    muscles =cubit.muscles;
    workoutCubit = WorkoutCubit.get(context);
    if(widget.workout.exercises.isNotEmpty){
      workoutCubit.addExerciseIntoCubit(widget.workout.exercises);
    }
    listLength =workoutCubit.workoutExercises.length;
    isSaving =false;
    super.initState();
  }

  @override
  void dispose() {
    if(listLength != workoutCubit.workoutExercises.length && !isSaving){
      Workout workout =Workout(id: widget.workout.id, timeStamp: widget.workout.timeStamp, name:widget.workout.name, exercises: workoutCubit.workoutExercises);
      workoutCubit.removeWorkout(widget.workout);
      workoutCubit.addWorkout(workout);
      workoutCubit.clear();
      Fluttertoast.showToast(
          msg: "Changes Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      super.dispose();
    }else{
      workoutCubit.clear();
      super.dispose();
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.name),
        centerTitle: true,
        backgroundColor: darkSkyBlue,
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          if(state is WorkoutLoadingState){
            return const CircularProgressIndicator();
          }else {
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
                      Icon(Icons.add,color: darkSkyBlue,size: 50.sp,),
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
              child:SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics:const NeverScrollableScrollPhysics(),
                      itemBuilder:(context, index) =>  ExerciseTile( exercise: workoutCubit.workoutExercises.elementAt(index),index: index),
                      itemCount: workoutCubit.workoutExercises.length,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 5.h,top: 5.h),
                      child: DefaultMaterialButton(
                        backgroundColor: darkSkyBlue,
                        width: 50.w,
                        onPressed: (){
                          Workout workout =Workout(id: widget.workout.id, timeStamp: widget.workout.timeStamp, name:widget.workout.name, exercises: workoutCubit.workoutExercises);
                          workoutCubit.removeWorkout(widget.workout);
                          workoutCubit.addWorkout(workout);
                          workoutCubit.clear();
                          isSaving=true;
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
              ) ,
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
  List<DropdownMenuItem<Object>> getExercises(List<Exercise> exercises) {
    late WorkoutExercise workoutExercise;
    List<DropdownMenuItem<Object>> widgets = [];
    for (Exercise exercise in exercises) {
      widgets.add(DropdownMenuItem(
        onTap: (){
          workoutExercise =WorkoutExercise(
              id: id,
              exerciseName: exercise.name,
              exerciseId: exercise.id as int,
              timeStamp: DateTime.now()
                  .millisecondsSinceEpoch
                  .toString(), sets: []
          );
          workoutCubit.addExercise(workoutExercise: workoutExercise);
          Navigator.pop(context);
          setState(() {});
        },
        value: exercise.id,
        child: DefaultText(text:exercise.name,fontSize: 11.sp,),
      ));
    }
    return widgets;
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
