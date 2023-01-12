import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:workout_log/presentation/views/set_input_column.dart';
import 'package:workout_log/presentation/widgets/default_material_button.dart';
import 'package:workout_log/presentation/widgets/default_text_button.dart';

import '../../business_logic/app_cubit.dart';
import '../../business_logic/workout/workout_cubit.dart';
import '../../constants/screens.dart';
import '../../data/exercise.dart';
import '../../data/hive/exercise_set.dart';
import '../../data/hive/workout_exercise.dart';
import '../styles/colors.dart';
import '../widgets/default_text.dart';

class ExerciseTile extends StatefulWidget {
  const ExerciseTile({Key? key, required this.exercise, required this.index})
      : super(key: key);
  final WorkoutExercise exercise;
  final int index;
  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  late bool adding;
  late WorkoutCubit workoutCubit;
  var formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  @override
  void initState() {
    adding =false;
    workoutCubit = WorkoutCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
      workoutCubit.removeExercise(workoutExercise: widget.exercise);
      },
      key: Key(widget.exercise.timeStamp),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: darkSkyBlue,
        child: Row(
          children: [
            Container(
              color: darkSkyBlue,
              child: Icon(Icons.delete_outline,size: 10.h,color: Colors.white,),
            ),
            DefaultText(text: 'Remove Exercise',fontWeight: FontWeight.w300,textAlign: TextAlign.center,fontSize: 16.sp,color: Colors.white,)
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: Material(
          elevation: 20.sp,
          borderRadius: BorderRadius.circular(20.sp),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      text: '${widget.index + 1}. ${widget.exercise.exerciseName}',
                      fontWeight: FontWeight.w400,
                      color: darkSkyBlue,
                      fontSize: 12.sp,
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Exercise exercise =AppCubit.get(context).exercises.where((element) => element.id == widget.exercise.exerciseId).first;
                          Navigator.of(context)
                              .pushNamed(exerciseDetailsScreen, arguments: exercise);
                        }, icon: const Icon(Icons.info_outline)),
                        IconButton(onPressed: (){workoutCubit.removeExercise(workoutExercise: widget.exercise);}, icon: const Icon(Icons.delete)),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Visibility(
                  visible:workoutCubit.workoutExercises.where((element) => element ==widget.exercise).first.sets.isNotEmpty ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: setsWidgets(widget.exercise),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Visibility(
                  visible: adding,
                  replacement: DefaultMaterialButton(
                    width: 25.w,
                    backgroundColor: Colors.white.withOpacity(0.9),
                    onPressed: () {
                      adding =true;
                      setState(() { });
                    },
                    child: const DefaultText(
                      text: 'Add Set',
                      color: darkSkyBlue,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultText(
                        text: 'Set',
                        fontWeight: FontWeight.w600,
                        color: darkSkyBlue,
                        fontSize: 14.sp,
                      ),
                      Form(
                        key: formKey,
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SetInputColumn(
                                  controller: weightController,
                                  labelText: 'Weight'),
                              SizedBox(
                                width: 2.w,
                              ),
                              SetInputColumn(
                                controller: repsController,
                                labelText: 'Reps',
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    workoutCubit.addSetToExercise(
                                      exercise: widget.exercise,
                                      exerciseSet: ExerciseSet(
                                        id: DateTime.now().millisecondsSinceEpoch,
                                        weight:
                                            double.parse(weightController.text),
                                        reps: int.parse(repsController.text),
                                      ),
                                    );
                                    repsController.clear();
                                    weightController.clear();
                                    adding =false;
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 15.sp),
                                  child: Icon(
                                    Icons.add_box_rounded,
                                    color: darkSkyBlue,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() { adding =false; });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 15.sp),
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                    size: 25.sp,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> setsWidgets(WorkoutExercise exercise) {
    List<Widget> widgets = [];
    int setNumber = 1;
    List<ExerciseSet> thisSets =workoutCubit.workoutExercises.where((element) => element ==exercise).first.sets;
    for (ExerciseSet set in thisSets) {
      TextEditingController weightController=TextEditingController(text: set.weight.toString());
      TextEditingController repsController=TextEditingController(text: set.reps.toString());
      widgets.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            text: 'Set $setNumber',
            fontWeight: FontWeight.w600,
            color: darkSkyBlue,
            fontSize: 14.sp,
          ),
          Row(
            children: [
              Column(
                children: [
                  const DefaultText(
                    text: 'Weight',
                    fontWeight: FontWeight.w300,
                    color: darkSkyBlue,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  DefaultText(
                    text: set.weight.toString(),
                    fontWeight: FontWeight.w300,
                    color: darkSkyBlue,
                  )
                ],
              ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                children: [
                  const DefaultText(
                    text: 'Reps',
                    fontWeight: FontWeight.w300,
                    color: darkSkyBlue,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  DefaultText(
                    text: set.reps.toString(),
                    fontWeight: FontWeight.w300,
                    color: darkSkyBlue,
                  )
                ],
              ),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>  AlertDialog(

                      title: const Text('Edit Set'),
                      content:SizedBox(
                        height: 10.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SetInputColumn(controller: weightController, labelText: 'Weight'),
                            SizedBox(width: 2.w,),
                            SetInputColumn(controller: repsController, labelText: 'Reps'),
                            DefaultTextButton(onPressed: (){
                              if(weightController.text.isEmpty || weightController.text == '0' ||repsController.text.isEmpty || repsController.text == '0' ){
                                Fluttertoast.showToast(
                                    msg: "Weight and Reps can't be empty or zero",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white38,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }else{
                                set.weight=double.parse(weightController.text);
                                set.reps=int.parse(repsController.text);
                                Navigator.pop(context);
                                setState(() {});
                              }
                            }, child: const DefaultText(text: 'Save',)),
                            DefaultTextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: const DefaultText(text: 'Cancel',))
                          ],
                        ),
                      ),
                    ),);
                },
                child: Container(
                  padding: EdgeInsets.only(top: 15.sp),
                  child: Icon(
                    Icons.edit,
                    color: darkSkyBlue,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {
                  exercise.sets.remove(set);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.only(top: 15.sp),
                  child: Icon(
                    Icons.delete,
                    color: darkSkyBlue,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          )
        ],
      ));
      widgets.add(Divider(height: 2.h,color: darkSkyBlue,));
      setNumber++;
    }
    return widgets;
  }
}
