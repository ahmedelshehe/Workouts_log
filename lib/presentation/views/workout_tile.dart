import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/workout/workout_cubit.dart';
import '../../constants/screens.dart';
import '../../data/hive/workout.dart';
import '../styles/colors.dart';
import '../widgets/default_text.dart';
import '../widgets/default_text_button.dart';

class WorkoutTile extends StatelessWidget {
  const WorkoutTile({
    Key? key, required this.workout,

  }) : super(key: key);

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    DateTime date =DateTime.fromMillisecondsSinceEpoch(workout.id);
    String timeMinutes=date.minute>= 9 ? date.minute.toString() : '0${date.minute}';
    String timeHour =date.hour.toString();
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        color: darkSkyBlue,
        child: Row(
          children: [
            Container(
              color: darkSkyBlue,
              child: Icon(Icons.delete_outline,size: 10.h,color:Colors.white ,),
            ),
            DefaultText(text: 'Remove Workout',fontWeight: FontWeight.w400,textAlign: TextAlign.center,fontSize: 16.sp,color: Colors.white,)
          ],
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: DefaultText(
                  text: 'Remove Workout',
                  fontSize: 16.sp,
                  color: darkSkyBlue,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.center,
                ),
                actions: [
                  DefaultTextButton(
                      onPressed: (){
                        WorkoutCubit.get(context).removeWorkout(workout);
                        Navigator.of(context).pop(true);
                      },
                      child:DefaultText(
                        text: 'Yes',
                        fontSize: 16.sp,
                        color: darkSkyBlue,
                        fontWeight: FontWeight.w300,
                        textAlign: TextAlign.center,
                      ) ),
                  DefaultTextButton(
                      onPressed: (){
                        Navigator.of(context).pop(false);
                      },
                      child:DefaultText(
                        text: 'No',
                        fontSize: 16.sp,
                        color: darkSkyBlue,
                        fontWeight: FontWeight.w300,
                        textAlign: TextAlign.center,
                      ) )
                ],
              )
          ,);
      },
      key: Key(workout.timeStamp),
      child: InkWell(
        onTap: (){
          Navigator.of(context)
              .pushNamed(workoutDetailsScreen,arguments: workout);
        },
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      text: workout.name,
                      fontSize: 16.sp,
                      color: darkSkyBlue,
                      fontWeight: FontWeight.w300,
                    ),
                    const Spacer(),
                    DefaultText(
                      text: '$timeHour : $timeMinutes',
                      fontSize: 16.sp,
                      color: darkSkyBlue,
                      fontWeight: FontWeight.w300,
                    ),
                    IconButton(onPressed: (){
                      showDialog(context: context,
                        builder: (context) =>
                          AlertDialog(
                            title: DefaultText(
                              text: 'Remove Workout',
                              fontSize: 16.sp,
                              color: darkSkyBlue,
                              fontWeight: FontWeight.w300,
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              DefaultTextButton(
                                  onPressed: (){
                                    WorkoutCubit.get(context).removeWorkout(workout);
                                    Navigator.pop(context);

                                  },
                                  child:DefaultText(
                                    text: 'Yes',
                                    fontSize: 16.sp,
                                    color: darkSkyBlue,
                                    fontWeight: FontWeight.w300,
                                    textAlign: TextAlign.center,
                                  ) ),
                              DefaultTextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child:DefaultText(
                                    text: 'No',
                                    fontSize: 16.sp,
                                    color: darkSkyBlue,
                                    fontWeight: FontWeight.w300,
                                    textAlign: TextAlign.center,
                                  ) )
                            ],
                          )
                        ,);
                    }, icon: Icon(Icons.close,size: 20.sp,),color: lightNetflixRed,)
                  ],
                ),
                DefaultText(text: 'No. of Exercise ${workout.exercises.length}',color: darkSkyBlue,fontSize: 12.sp,fontWeight: FontWeight.w200,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}