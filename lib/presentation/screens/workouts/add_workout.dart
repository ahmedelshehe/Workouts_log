import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:workout_log/business_logic/app_cubit.dart';
import 'package:workout_log/presentation/styles/colors.dart';
import 'package:workout_log/presentation/widgets/default_material_button.dart';
import '../../../business_logic/workout/workout_cubit.dart';
import '../../../data/exercise.dart';
import '../../../data/exercise_set.dart';
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
  late List<Exercise> exercises;
  late List<WorkoutExercise> workoutExercises;
  late int id;
  late Map<WorkoutExercise,List<ExerciseSet>> workoutExercisesSets;
  @override
  void initState() {
    cubit = AppCubit.get(context);
    exercises = cubit.exercises;
    id = DateTime.now().millisecondsSinceEpoch;
    workoutCubit =WorkoutCubit.get(context);
    workoutExercises = workoutCubit.workoutExercises;
    workoutExercisesSets =workoutCubit.workoutExercisesSets;
    exercises.sort(
      (a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkSkyBlue,
        title: const Text('Add Workout'),
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
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 15.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding:  EdgeInsets.symmetric(horizontal: 5.w),
                              child: DropdownButtonFormField(
                                menuMaxHeight: 40.h,
                                dropdownColor: darkSkyBlue.withOpacity(0.6),
                                hint: const DefaultText(text: 'Select Exercise',color: darkSkyBlue,),
                                style: const TextStyle(color: Colors.black),
                                items: getExercises(exercises), onChanged: (Object? value) {  },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [Icon(Icons.add), Text('Add An Exercise')],
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
                      onPressed: (){},
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
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 15.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding:  EdgeInsets.symmetric(horizontal: 5.w),
                      child: DropdownButtonFormField(
                        menuMaxHeight: 40.h,
                        dropdownColor: darkSkyBlue.withOpacity(0.6),
                        hint: const DefaultText(text: 'Select Exercise',color: darkSkyBlue,),
                        style: const TextStyle(color: Colors.black),
                        items: getExercises(exercises), onChanged: (Object? value) {  },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
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
                  .toString());
          workoutCubit.addExercise(workoutExercise: workoutExercise);
          Navigator.pop(context);
          setState(() {});
          },
        value: exercise.id,
        child: Text(exercise.name),
      ));
    }
    return widgets;
  }
}





