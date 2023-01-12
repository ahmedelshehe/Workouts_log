import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:workout_log/data/hive/exercise_set.dart';
import 'package:workout_log/data/hive/workout_exercise.dart';
import 'package:workout_log/presentation/router/app_router.dart';
import 'business_logic/app_cubit.dart';
import 'business_logic/workout/workout_cubit.dart';
import 'constants/bloc_observer.dart';
import 'package:flutter/services.dart';

import 'data/hive/workout.dart';

late Box box;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(ExerciseSetAdapter());
  Hive.registerAdapter(WorkoutExerciseAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  box =await Hive.openBox('workouts');
  if(box.get('first_time') == null){
    List dbWorkouts =[];
    box.put('workouts', dbWorkouts);
    box.put('first_time', true);
  }
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AppRouter appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => WorkoutCubit(),
        ),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Workouts Log',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
        );
      }),
    );
  }
}
