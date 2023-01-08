import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:workout_log/business_logic/app_cubit.dart';
import 'package:workout_log/constants/screens.dart';
import 'package:workout_log/data/exercise.dart';
import 'package:workout_log/presentation/styles/colors.dart';
import 'package:workout_log/presentation/widgets/default_error_widget.dart';
import 'package:workout_log/presentation/widgets/default_svg.dart';

import '../../widgets/default_text.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> with TickerProviderStateMixin {
  late AppCubit cubit;
  late final AnimationController controller;
  late final Animation<double> animation;
  Future<void> getAssets () async{
    await cubit.readJson();
    await cubit.exercisesToMap();
  }
  @override
  void initState() {
    controller =AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500)
    )..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    cubit = AppCubit.get(context);
    getAssets();
    super.initState();
  }
  @override
  void dispose() {
    controller.stop(canceled: true);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state is AssetsLoadedState || state is AppChangeBottomNavBarState)
        {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20.sp)
                ),
                child: InkWell(
                  onTap: (){
                    Map<Muscles,List<Exercise>> map ={
                      cubit.musclesExercise.keys.elementAt(index) : cubit.musclesExercise.values.elementAt(index)
                    };
                    Navigator.of(context).pushNamed(musclesExercisesScreen,arguments:map );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultText(
                          text: cubit.musclesExercise.keys.elementAt(index).nameEn,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        FadeTransition(
                          opacity: animation,
                          child: Stack(
                            children:  [
                              Visibility(
                                visible: cubit.musclesExercise.keys.elementAt(index).isFront,
                                replacement: DefaultSVG(height: 85.sp,
                                    imagePath:
                                    'assets/images/muscles/muscular_system_back.svg') ,
                                child:  DefaultSVG(height: 85.sp,
                                    imagePath:
                                    'assets/images/muscles/muscular_system_front.svg'),

                              ),
                              DefaultSVG(height: 85.sp,imagePath: cubit.musclesExercise.keys.elementAt(index).imageUrlMain)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: cubit.musclesExercise.length,
          );
        } else if(state is AppLoadingState)
        {
          return SizedBox(
            width: 100.w,
            height: 85.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.white,),
                ],
              ),
            ),
          );
        }
        else {
          return const DefaultErrorWidget();
        }

      }
    );
  }
}
